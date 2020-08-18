import 'package:flutter/foundation.dart';
import 'package:statuskeeper/functionalities/saveFile.dart';
import 'package:statuskeeper/models/image.dart';
import 'dart:io';
import 'package:statuskeeper/functionalities/sortFiles.dart';
import 'package:statuskeeper/functionalities/shareFile.dart';
import 'package:statuskeeper/models/video.dart';


class StatusViewModel extends ChangeNotifier{
  final Directory whatsAppStatusDirectory = Directory('/storage/emulated/0/WhatsApp/Media/.Statuses');
  final Directory savedFilesDirectory = Directory('/storage/emulated/0/Status Keeper');

  bool _isLongPress = false;
  bool _isSelectAll=false;
  int _currentTab=0;

  List<bool> _savedTabToggleButtons=[true,false];
  List<ImageFile> _imageFilesWhatsappDir=[];
  List<VideoFile> _videoFilesWhatsappDir=[];
  List<ImageFile> _imageFilesSavedDir=[];
  List<VideoFile> _videoFilesSavedDir=[];

  int get getCurrentTab => _currentTab;
  void updateCurrentTab(int currentTab){
    _currentTab=currentTab;
    notifyListeners();
  }

  bool get savedTabToggleButtonImage => _savedTabToggleButtons[0];
  bool get savedTabToggleButtonVideo => _savedTabToggleButtons[1];
  List<bool> get savedTabToggleButtons => _savedTabToggleButtons;

  void toggleSavedTabToggleButtons(int index){
    for (int i = 0; i < _savedTabToggleButtons.length; i++) {
      _savedTabToggleButtons[i] = i == index;
    }
    notifyListeners();
  }

  bool get isLongPress => _isLongPress;
  void resetLongPress(){
    _isLongPress=false;
    notifyListeners();
  }
  void toggleIsLongPress(){
    _isLongPress=!_isLongPress;
    notifyListeners();
  }


  bool get isSelectAll => _isSelectAll;
  void toggleIsSelectAll(){
    _isSelectAll=!_isSelectAll;
    notifyListeners();
  }
  void resetIsSelectAll(){
    _isSelectAll=false;
    notifyListeners();
  }


  int get imageFilesWhatsappDirCount => _imageFilesWhatsappDir.length;
  int get videoFilesWhatsappDirCount => _videoFilesWhatsappDir.length;
  int get imageFilesSavedDirCount => _imageFilesSavedDir.length;
  int get videoFilesSavedDirCount => _videoFilesSavedDir.length;

  void resetAllValues({String type}){
    resetLongPress();
    resetIsSelectAll();

    type??='';

    if(type.length!=0){
      resetIsSelected(type);
      clearFilesList(type);
      addFilesToList(type);
    }
    else
    {
      ['images', 'videos', 'savedImages', 'savedVideos'].forEach((
          element) async {
        resetIsSelected(element);
        clearFilesList(element);
        addFilesToList(element);
      });
    }
  }

  int countIsSelectedFiles(String type){
      int cnt=0;
      if(type=='images')
      {
        _imageFilesWhatsappDir.forEach((element) {
          if(element.isSelected){
            cnt++;
          }
        });
      }
      else if(type=='videos')
      {
        _videoFilesWhatsappDir.forEach((element) {
          if(element.isSelected){
            cnt++;
          }
        });
      }
      else if(type=='savedImages')
      {
        _imageFilesSavedDir.forEach((element) {
          if(element.isSelected){
            cnt++;
          }
        });
      }
      else if(type=='savedVideos')
      {
        _videoFilesSavedDir.forEach((element) {
          if(element.isSelected){
            cnt++;
          }
        });
      }
      return cnt;
  }

