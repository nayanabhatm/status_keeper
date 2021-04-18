import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:statuskeeper/buildAppBar.dart';
import 'package:statuskeeper/models/status_store.dart';
import 'package:statuskeeper/tabs/images_tab/images.dart';
import 'package:statuskeeper/tabs/saved_tab/savedTab.dart';
import 'package:statuskeeper/tabs/videos_tab/videos.dart';
import 'package:statuskeeper/utils/checkStoragePermission.dart';
import 'package:statuskeeper/utils/constants.dart';

class Tabs extends StatefulWidget {
  @override
  _TabsState createState() => _TabsState();
}

class _TabsState extends State<Tabs>
    with WidgetsBindingObserver, AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      var state = Provider.of<StatusStore>(context, listen: false);
      WidgetsBinding.instance.addObserver(this);
      try {
        PermissionCheck.checkStoragePermission();

        var tabController = DefaultTabController.of(context);
        tabController.addListener(() {
          state.resetLongPress();
          StatusType.values.forEach((element) {
            state.resetIsSelected(element);
          });
          state.updateCurrentTab(tabController.index);
        });

        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          state.resetAll();
        });
      } catch (e) {
        print("No Permission");
      }
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState appLifecycleState) {
    print(appLifecycleState);
    var state = Provider.of<StatusStore>(context, listen: false);
    if (appLifecycleState == AppLifecycleState.resumed) {
      state.resetAll();
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    var state = Provider.of<StatusStore>(context, listen: false);
    return WillPopScope(
      onWillPop: () {
        if (state.isLongPress) {
          state.resetLongPress();
          StatusType.values.forEach((element) {
            state.resetIsSelected(element);
          });
          return Future<bool>.value(false);
        } else {
          return Future<bool>.value(true);
        }
      },
      child: Consumer<StatusStore>(
        builder: (BuildContext _, StatusStore state, Widget __) {
          return Scaffold(
            appBar: StatusAppBar().buildAppBar(context),
            body: TabBarView(children: [
              Images(),
              Videos(),
              Saved(),
            ]),
          );
        },
      ),
    );
  }
}
