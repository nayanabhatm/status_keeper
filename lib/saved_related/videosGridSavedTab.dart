import 'package:flutter/material.dart';
import 'package:statuskeeper/models/viewModel.dart';
import 'package:provider/provider.dart';
import 'package:statuskeeper/screens/playVideo.dart';
import 'package:statuskeeper/videos_related/videoCard.dart';

class VideosGridSavedTab extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    var viewModelVideosData = Provider.of<StatusViewModel>(context , listen: false);
    return GridView.builder(
          gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 1.0,
            mainAxisSpacing: 1.0,
          ),
          itemCount: viewModelVideosData.videoFilesSavedDirCount ,
          itemBuilder:(context,index){
            return Container(
              child: GestureDetector(
                onTap: (){
                  if(!viewModelVideosData.isLongPress){
                    Navigator.push(context, MaterialPageRoute(builder: (_) {
                      return VideoPlayScreen(index:index, videoFileName:viewModelVideosData.videoFilesSavedDir[index].videoPath);
                    })
                    );
                  }
                  else {
                    viewModelVideosData.toggleIsSelected(index,'savedVideos');
                  }
                },
                onLongPress: () {
                  if(!viewModelVideosData.isLongPress)
                    viewModelVideosData.resetIsSelected('savedVideos');

                  viewModelVideosData.toggleIsLongPress();
                  viewModelVideosData.toggleIsSelected(index,'savedVideos');
                },

                child: VideoCard(
                  videoFile:viewModelVideosData.videoFilesSavedDir[index],
                ),
              ),
            ) ;
          }
      );
  }
}