  void shareMultipleFiles(String type){
    List<String> listOfAssetsToShare=[];
    if(type=='images')
    {
      _imageFilesWhatsappDir.forEach((element) {
        if(element.isSelected)
          listOfAssetsToShare.add(element.imagePath);
      });
      ShareImageVideo.shareImageVideoMultiple(listOfAssetsToShare,'image');
    }
    else if(type=='videos')
    {
      _videoFilesWhatsappDir.forEach((element) {
        if(element.isSelected)
          listOfAssetsToShare.add(element.videoPath);
      });
      ShareImageVideo.shareImageVideoMultiple(listOfAssetsToShare,'file');
    }
    else if(type=='savedImages')
    {
      _imageFilesSavedDir.forEach((element) {
        if(element.isSelected)
          listOfAssetsToShare.add(element.imagePath);
      });
      ShareImageVideo.shareImageVideoMultiple(listOfAssetsToShare,'image');
    }
    else if(type=='savedVideos')
    {
      _videoFilesSavedDir.forEach((element) {
        if(element.isSelected)
          listOfAssetsToShare.add(element.videoPath);
      });
      ShareImageVideo.shareImageVideoMultiple(listOfAssetsToShare,'file');
    }
  }

  Future<void> saveSingleFile(String path,String type) async{
    if(type=='images'){
      await SaveImageVideo.saveImage(path);
      resetAllValues(type:'savedImages');
    }
    else if(type=='videos'){
      await SaveImageVideo.saveVideo(path);
      resetAllValues(type:'savedVideos');
    }
    notifyListeners();
  }
  Future<void> saveMultipleFiles(String type) async{
      if(type=='images')
      {
        for(int i =0 ;i < _imageFilesWhatsappDir.length ; i++){
          var element = _imageFilesWhatsappDir[i] ;
          if(element.isSelected)
            try{
            await SaveImageVideo.saveImage(element.imagePath);
            }
          catch(e){
            print(e);
          }
        }
        resetIsSelected('images');
        resetAllValues(type:'savedImages');
      }
      else if(type=='videos')
      {
        for(int i =0 ;i < _videoFilesWhatsappDir.length ; i++){
          var element = _videoFilesWhatsappDir[i] ;
          if(element.isSelected)
            try{
            await SaveImageVideo.saveVideo(element.videoPath);
           }
          catch(e){
            print(e);
          }
        }
        resetIsSelected('videos');
        resetAllValues(type:'savedVideos');
      }

    notifyListeners();
  }

  void selectAllFiles(String type){
      toggleIsSelectAll();
      if (isSelectAll)
        makeIsSelectedTrue(type);
      else if (type=='images' && !isSelectAll && countIsSelectedFiles(type) != imageFilesWhatsappDirCount)
        makeIsSelectedTrue(type);
      else if (type=='videos' && !isSelectAll && countIsSelectedFiles(type) != videoFilesWhatsappDirCount)
        makeIsSelectedTrue(type);
      else if (type=='savedImages' && !isSelectAll && countIsSelectedFiles(type) != imageFilesSavedDirCount)
        makeIsSelectedTrue(type);
      else if (type=='savedVideos' && !isSelectAll && countIsSelectedFiles(type) != videoFilesSavedDirCount)
        makeIsSelectedTrue(type);
      else if (!isSelectAll)
        resetAllValues();
  }

  List<ImageFile> get imageFilesWhatsAppDir => _imageFilesWhatsappDir;
  List<VideoFile> get videoFilesWhatsAppDir => _videoFilesWhatsappDir;
  List<ImageFile> get imageFilesSavedDir => _imageFilesSavedDir;
  List<VideoFile> get videoFilesSavedDir => _videoFilesSavedDir;

  void toggleIsSelected(int index,String type){
    if(type=='images')
    {
      ImageFile image=_imageFilesWhatsappDir[index];
      image.toggleIsSelected();
    }
    else if(type=='videos')
    {
      VideoFile video=_videoFilesWhatsappDir[index];
      video.toggleIsSelected();
    }
    else if(type=='savedImages')
    {
      ImageFile image=_imageFilesSavedDir[index];
      image.toggleIsSelected();
    }
    else if(type=='savedVideos')
    {
      VideoFile video=_videoFilesSavedDir[index];
      video.toggleIsSelected();
    }
    notifyListeners();
  }

