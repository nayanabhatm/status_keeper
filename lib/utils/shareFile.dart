import 'package:share_extend/share_extend.dart';

class Share {
  static void share(String path, String type) async {
    ShareExtend.share(path, type, sharePositionOrigin: null);
  }

  static void shareMultiple(List<String> pathList, String type) async {
    ShareExtend.shareMultiple(pathList, type);
  }
}
