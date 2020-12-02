import 'dart:io';
import 'dart:collection';

class Sort{
  List<FileSystemEntity> fileNamesList=[];
  Sort({this.fileNamesList});

  Future<List<String>> sortFilesOnLastModifiedDate() async{
    List<String> filePathList=[];
    Map<String,DateTime> temp1Map=Map();

    for(int i=0;i<fileNamesList.length;i++){
      String filePathOfImage=fileNamesList[i].path;
      temp1Map[filePathOfImage]=await File(filePathOfImage).lastModified();
    }

    var temp2List = temp1Map.keys.toList();
    temp2List.sort((k1, k2) => temp1Map[k1].compareTo(temp1Map[k2]));
    LinkedHashMap tempSortedFileNamesMap = LinkedHashMap.fromIterable(temp2List, key: (k) => k, value: (k) => temp1Map[k]);

    tempSortedFileNamesMap.keys.toList().reversed.forEach((element) {
      filePathList.add(element);
    });

    return filePathList;
  }

}