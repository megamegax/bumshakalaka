class TargetDto {
  final String imagePath;
  final String name;
  final int frameCount;
  final int imageWidth;
  final int imageHeight;

  TargetDto.fromJson(Map<String, dynamic> json)
      : imagePath = json["image_path"],
        name = json["name"],
        frameCount = json["frame_count"],
        imageWidth = json["image_width"],
        imageHeight = json["image_height"];

  TargetDto(this.imagePath, this.name, this.frameCount, this.imageWidth,
      this.imageHeight);

  Map<String, dynamic> toJson() {
    return {
      'image_path': imagePath,
      'name': name,
      'frame_count': frameCount,
      'image_width': imageWidth,
      'image_height': imageHeight
    };
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TargetDto &&
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
