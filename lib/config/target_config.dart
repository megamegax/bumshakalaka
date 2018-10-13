class TargetConfig {
  final String imagePath;
  final int frameCount;
  final int imageWidth;
  final int imageHeight;

  TargetConfig(
      this.imagePath, this.frameCount, this.imageWidth, this.imageHeight);

  TargetConfig.fromJson(Map<String, dynamic> json)
      : imagePath = json["imagePath"],
        frameCount = json["frameCount"],
        imageWidth = json["imageWidth"],
        imageHeight = json["imageHeight"];

  Map<String, dynamic> toJson() {
    return {
      'imagePath': imagePath,
      'frameCount': frameCount,
      'imageWidth': imageWidth,
      'imageHeight': imageHeight
    };
  }

  @override
  String toString() {
    return 'TargetConfig{imagePath: $imagePath, frameCount: $frameCount, imageWidth: $imageWidth, imageHeight: $imageHeight}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TargetConfig &&
          runtimeType == other.runtimeType &&
          imagePath == other.imagePath &&
          frameCount == other.frameCount &&
          imageWidth == other.imageWidth &&
          imageHeight == other.imageHeight;

  @override
  int get hashCode =>
      imagePath.hashCode ^
      frameCount.hashCode ^
      imageWidth.hashCode ^
      imageHeight.hashCode;
}
