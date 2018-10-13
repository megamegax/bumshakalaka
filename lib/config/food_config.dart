class FoodConfig {
  final String imagePath;
  final String target;
  final int frameCount;
  final int imageWidth;
  final int imageHeight;

  FoodConfig(this.imagePath, this.target, this.frameCount, this.imageWidth,
      this.imageHeight);

  FoodConfig.fromJson(Map<String, dynamic> json)
      : imagePath = json["imagePath"],
        frameCount = json["frameCount"],
        imageWidth = json["imageWidth"],
        imageHeight = json["imageHeight"],
        target = json["target"];

  Map<String, dynamic> toJson() {
    return {
      'imagePath': imagePath,
      'target': target,
      'frameCount': frameCount,
      'imageWidth': imageWidth,
      'imageHeight': imageHeight
    };
  }

  @override
  String toString() {
    return 'FoodConfig{imagePath: $imagePath, target: $target, frameCount: $frameCount, imageWidth: $imageWidth, imageHeight: $imageHeight}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FoodConfig &&
          runtimeType == other.runtimeType &&
          imagePath == other.imagePath &&
          target == other.target &&
          frameCount == other.frameCount &&
          imageWidth == other.imageWidth &&
          imageHeight == other.imageHeight;

  @override
  int get hashCode =>
      imagePath.hashCode ^
      target.hashCode ^
      frameCount.hashCode ^
      imageWidth.hashCode ^
      imageHeight.hashCode;
}
