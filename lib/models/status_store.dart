import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:statuskeeper/models/image.dart';
import 'package:statuskeeper/models/video.dart';
import 'package:statuskeeper/utils/constants.dart';
import 'package:statuskeeper/utils/saveFile.dart';
import 'package:statuskeeper/utils/shareFile.dart';
import 'package:statuskeeper/utils/sortFiles.dart';

class StatusStore extends ChangeNotifier {
  bool _isSwitched = true;
  bool _isLongPress = false;
  bool _isSelectAll = false;
  int _currentTab = 0;

  List<StatusImage> _images = [];
  List<StatusVideo> _videos = [];
  List<StatusImage> _imagesSaved = [];
  List<StatusVideo> _videosSaved = [];

  bool get isSwitched => _isSwitched;
  int get getCurrentTab => _currentTab;
  bool get isLongPress => _isLongPress;
  bool get isSelectAll => _isSelectAll;
  int get imagesCount => _images.length;
  int get videosCount => _videos.length;
  int get imagesSavedCount => _imagesSaved.length;
  int get videosSavedCount => _videosSaved.length;
  List<StatusImage> get images => _images;
  List<StatusVideo> get videos => _videos;
  List<StatusImage> get imagesSaved => _imagesSaved;
  List<StatusVideo> get videosSaved => _videosSaved;

  void toggleIsSwitched(bool switchValue) {
    _isSwitched = switchValue;
    notifyListeners();
  }

  void updateCurrentTab(int currentTab) {
    _currentTab = currentTab;
    notifyListeners();
  }

  void resetLongPress() {
    _isLongPress = false;
    notifyListeners();
  }

  void toggleIsLongPress() {
    _isLongPress = !_isLongPress;
    notifyListeners();
  }

  void toggleIsSelectAll() {
    _isSelectAll = !_isSelectAll;
    notifyListeners();
  }

  void resetIsSelectAll() {
    _isSelectAll = false;
    notifyListeners();
  }

  void resetAll({StatusType type}) {
    resetLongPress();
    resetIsSelectAll();

    if (type != null) {
      resetIsSelected(type);
      clearAll(type);
      addFilesToList(type);
    } else {
      StatusType.values.forEach((element) async {
        resetIsSelected(element);
        clearAll(element);
        addFilesToList(element);
      });
    }
  }

  int countIsSelectedFiles(StatusType type) {
    int cnt = 0;
    if (type == StatusType.image) {
      _images.forEach((element) {
        if (element.isSelected) {
          cnt++;
        }
      });
    } else if (type == StatusType.video) {
      _videos.forEach((element) {
        if (element.isSelected) {
          cnt++;
        }
      });
    } else if (type == StatusType.savedImage) {
      _imagesSaved.forEach((element) {
        if (element.isSelected) {
          cnt++;
        }
      });
    } else if (type == StatusType.savedVideo) {
      _videosSaved.forEach((element) {
        if (element.isSelected) {
          cnt++;
        }
      });
    }
    return cnt;
  }

  void shareMultiple(StatusType type) {
    List<String> listOfAssetsToShare = [];
    if (type == StatusType.image) {
      _images.forEach((element) {
        if (element.isSelected) listOfAssetsToShare.add(element.imagePath);
      });
      Share.shareMultiple(listOfAssetsToShare, 'image');
    } else if (type == StatusType.video) {
      _videos.forEach((element) {
        if (element.isSelected) listOfAssetsToShare.add(element.videoPath);
      });
      Share.shareMultiple(listOfAssetsToShare, 'file');
    } else if (type == StatusType.savedImage) {
      _imagesSaved.forEach((element) {
        if (element.isSelected) listOfAssetsToShare.add(element.imagePath);
      });
      Share.shareMultiple(listOfAssetsToShare, 'image');
    } else if (type == StatusType.savedVideo) {
      _videosSaved.forEach((element) {
        if (element.isSelected) listOfAssetsToShare.add(element.videoPath);
      });
      Share.shareMultiple(listOfAssetsToShare, 'file');
    }
  }

  Future<void> save(String path, StatusType type) async {
    if (type == StatusType.image) {
      await Save.saveImage(path);
      resetAll(type: StatusType.savedImage);
    } else if (type == StatusType.video) {
      await Save.saveVideo(path);
      resetAll(type: StatusType.savedVideo);
    }
    notifyListeners();
  }

  Future<void> saveMultiple(StatusType type) async {
    if (type == StatusType.image) {
      for (int i = 0; i < _images.length; i++) {
        var element = _images[i];
        if (element.isSelected)
          try {
            await Save.saveImage(element.imagePath);
          } catch (e) {
            print(e);
          }
      }
      resetIsSelected(StatusType.image);
      resetAll(type: StatusType.savedImage);
    } else if (type == StatusType.video) {
      for (int i = 0; i < _videos.length; i++) {
        var element = _videos[i];
        if (element.isSelected)
          try {
            await Save.saveVideo(element.videoPath);
          } catch (e) {
            print(e);
          }
      }
      resetIsSelected(StatusType.video);
      resetAll(type: StatusType.savedVideo);
    }

    notifyListeners();
  }

  void selectAll(StatusType type) {
    toggleIsSelectAll();
    if (isSelectAll)
      setIsSelected(type);
    else if (type == StatusType.image &&
        !isSelectAll &&
        countIsSelectedFiles(type) != imagesCount)
      setIsSelected(type);
    else if (type == StatusType.video &&
        !isSelectAll &&
        countIsSelectedFiles(type) != videosCount)
      setIsSelected(type);
    else if (type == StatusType.savedImage &&
        !isSelectAll &&
        countIsSelectedFiles(type) != imagesSavedCount)
      setIsSelected(type);
    else if (type == StatusType.savedVideo &&
        !isSelectAll &&
        countIsSelectedFiles(type) != videosSavedCount)
      setIsSelected(type);
    else if (!isSelectAll) resetAll();
  }

