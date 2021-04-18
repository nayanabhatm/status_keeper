import 'dart:io';

class Constants {
  static const String permissionGranted = 'Granted';
  static const String permissionPermanentlyDenied = 'Permission Denied Forever';
  static const String permissionDenied = 'Permission Denied';
  static const String albumName = 'Status Keeper';
  static final Directory statusDirectory =
      Directory('/storage/emulated/0/WhatsApp/Media/.Statuses');
  static final Directory savedDirectory =
      Directory('/storage/emulated/0/Status Keeper');
  static const String images = 'Images';
}

enum StatusType {
  image,
  video,
  savedImage,
  savedVideo,
}
