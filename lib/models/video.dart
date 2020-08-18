import 'dart:typed_data';
import 'package:video_thumbnail/video_thumbnail.dart';

class VideoFile{
  final String videoPath;
  bool isSelected;
  Future<Uint8List> bytes;

  VideoFile({this.videoPath,this.isSelected=false,});

  void toggleIsSelected(){
    isSelected=!isSelected;
  }

  void makeIsSelectedFalse(){
    isSelected=false;
  }

  void makeIsSelectedTrue(){
    isSelected=true;
  }

  void getVideoThumbnailBytes() {
    bytes= VideoThumbnail.thumbnailData(
      video: videoPath,
      imageFormat: ImageFormat.PNG,
      quality: 25,
    ) ;
  }

}