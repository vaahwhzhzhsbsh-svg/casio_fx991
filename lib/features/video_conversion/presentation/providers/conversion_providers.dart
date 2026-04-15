import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:async';
import '../../domain/entities/video_entity.dart';
import '../models/video_model.dart';
import '../datasources/conversion_service.dart';
import '../../../core/constants/app_constants.dart';

// Video Queue Provider
final videoQueueProvider = 
  StateNotifierProvider<VideoQueueNotifier, List<VideoModel>>((ref) {
    return VideoQueueNotifier();
  });

class VideoQueueNotifier extends StateNotifier<List<VideoModel>> {
  VideoQueueNotifier() : super([]);

  void addVideo(VideoModel video) {
    if (state.length < kQueueLimit) {
      state = [...state, video];
    }
  }

  void addVideos(List<VideoModel> videos) {
    final remaining = kQueueLimit - state.length;
    if (remaining > 0) {
      state = [...state, ...videos.take(remaining)];
    }
  }

  void updateVideo(VideoModel video) {
    state = [
      for (final v in state)
        if (v.id == video.id) video else v
    ];
  }

  void removeVideo(String videoId) {
    state = state.where((v) => v.id != videoId).toList();
  }

  void clearCompleted() {
    state = state
        .where((v) => v.status != ConversionStatus.completed)
        .toList();
  }

  void clearAll() {
    state = [];
  }
}

// Active Conversions Provider
final activeConversionsProvider = 
  StateNotifierProvider<ActiveConversionsNotifier, Set<String>>((ref) {
    return ActiveConversionsNotifier();
  });

class ActiveConversionsNotifier extends StateNotifier<Set<String>> {
  ActiveConversionsNotifier() : super({});

  void add(String videoId) {
    if (state.length < kMaxConcurrentConversions) {
      state = {...state, videoId};
    }
  }

  void remove(String videoId) {
    state = state.where((id) => id != videoId).toSet();
  }

  bool isFull() => state.length >= kMaxConcurrentConversions;
}

// Conversion Queue Manager
final conversionQueueProvider = 
  StateNotifierProvider<ConversionQueueNotifier, ConversionQueueState>((ref) {
    return ConversionQueueNotifier(ref);
  });

class ConversionQueueNotifier extends StateNotifier<ConversionQueueState> {
  final Ref ref;
  Timer? _queueTimer;

  ConversionQueueNotifier(this.ref) 
    : super(const ConversionQueueState(isRunning: false));

  void startQueue() {
    if (state.isRunning) return;
    state = state.copyWith(isRunning: true);
    _processQueue();
  }

  void pauseQueue() {
    state = state.copyWith(isRunning: false);
    _queueTimer?.cancel();
  }

  void resumeQueue() {
    if (!state.isRunning) {
      state = state.copyWith(isRunning: true);
      _processQueue();
    }
  }

  Future<void> _processQueue() async {
    _queueTimer = Timer.periodic(const Duration(milliseconds: 500), (_) async {
      if (!state.isRunning) return;

      final queue = ref.read(videoQueueProvider);
      final activeIds = ref.read(activeConversionsProvider);
      final activeNotifier = ref.read(activeConversionsProvider.notifier);

      // Find next pending video
      final nextVideo = queue.firstWhere(
        (v) => v.status == ConversionStatus.pending && !activeIds.contains(v.id),
        orElse: () => null! as VideoModel,
      );

      if (nextVideo != null && !activeNotifier.isFull()) {
        activeNotifier.add(nextVideo.id);
        _convertVideo(nextVideo);
      }

      // Check if queue is done
      final allCompleted = queue.every((v) => 
        v.status == ConversionStatus.completed || 
        v.status == ConversionStatus.failed ||
        v.status == ConversionStatus.cancelled
      );

      if (allCompleted && activeIds.isEmpty) {
        pauseQueue();
        state = state.copyWith(totalProgress: 1.0);
      }
    });
  }

  Future<void> _convertVideo(VideoModel video) async {
    try {
      ref.read(videoQueueProvider.notifier).updateVideo(
        video.copyWith(status: ConversionStatus.converting)
      );

      await ConversionService.convertVideoIsolated(
        VideoConversionParams(
          video: video,
          onProgress: (updated) {
            ref.read(videoQueueProvider.notifier).updateVideo(updated);
            _updateProgress();
          },
        ),
      );
    } catch (e) {
      ref.read(videoQueueProvider.notifier).updateVideo(
        video.copyWith(
          status: ConversionStatus.failed,
          errorMessage: e.toString(),
        )
      );
    } finally {
      ref.read(activeConversionsProvider.notifier).remove(video.id);
    }
  }

  void _updateProgress() {
    final queue = ref.read(videoQueueProvider);
    if (queue.isEmpty) return;

    double totalProgress = 0;
    for (final v in queue) {
      if (v.status == ConversionStatus.completed) {
        totalProgress += 1.0;
      } else if (v.status == ConversionStatus.converting) {
        totalProgress += v.progress;
      }
    }

    final average = totalProgress / queue.length;
    state = state.copyWith(totalProgress: average);
  }

  @override
  void dispose() {
    _queueTimer?.cancel();
    super.dispose();
  }
}

class ConversionQueueState {
  final bool isRunning;
  final double totalProgress;

  const ConversionQueueState({
    required this.isRunning,
    this.totalProgress = 0.0,
  });

  ConversionQueueState copyWith({
    bool? isRunning,
    double? totalProgress,
  }) {
    return ConversionQueueState(
      isRunning: isRunning ?? this.isRunning,
      totalProgress: totalProgress ?? this.totalProgress,
    );
  }
}

// File Picker Provider
final filePickerProvider = FutureProvider<List<VideoModel>>((ref) async {
  final result = await FilePicker.platform.pickFiles(
    allowMultiple: true,
    type: FileType.video,
    allowedExtensions: ['mp4'],
  );

  if (result == null) return [];

  final videos = <VideoModel>[];
  for (final file in result.files) {
    if (file.path != null) {
      videos.add(VideoModel(
        id: DateTime.now().millisecondsSinceEpoch.toString() + file.name,
        name: file.name,
        inputPath: file.path!,
        fileSize: file.size,
        duration: const Duration(seconds: 0),
        createdAt: DateTime.now(),
      ));
    }
  }

  return videos;
});