  void toggleIsSelected(int index, StatusType type) {
    if (type == StatusType.image) {
      StatusImage image = _images[index];
      image.toggleIsSelected();
    } else if (type == StatusType.video) {
      StatusVideo video = _videos[index];
      video.toggleIsSelected();
    } else if (type == StatusType.savedImage) {
      StatusImage image = _imagesSaved[index];
      image.toggleIsSelected();
    } else if (type == StatusType.savedVideo) {
      StatusVideo video = _videosSaved[index];
      video.toggleIsSelected();
    }
    notifyListeners();
  }

  void resetIsSelected(StatusType type) {
    if (type == StatusType.image) {
      _images.forEach((element) {
        element.resetIsSelected();
      });
    } else if (type == StatusType.video) {
      _videos.forEach((element) {
        element.resetIsSelected();
      });
    } else if (type == StatusType.savedImage) {
      _imagesSaved.forEach((element) {
        element.resetIsSelected();
      });
    } else if (type == StatusType.savedVideo) {
      _videosSaved.forEach((element) {
        element.resetIsSelected();
      });
    }
    notifyListeners();
  }

  void setIsSelected(StatusType type) {
    if (type == StatusType.image) {
      _images.forEach((element) {
        element.setIsSelected();
      });
    } else if (type == StatusType.video) {
      _videos.forEach((element) {
        element.setIsSelected();
      });
    } else if (type == StatusType.savedImage) {
      _imagesSaved.forEach((element) {
        element.setIsSelected();
      });
    } else if (type == StatusType.savedVideo) {
      _videosSaved.forEach((element) {
        element.setIsSelected();
      });
    }
    notifyListeners();
  }

  void clearAll(StatusType type) {
    if (type == StatusType.image)
      _images.clear();
    else if (type == StatusType.video)
      _videos.clear();
    else if (type == StatusType.savedImage)
      _imagesSaved.clear();
    else if (type == StatusType.savedVideo) _videosSaved.clear();

    notifyListeners();
  }

  void addFilesToList(StatusType type) async {
    List<FileSystemEntity> filesFromDir = [];
    List<String> filePathList = [];
    if (type == StatusType.image) {
      filesFromDir = await Constants.statusDirectory
          .list()
          .where((event) => (!event.path.contains('.nomedia') &&
              !event.path.contains('.mp4')))
          .toList();
      filePathList =
          await Sort(fileNamesList: filesFromDir).sortFilesOnLastModifiedDate();

      filePathList.forEach((element) {
        _images.add(StatusImage(imagePath: element));
      });
    } else if (type == StatusType.video) {
      filesFromDir = await Constants.statusDirectory
          .list()
          .where((event) => (!event.path.contains('.nomedia') &&
              !event.path.contains('.jpg')))
          .toList();
      filePathList =
          await Sort(fileNamesList: filesFromDir).sortFilesOnLastModifiedDate();

      filePathList.forEach((element) async {
        _videos.add(StatusVideo(videoPath: element));
      });

      _videos.forEach((element) {
        element.getVideoThumbnailBytes();
      });
    } else if (type == StatusType.savedImage) {
      filesFromDir = await Constants.savedDirectory
          .list()
          .where((event) => (!event.path.contains('.nomedia') &&
              !event.path.contains('.mp4')))
          .toList();
      filePathList =
          await Sort(fileNamesList: filesFromDir).sortFilesOnLastModifiedDate();

      filePathList.forEach((element) {
        _imagesSaved.add(StatusImage(imagePath: element));
      });
    } else if (type == StatusType.savedVideo) {
      filesFromDir = await Constants.savedDirectory
          .list()
          .where((event) => (!event.path.contains('.nomedia') &&
              !event.path.contains('.jpg')))
          .toList();
      filePathList =
          await Sort(fileNamesList: filesFromDir).sortFilesOnLastModifiedDate();

      filePathList.forEach((element) {
        _videosSaved.add(StatusVideo(videoPath: element));
      });

      _videosSaved.forEach((element) {
        element.getVideoThumbnailBytes();
      });
    }
    notifyListeners();
  }

//  Future<void> deleteSingleFile(String path,String type) async{
//    if(type=='savedImages'){
//      await File(path).delete();
//      makeIsSelectedFilesFalse('savedImages');
//      clearFilesList('savedImages');
//      addFilesToList('savedImages');
//    }
//    else if(type=='savedVideos'){
//      await File(path).delete();
//      makeIsSelectedFilesFalse('savedVideos');
//      clearFilesList('savedVideos');
//      addFilesToList('savedVideos');
//    }
//    notifyListeners();
//  }
//  void deleteMultipleFiles(String type) {
//    if(type=='savedImages'){
//      _imageFilesSavedDir.forEach((element) async{
//        if(element.isSelected){
//          await File(element.imagePath).delete();
//        }
//      });
//      resetAllValues(type:'savedImages');
//    }
//    else if(type=='savedVideos'){
//      _videoFilesSavedDir.forEach((element) async{
//        if(element.isSelected){
//          await File(element.videoPath).delete();
//        }
//
//      });
//      resetAllValues(type:'savedVideos');
//    }
//    notifyListeners();
//  }
}
