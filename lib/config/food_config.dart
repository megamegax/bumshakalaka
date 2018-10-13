class FoodConfig {
  final String imagePath;
  final String target;
  final int frameCount;
  final int imageWidth;
  final int imageHeight;

  FoodConfig(this.imagePath, this.target, this.frameCount, this.imageWidth,
      this.imageHeight);

  FoodConfig.fromJson(Map<String, dynamic> json)
      : imagePath = json["image_path"],
        frameCount = json["frame_count"],
        imageWidth = json["image_width"],
        imageHeight = json["image_height"],
        target = json["target"];

  Map<String, dynamic> toJson() {
    return {
      'image_path': imagePath,
      'target': target,
      'frame_count': frameCount,
      'image_width': imageWidth,
      'image_height': imageHeight
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
