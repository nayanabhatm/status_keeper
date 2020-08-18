import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:statuskeeper/models/viewModel.dart';
import 'package:statuskeeper/saved_related/imagesGridSavedTab.dart';
import 'package:statuskeeper/saved_related/videosGridSavedTab.dart';
import 'package:provider/provider.dart';

class SavedTab extends StatefulWidget {
  @override
  _SavedTabState createState() => _SavedTabState();
}

class _SavedTabState extends State<SavedTab> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    var viewModel=Provider.of<StatusViewModel>(context);
     return Column(
       children: <Widget>[
         ToggleButtons(
           constraints: BoxConstraints.expand(width: 200.0,height: 50.0),
           fillColor: Colors.lightGreen,
           children: <Widget>[
             Text("Images",
               style: TextStyle(
                   color: Colors.white,
                   fontSize: 14.0
               ),
             ),
             Text("Videos",
               style: TextStyle(
                   color: Colors.white,
                   fontSize: 14.0
               ),
             ),
           ],
           onPressed: (int index){
               viewModel.toggleSavedTabToggleButtons(index);
               viewModel.resetLongPress();
           },
           isSelected: viewModel.savedTabToggleButtons,
         ),
         (viewModel.savedTabToggleButtonImage)? Expanded(
           child:ImagesGridSavedTab() ,
         ): Expanded(
           child:VideosGridSavedTab() ,
         )
       ],
     );
  }
}
