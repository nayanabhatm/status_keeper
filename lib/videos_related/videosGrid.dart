import 'package:flutter/material.dart';
import 'package:statuskeeper/models/viewModel.dart';
import 'package:provider/provider.dart';
import 'package:statuskeeper/screens/playVideo.dart';
import 'package:statuskeeper/videos_related/videoCard.dart';

class VideosGrid extends StatelessWidget {
//  @override
//  _VideosGridState createState() => _VideosGridState();
//}
//
//class _VideosGridState extends State<VideosGrid> with WidgetsBindingObserver{

//  @override
//  void initState() {
//    print("videocard init");
//    WidgetsBinding.instance.addObserver(this);
//    WidgetsBinding.instance.addPostFrameCallback((timestamp) async {
//        var viewModel=Provider.of<StatusViewModel>(context,listen: false);
//        viewModel.makeSelectionModeLongPressFalse();
//    });
//    super.initState();
//
//  }
//
//  @override
//  void dispose() {
//    WidgetsBinding.instance.removeObserver(this);
//    super.dispose();
//  }




  @override
  Widget build(BuildContext context) {
    var viewModelVideosData = Provider.of<StatusViewModel>(context , listen: false);
    return GridView.builder(
        gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 1.0,
          mainAxisSpacing: 1.0,
        ),
        itemCount: viewModelVideosData.videoFilesWhatsappDirCount ,
        itemBuilder:(context,index){
          return Container(
            child: GestureDetector(
              onTap: (){
                if(!viewModelVideosData.isLongPress){
                  Navigator.push(context, MaterialPageRoute(builder: (_) {
                    return VideoPlayScreen(index:index, videoFileName:viewModelVideosData.videoFilesWhatsAppDir[index].videoPath);
                  })
                  );
                }
                else {
                  viewModelVideosData.toggleIsSelected(index,'videos');
                }
              },
              onLongPress: () {
                if(!viewModelVideosData.isLongPress)
                  viewModelVideosData.resetIsSelected('videos');

                viewModelVideosData.toggleIsLongPress();
                viewModelVideosData.toggleIsSelected(index,'videos');
              },

              child: VideoCard(
                videoFile:viewModelVideosData.videoFilesWhatsAppDir[index],
              ),
            ),
          );
        }
    );
  }

}


