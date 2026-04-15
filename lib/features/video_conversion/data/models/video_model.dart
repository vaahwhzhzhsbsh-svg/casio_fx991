import 'package:flutter/foundation.dart';

enum ConversionStatus { initial, processing, completed, failed }

class VideoModel {
  final String id;
  final String name;
  final String inputPath;
  final String? outputPath;
  final String fileSize;
  final String duration;
  final ConversionStatus status;
  final double progress;
  final String? errorMessage;
  final DateTime createdAt;

  VideoModel({
    required this.id,
    required this.name,
    required this.inputPath,
    this.outputPath,
    required this.fileSize,
    required this.duration,
    this.status = ConversionStatus.initial,
    this.progress = 0.0,
    this.errorMessage,
    required this.createdAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'inputPath': inputPath,
      'outputPath': outputPath,
      'fileSize': fileSize,
      'duration': duration,
      'status': status.name,
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
    String? fileSize,
    String? duration,
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
