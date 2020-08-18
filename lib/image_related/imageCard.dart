import 'package:flutter/material.dart';
import 'dart:io';
import 'package:provider/provider.dart';
import 'package:statuskeeper/models/image.dart';
import 'package:statuskeeper/models/viewModel.dart';

class ImageCard extends StatelessWidget {

  final ImageFile imageFile;
  ImageCard({this.imageFile});

  @override
  Widget build(BuildContext context) {
    var viewModelImagesData=Provider.of<StatusViewModel>(context);
    return Container(
      child:  Card(
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            imageFile.isSelected ? ColorFiltered(
              colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.2), BlendMode.dstATop),
              child: Image.file(
                File(imageFile.imagePath),
                fit: BoxFit.cover,
              ),
            ):
            Image.file(
              File(imageFile.imagePath),
              fit: BoxFit.cover,
            ),
            viewModelImagesData.isLongPress ?
             Align(
              alignment: Alignment.bottomRight,
              child: Icon(
                imageFile.isSelected ? Icons.check_box : Icons.check_box_outline_blank,
                size: 30.0,
                color: Colors.lightGreen,
              ),
            ) :  Container()
          ],
        ),
        elevation: 20.0,
      ),
    );
  }
}
