import 'dart:core';
import 'package:gallery_saver/gallery_saver.dart';

class SaveImageVideo{

  static Future<void> saveImage(String path) async{
    await GallerySaver.saveImage(path,albumName: 'Status Keeper');
  }

  static Future<void> saveVideo(String path) async{
    await GallerySaver.saveVideo(path,albumName: 'Status Keeper');
  }
}


