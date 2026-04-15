import '../../../domain/entities/video_entity.dart';

class VideoModel extends VideoEntity {
  VideoModel({
    required String id,
    required String name,
    required String inputPath,
    String? outputPath,
    required int fileSize,
    required Duration duration,
    ConversionStatus status = ConversionStatus.pending,
    double progress = 0.0,
    String? errorMessage,
    required DateTime createdAt,
  }) : super(
    id: id,
    name: name,
    inputPath: inputPath,
    outputPath: outputPath,
    fileSize: fileSize,
    duration: duration,
    status: status,
    progress: progress,
    errorMessage: errorMessage,
    createdAt: createdAt,
  );

  factory VideoModel.fromJson(Map<String, dynamic> json) {
    return VideoModel(
      id: json['id'] as String,
      name: json['name'] as String,
      inputPath: json['inputPath'] as String,
      outputPath: json['outputPath'] as String?,
      fileSize: json['fileSize'] as int,
      duration: Duration(milliseconds: json['durationMs'] as int),
      status: ConversionStatus.values[json['status'] as int? ?? 0],
      progress: (json['progress'] as num?)?.toDouble() ?? 0.0,
      errorMessage: json['errorMessage'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'inputPath': inputPath,
      'outputPath': outputPath,
      'fileSize': fileSize,
      'durationMs': duration.inMilliseconds,
      'status': status.index,
      'progress': progress,
      'errorMessage': errorMessage,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  VideoModel copyWith({
    String? id,
    String? name,
    String? inputPath,
    String? outputPath,
    int? fileSize,
    Duration? duration,
    ConversionStatus? status,
    double? progress,
    String? errorMessage,
    DateTime? createdAt,
  }) {
    return VideoModel(
      id: id ?? this.id,
      name: name ?? this.name,
      inputPath: inputPath ?? this.inputPath,
      outputPath: outputPath ?? this.outputPath,
      fileSize: fileSize ?? this.fileSize,
      duration: duration ?? this.duration,
      status: status ?? this.status,
      progress: progress ?? this.progress,
      errorMessage: errorMessage ?? this.errorMessage,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