  void resetIsSelected(String type){
    if(type=='images')
    {
      _imageFilesWhatsappDir.forEach((element) {
        element.makeIsSelectedFalse();
      });
    }
    else if(type=='videos')
    {
      _videoFilesWhatsappDir.forEach((element) {
        element.makeIsSelectedFalse();
      });
    }
    else if(type=='savedImages')
    {
        _imageFilesSavedDir.forEach((element) {
          element.makeIsSelectedFalse();
        });
    }
    else if(type=='savedVideos')
    {
        _videoFilesSavedDir.forEach((element) {
          element.makeIsSelectedFalse();
        });
    }
    notifyListeners();
  }

  void makeIsSelectedTrue(String type){

    if(type=='images')
    {
      _imageFilesWhatsappDir.forEach((element) {
        element.makeIsSelectedTrue();
      });
    }
    else if(type=='videos')
    {
      _videoFilesWhatsappDir.forEach((element) {
        element.makeIsSelectedTrue();
      });
    }
    else if(type=='savedImages')
    {
      _imageFilesSavedDir.forEach((element) {
        element.makeIsSelectedTrue();
      });
    }
    else if(type=='savedVideos')
    {
      _videoFilesSavedDir.forEach((element) {
        element.makeIsSelectedTrue();
      });
    }
    notifyListeners();
  }

  void clearFilesList(String type){
    if(type=='images')
      _imageFilesWhatsappDir.clear();
    else if(type=='videos')
        _videoFilesWhatsappDir.clear();
    else if(type=='savedImages')
        _imageFilesSavedDir.clear();
    else if(type=='savedVideos')
        _videoFilesSavedDir.clear();
    notifyListeners();
  }


  void addFilesToList(String type) async{
    List<FileSystemEntity> filesFromDir=[];
    List<String> filePathList=[];
    if(type=='images')
    {
      filesFromDir=await whatsAppStatusDirectory.list().where((event) => (!event.path.contains('.nomedia') && !event.path.contains('.mp4'))).toList();
      filePathList=await Sort(fileNamesList: filesFromDir).sortFilesOnLastModifiedDate();

      filePathList.forEach((element) {
        _imageFilesWhatsappDir.add(ImageFile(imagePath:element));
      });
    }
    else if(type=='videos')
    {
      filesFromDir=await whatsAppStatusDirectory.list().where((event) => (!event.path.contains('.nomedia') && !event.path.contains('.jpg'))).toList();
      filePathList=await Sort(fileNamesList: filesFromDir).sortFilesOnLastModifiedDate();

      filePathList.forEach((element) async{
        _videoFilesWhatsappDir.add(VideoFile(videoPath:element));
      });

      _videoFilesWhatsappDir.forEach((element) {
         element.getVideoThumbnailBytes();
      });

    }
    else if(type=='savedImages')
    {
      filesFromDir=await savedFilesDirectory.list().where((event) => (!event.path.contains('.nomedia') && !event.path.contains('.mp4'))).toList();
      filePathList=await Sort(fileNamesList: filesFromDir).sortFilesOnLastModifiedDate();

      filePathList.forEach((element) {
        _imageFilesSavedDir.add(ImageFile(imagePath:element));
      });
    }
    else if(type=='savedVideos')
    {
      filesFromDir=await savedFilesDirectory.list().where((event) => (!event.path.contains('.nomedia') && !event.path.contains('.jpg'))).toList();
      filePathList=await Sort(fileNamesList: filesFromDir).sortFilesOnLastModifiedDate();

      filePathList.forEach((element) {
        _videoFilesSavedDir.add(VideoFile(videoPath:element));
      });

        _videoFilesSavedDir.forEach((element) {
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