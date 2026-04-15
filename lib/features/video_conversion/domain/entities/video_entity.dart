class VideoEntity {
  final String id;
  final String name;
  final String inputPath;
  final String? outputPath;
  final int fileSize;
  final Duration duration;
  final ConversionStatus status;
  final double progress;
  final String? errorMessage;
  final DateTime createdAt;

  VideoEntity({
    required this.id,
    required this.name,
    required this.inputPath,
    this.outputPath,
    required this.fileSize,
    required this.duration,
    this.status = ConversionStatus.pending,
    this.progress = 0.0,
    this.errorMessage,
    required this.createdAt,
  });

  VideoEntity copyWith({
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
    return VideoEntity(
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

enum ConversionStatus { pending, converting, completed, failed, cancelled }
