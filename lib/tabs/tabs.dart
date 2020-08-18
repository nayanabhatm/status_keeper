import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:statuskeeper/models/viewModel.dart';
import 'package:statuskeeper/functionalities/checkStoragePermission.dart';
import 'package:statuskeeper/image_related/imagesGrid.dart';
import 'package:statuskeeper/saved_related/savedTab.dart';
import 'package:statuskeeper/videos_related/videosGrid.dart';
import 'package:statuskeeper/buildAppBar.dart';


class Tabs extends StatefulWidget {
  @override
  _TabsState createState() => _TabsState();
}

class _TabsState extends State<Tabs> with WidgetsBindingObserver, AutomaticKeepAliveClientMixin{
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      var viewModelData=Provider.of<StatusViewModel>(context,listen: false);
      WidgetsBinding.instance.addObserver(this);
      PermissionCheck().checkStoragePermission();

      var tabController = DefaultTabController.of(context);
      tabController.addListener(() {
        viewModelData.resetLongPress();
        ['images','videos','savedImages','savedVideos'].forEach((element){
            viewModelData.resetIsSelected(element);
        });
          viewModelData.updateCurrentTab(tabController.index);
      });

      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          viewModelData.resetAllValues();
      });

    });


  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print(state);
    var viewModelData=Provider.of<StatusViewModel>(context,listen: false);
    if(state==AppLifecycleState.resumed)
    {
      viewModelData.resetAllValues();
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    super.build(context);
    return WillPopScope(
      onWillPop: (){
        var viewModelData=Provider.of<StatusViewModel>(context,listen: false);
        if(viewModelData.isLongPress ) {
            viewModelData.resetLongPress();
            ['images','videos','savedImages','savedVideos'].forEach((element){
              viewModelData.resetIsSelected(element);
            });
            return Future<bool>.value(false);
         }
        else{
          return Future<bool>.value(true);
        }
      },
      child: Builder(
        builder: (context){
          return Scaffold(
            appBar: AppBarBuild().buildAppBar(context),
            body: TabBarView(
                children: [
                  ImagesGrid(),
                  VideosGrid(),
                  SavedTab(),
                ]),
          );
        },
      ),
    );
  }



}