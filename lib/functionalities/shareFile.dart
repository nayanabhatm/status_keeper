import 'package:share_extend/share_extend.dart';

class ShareImageVideo{
  static void shareImageVideo(String path,String type) async{
    ShareExtend.share(path, type, sharePositionOrigin: null);
  }

  static void shareImageVideoMultiple(List<String> pathList, String type) async{
    ShareExtend.shareMultiple(pathList, type);
  }
}