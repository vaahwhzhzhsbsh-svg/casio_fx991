class VideoConversionParams {
  final String inputPath;
  final String outputPath;
  final String format;
  final double? quality;

  VideoConversionParams({
    required this.inputPath,
    required this.outputPath,
    required this.format,
    this.quality,
  });
}
