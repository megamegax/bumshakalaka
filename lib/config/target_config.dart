class TargetConfig {
  final String imagePath;
  final String name;
  final int frameCount;
  final int imageWidth;
  final int imageHeight;

  TargetConfig(this.imagePath, this.name, this.frameCount, this.imageWidth,
      this.imageHeight);

  TargetConfig.fromJson(Map<String, dynamic> json)
      : imagePath = json["imagePath"],
        name = json["name"],
        frameCount = json["frameCount"],
        imageWidth = json["imageWidth"],
        imageHeight = json["imageHeight"];

  Map<String, dynamic> toJson() {
    return {
      'imagePath': imagePath,
      'name': name,
      'frameCount': frameCount,
      'imageWidth': imageWidth,
      'imageHeight': imageHeight
    };
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TargetConfig &&
          runtimeType == other.runtimeType &&
          imagePath == other.imagePath &&
          name == other.name &&
          frameCount == other.frameCount &&
          imageWidth == other.imageWidth &&
          imageHeight == other.imageHeight;

  @override
  int get hashCode =>
      imagePath.hashCode ^
      name.hashCode ^
      frameCount.hashCode ^
      imageWidth.hashCode ^
      imageHeight.hashCode;

  @override
  String toString() {
    return 'TargetConfig{imagePath: $imagePath, name: $name, frameCount: $frameCount, imageWidth: $imageWidth, imageHeight: $imageHeight}';
  }
}
