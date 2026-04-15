import 'dart:isolate';
import 'package:ffmpeg_kit_flutter_full_gpl/ffmpeg_kit.dart';
import 'package:ffmpeg_kit_flutter_full_gpl/return_code.dart';
import '../models/video_model.dart';
import '../../domain/entities/video_entity.dart';
import '../../../core/constants/app_constants.dart';

class ConversionService {
  static Future<void> convertVideoIsolated(VideoConversionParams params) async {
    final receivePort = ReceivePort();
    
    await Isolate.spawn(
      _isolateConversionTask,
      params.copyWith(sendPort: receivePort.sendPort),
      errorsAreFatal: true,
      onError: receivePort.sendPort,
    );

    final result = await receivePort.first;
    if (result is Exception) throw result;
    params.onProgress?.call(result as VideoModel);
  }

  static Future<void> _isolateConversionTask(VideoConversionParams params) async {
    try {
      final outputPath = 
        '$kOutputDir/${params.video.name.replaceAll('.mp4', '')}.3gp';

      final command = 
        '-i "${params.video.inputPath}" '
        '$kItelFlags '
        '-y "$outputPath"';

      final session = await FFmpegKit.executeAsync(
        command,
        onProgress: (statistics) {
          final duration = params.video.duration.inMilliseconds;
          final time = statistics.getTime();
          final progress = duration > 0 ? (time / duration).clamp(0.0, 1.0) : 0.0;
          
          final updated = params.video.copyWith(
            status: ConversionStatus.converting,
            progress: progress,
          );
          params.sendPort?.send(updated);
        },
      );

      final returnCode = await session.getReturnCode();

      if (ReturnCode.isSuccess(returnCode)) {
        final completed = params.video.copyWith(
          status: ConversionStatus.completed,
          progress: 1.0,
          outputPath: outputPath,
        );
        params.sendPort?.send(completed);
      } else {
        final failed = params.video.copyWith(
          status: ConversionStatus.failed,
          errorMessage: 'FFmpeg error: ${await session.getOutput()}',
        );
        params.sendPort?.send(failed);
      }
    } catch (e) {
      params.sendPort?.send(Exception('Conversion error: $e'));
    }
  }
}

class VideoConversionParams {
  final VideoModel video;
  final SendPort? sendPort;
  final Function(VideoModel)? onProgress;

  VideoConversionParams({
    required this.video,
    this.sendPort,
    this.onProgress,
  });

  VideoConversionParams copyWith({
    VideoModel? video,
    SendPort? sendPort,
    Function(VideoModel)? onProgress,
  }) {
    return VideoConversionParams(
      video: video ?? this.video,
      sendPort: sendPort ?? this.sendPort,
      onProgress: onProgress ?? this.onProgress,
    );
  }
}
