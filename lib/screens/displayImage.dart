import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:statuskeeper/models/status_store.dart';
import 'package:statuskeeper/utils/shareFile.dart';
import 'package:statuskeeper/widget_styles.dart';

class DisplayImage extends StatelessWidget {
  final int index;
  final String imageFilePath;

  DisplayImage({this.index, this.imageFilePath});

  @override
  Widget build(BuildContext context) {
    var state = Provider.of<StatusStore>(context);
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("Images"),
        backgroundColor: Colors.black,
        actions: <Widget>[
          (state.getCurrentTab == 0 || state.getCurrentTab == 1)
              ? Builder(
                  builder: (context) => IconButton(
                    tooltip: "Save",
                    icon: Icon(Icons.save),
                    onPressed: () {
                      try {
                        state.save(imageFilePath, StatusType.image);
                        Scaffold.of(context).showSnackBar(kSnackBarForSaved);
                      } catch (e) {
                        print(e);
                      }
                    },
                  ),
                )
              : Container(),
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
            onPressed: () {
              Share.share(imageFilePath, 'image');
            },
          ),
          SizedBox(
            width: 15.0,
          )
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
