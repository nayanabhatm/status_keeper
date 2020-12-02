import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:statuskeeper/models/status_store.dart';
import 'package:statuskeeper/widget_styles.dart';

class StatusAppBar {
  Widget buildAppBar(BuildContext context) {
    int currentTab;

    var state = Provider.of<StatusStore>(context, listen: false);
    currentTab = state.getCurrentTab;

    if (state.isLongPress) {
      return AppBar(
        actions: <Widget>[
          IconButton(
            tooltip: "Select All",
            iconSize: 32.0,
            icon: Icon(Icons.select_all),
            onPressed: () {
              if (currentTab == 0)
                state.selectAll(StatusType.image);
              else if (currentTab == 1)
                state.selectAll(StatusType.video);
              else if (currentTab == 2) {
                if (state.isSwitched == true)
                  state.selectAll(StatusType.savedImage);
                else if (state.isSwitched == false)
                  state.selectAll(StatusType.savedVideo);
              }
            },
          ),
          SizedBox(
            width: 10.0,
          ),
          (currentTab == 0 || currentTab == 1)
              ? Builder(builder: (context) {
                  return IconButton(
                    tooltip: "Save",
                    iconSize: 30.0,
                    icon: Icon(Icons.save),
                    onPressed: () {
                      if (currentTab == 0) {
                        state.saveMultiple(StatusType.image);
                        Scaffold.of(context).showSnackBar(kSnackBarForSaved);
                      } else if (currentTab == 1) {
                        state.saveMultiple(StatusType.video);
                        Scaffold.of(context).showSnackBar(kSnackBarForSaved);
                      }
                    },
                  );
                })
              :
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
              SizedBox(
                  width: 5.0,
                ),
          IconButton(
            tooltip: "Share",
            iconSize: 30.0,
            icon: Icon(Icons.share),
            onPressed: () {
              if (currentTab == 0)
                state.shareMultiple(StatusType.image);
              else if (currentTab == 1)
                state.shareMultiple(StatusType.video);
              else if (currentTab == 2) {
                if (state.isSwitched == true)
                  state.shareMultiple(StatusType.savedImage);
                else if (state.isSwitched == false)
                  state.shareMultiple(StatusType.savedVideo);
              }
            },
          ),
          SizedBox(
            width: 10.0,
          )
        ],
        bottom: TabBar(
          tabs: [
            Tab(text: "Images"),
            Tab(text: "Videos"),
            Tab(text: "Saved"),
          ],
        ),
      );
    } else {
      return AppBar(
        title: Text("Status Keeper"),
        bottom: TabBar(
          tabs: [
            Tab(text: "Images"),
            Tab(text: "Videos"),
            Tab(text: "Saved"),
          ],
        ),
      );
    }
  }
}
