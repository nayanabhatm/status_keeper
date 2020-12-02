import 'dart:typed_data';

import 'package:video_thumbnail/video_thumbnail.dart';

class StatusVideo {
  final String videoPath;
  bool isSelected;
  Future<Uint8List> bytes;

  StatusVideo({
    this.videoPath,
    this.isSelected = false,
  });

  void toggleIsSelected() {
    isSelected = !isSelected;
  }

  void resetIsSelected() {
    isSelected = false;
  }

  void setIsSelected() {
    isSelected = true;
  }

  void getVideoThumbnailBytes() {
    bytes = VideoThumbnail.thumbnailData(
      video: videoPath,
      imageFormat: ImageFormat.PNG,
      quality: 25,
    );
  }
}
