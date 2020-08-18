import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';
import 'dart:io';
import 'package:statuskeeper/constants.dart';
import 'package:statuskeeper/functionalities/shareFile.dart';
import 'package:chewie/chewie.dart';
import 'package:statuskeeper/models/viewModel.dart';

class VideoPlayScreen extends StatefulWidget {
  final int index;
  final String videoFileName;
  VideoPlayScreen({this.index,this.videoFileName});

  @override
  _VideoPlayScreenState createState() => _VideoPlayScreenState();
}

class _VideoPlayScreenState extends State<VideoPlayScreen> {
  VideoPlayerController _videoPlayerController;
  ChewieController _chewieController;
  Future<void> _future;

  @override
  void initState() {
    super.initState();
    _videoPlayerController= VideoPlayerController.file(File(widget.videoFileName));
    _future=initVideoPlayer();
    setState(() {
    });
  }

  Future<void> initVideoPlayer() async {
     await _videoPlayerController.initialize();
     _chewieController = ChewieController(
      aspectRatio:_videoPlayerController.value.aspectRatio,
      videoPlayerController: _videoPlayerController,
      autoPlay: true,
      looping: true,
      cupertinoProgressColors: ChewieProgressColors(
        handleColor: Colors.lightGreenAccent,
        bufferedColor: Colors.grey,
        playedColor: Colors.white,
      ),
      materialProgressColors: ChewieProgressColors(
        handleColor: Colors.lightGreenAccent,
        bufferedColor: Colors.grey,
        playedColor: Colors.white,
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    var viewModelData=Provider.of<StatusViewModel>(context);
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("Videos"),
        backgroundColor: Colors.black,
        actions: <Widget>[
          (viewModelData.getCurrentTab==0 || viewModelData.getCurrentTab==1) ? Builder(
            builder: (context)=>
                IconButton(
                  tooltip: "Save",
                  icon: Icon(Icons.save),
                  onPressed: (){
                     try{
                       viewModelData.saveSingleFile(widget.videoFileName,'videos');
                       Scaffold.of(context).showSnackBar(kSnackBarForSaved);
                     }
                     catch(e){
                       print(e);
                     }
                  },
              ),
          ):Container(),
//          Builder(
//            builder: (context)=>
//                IconButton(
//                  tooltip: "Delete",
//                  icon: Icon(Icons.delete),
//                  onPressed: (){
//                    viewModelData.deleteSingleFile(widget.videoFileName,'videos');
//                    Scaffold.of(context).showSnackBar(kSnackBarForDelete);
//                  },
//                ),
//          ),
          IconButton(
            tooltip: "Share",
            icon: Icon(Icons.share),
            onPressed: (){
              ShareImageVideo.shareImageVideo(widget.videoFileName,'file');
            },
          ),
          SizedBox(width: 15.0,)
        ],
      ),
      body: FutureBuilder(
        future: _future,
        builder: (context,snapshot){
          if(snapshot.connectionState == ConnectionState.waiting)
            return Container();
          return Center(
            child: Container(
                child: AspectRatio(
                  aspectRatio:_videoPlayerController.value.aspectRatio,
                  child: Chewie(
                    controller: _chewieController,
                  ),
                )
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController.dispose();
    super.dispose();
  }


}
