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
}
