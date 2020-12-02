class StatusImage {
  final String imagePath;
  bool isSelected;

  StatusImage({this.imagePath, this.isSelected = false});

  void toggleIsSelected() {
    isSelected = !isSelected;
  }

  void resetIsSelected() {
    isSelected = false;
  }

  void setIsSelected() {
    isSelected = true;
  }
}
