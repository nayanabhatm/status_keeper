import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:statuskeeper/models/viewModel.dart';
import 'package:statuskeeper/constants.dart';

class AppBarBuild {
  AppBar buildAppBar(BuildContext context) {
    var viewModel = Provider.of<StatusViewModel>(context);
    int currentTab;
    if (viewModel.isLongPress) {
            currentTab=viewModel.getCurrentTab;
            return AppBar(
              actions: <Widget>[
                IconButton(
                  tooltip: "Select All",
                  iconSize: 32.0,
                  icon: Icon(Icons.select_all),
                  onPressed: () {
                    if (currentTab == 0)
                       viewModel.selectAllFiles('images');
                    else if (currentTab == 1)
                       viewModel.selectAllFiles('videos');
                    else if(currentTab ==2) {
                      if (viewModel.savedTabToggleButtonImage)
                        viewModel.selectAllFiles('savedImages');
                      else if (viewModel.savedTabToggleButtonVideo)
                        viewModel.selectAllFiles('savedVideos');
                    }
                  },
                ),
                SizedBox(width: 10.0,),
                (currentTab==0 || currentTab==1) ? Builder(
                    builder: (context) {
                      return IconButton(
                        tooltip: "Save",
                        iconSize: 30.0,
                        icon: Icon(Icons.save),
                        onPressed: () {
                          if (currentTab == 0) {
                            viewModel.saveMultipleFiles('images');
                            Scaffold.of(context).showSnackBar(kSnackBarForSaved);
                          }
                          else if (currentTab == 1) {
                            viewModel.saveMultipleFiles('videos');
                            Scaffold.of(context).showSnackBar(kSnackBarForSaved);
                          }
                        },
                      );
                    }
                ) :
//                Builder(
//                  builder: (context){
//                    return IconButton(
//                      tooltip: "Delete",
//                      iconSize: 30.0,
//                      icon: Icon(Icons.delete),
//                      onPressed: () {
//
//                        Alert(
//                            style: AlertStyle(
//                              isCloseButton: false,
//                              backgroundColor: Colors.black,
//                              titleStyle: TextStyle(
//                                color: Colors.white,
//                                fontSize: 16.0,
//                              )
//                            ),
//                            context: context,
//                            title: "Do You Want to Delete the File?",
//                            buttons: [
//                                DialogButton(
//                                    child: Text("Yes",style: TextStyle(color: Colors.white, fontSize: 20),),
//                                    color: Colors.lightGreen,
//                                    onPressed: () {
//                                      if (viewModel.savedTabToggleButtonImage) {
//                                        viewModel.deleteMultipleFiles(
//                                            'savedImages');
//                                        Scaffold.of(context).showSnackBar(
//                                            kSnackBarForDelete);
//                                      }
//                                      else
//                                      if (viewModel.savedTabToggleButtonVideo) {
//                                        viewModel.deleteMultipleFiles(
//                                            'savedVideos');
//                                        Scaffold.of(context).showSnackBar(
//                                            kSnackBarForDelete);
//                                      }
//                                      Navigator.pop(context);
//                                    },
//                                ),
//                                DialogButton(
//                                      child: Text("No",style: TextStyle(color: Colors.white, fontSize: 20),),
//                                      color: Colors.lightGreen,
//                                      onPressed: (){
//                                        Navigator.pop(context);
//                                      },
//                                )
//
//                            ]
//                        ).show();
//                      },
//                    );
//                  },
//                ),
                SizedBox(width: 5.0,),
                IconButton(
                  tooltip: "Share",
                  iconSize: 30.0,
                  icon: Icon(Icons.share),
                  onPressed: () {
                    if (currentTab == 0)
                      viewModel.shareMultipleFiles('images');
                    else if (currentTab == 1)
                      viewModel.shareMultipleFiles('videos');
                    else if(currentTab ==2){
                        if(viewModel.savedTabToggleButtonImage)
                            viewModel.shareMultipleFiles('savedImages');
                        else if (viewModel.savedTabToggleButtonVideo)
                            viewModel.shareMultipleFiles('savedVideos');
                    }
                  },
                ),
                SizedBox(width: 10.0,)
              ],
              bottom: TabBar(
                tabs: [
                  Tab(text: "Images"),
                  Tab(text: "Videos"),
                  Tab(text: "Saved"),
                ],
              ),
            );
    }



    return AppBar(
      title: Text("Status Keeper"),
      bottom: TabBar(
        tabs: [
          Tab(text:"Images"),
          Tab(text:"Videos"),
          Tab(text:"Saved"),
        ],
      ),
    );
  }
}