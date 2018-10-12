class TargetConfig {
  final String imagePath;
  final int frameCount;
  final int imageWidth;
  final int imageHeight;

  TargetConfig(
      this.imagePath, this.frameCount, this.imageWidth, this.imageHeight);

  TargetConfig.fromJson(Map<String, dynamic> json)
      : imagePath = json["image_path"],
        frameCount = json["frame_count"],
        imageWidth = json["image_width"],
        imageHeight = json["image_height"];
}
