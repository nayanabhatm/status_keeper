class ImageFile{
  final String imagePath;
  bool isSelected;

  ImageFile({this.imagePath,this.isSelected=false});

  void toggleIsSelected(){
    isSelected=!isSelected;
  }

  void makeIsSelectedFalse(){
    isSelected=false;
  }

  void makeIsSelectedTrue(){
    isSelected=true;
  }
}