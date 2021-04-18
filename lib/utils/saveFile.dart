import 'package:gallery_saver/gallery_saver.dart';
import 'package:statuskeeper/utils/constants.dart';

class Save {
  static Future<void> saveImage(String path) async {
    await GallerySaver.saveImage(path, albumName: Constants.albumName);
  }

  static Future<void> saveVideo(String path) async {
    await GallerySaver.saveVideo(path, albumName: Constants.albumName);
  }
}
