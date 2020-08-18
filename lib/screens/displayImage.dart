import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:io';
import 'package:statuskeeper/constants.dart';
import 'package:statuskeeper/functionalities/shareFile.dart';
import 'package:statuskeeper/models/viewModel.dart';

class DisplayImage extends StatelessWidget{
  final int index;
  final String imageFilePath;

  DisplayImage({this.index,this.imageFilePath});

  @override
  Widget build(BuildContext context) {
    var viewModelData=Provider.of<StatusViewModel>(context);
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("Images"),
        backgroundColor: Colors.black,
        actions: <Widget>[
          (viewModelData.getCurrentTab==0 || viewModelData.getCurrentTab==1) ? Builder(
            builder: (context)=>
            IconButton(
              tooltip: "Save",
              icon: Icon(Icons.save),
              onPressed: (){
                try{
                  viewModelData.saveSingleFile(imageFilePath,'images');
                  Scaffold.of(context).showSnackBar(kSnackBarForSaved);
                }
                catch(e){
                  print(e);
                }
              },
            ),
          ): Container(),
//          Builder(
//            builder: (context)=>
//                IconButton(
//                  tooltip: "Delete",
//                  icon: Icon(Icons.delete),
//                  onPressed: (){
//                    viewModelData.deleteSingleFile(imageFilePath,'images');
//                    Scaffold.of(context).showSnackBar(kSnackBarForDelete);
//                  },
//                ),
//          ),
          IconButton(
            tooltip: "Share",
            icon: Icon(Icons.share),
            onPressed: (){
              ShareImageVideo.shareImageVideo(imageFilePath,'image');
            },
          ),
          SizedBox(width: 15.0,)
        ],
      ),
      body: Center(
        child: Hero(
          tag: 'index$index',
          child: Container(
            child: Image.file(
             File(imageFilePath),
             fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}


