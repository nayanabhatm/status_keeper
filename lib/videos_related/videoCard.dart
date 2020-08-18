import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:statuskeeper/models/video.dart';
import 'package:statuskeeper/models/viewModel.dart';
import 'dart:typed_data';

class VideoCard extends StatelessWidget {
  final VideoFile videoFile;
  VideoCard({this.videoFile});

  @override
  Widget build(BuildContext context) {
    var viewModelVideosData=Provider.of<StatusViewModel>(context);
          return FutureBuilder(
            future: videoFile.bytes,
            builder: (BuildContext context,AsyncSnapshot<Uint8List> snapshot){
              if(snapshot.hasData){
                return Container(
                  child:  Card(
                    child: Stack(
                      fit: StackFit.expand,
                      children: <Widget>[
                        videoFile.isSelected?
                        ColorFiltered(
                          colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.4), BlendMode.dstATop),
                          child: Image.memory(
                            snapshot.data,
                            fit: BoxFit.cover,
                          ),
                        ):
                        Image.memory(
                          snapshot.data,
                          fit: BoxFit.cover,
                        ),

                        viewModelVideosData.isLongPress ?
                        Align(
                          alignment: Alignment.bottomRight,
                          child: Icon(
                            videoFile.isSelected ? Icons.check_box : Icons.check_box_outline_blank,
                            size: 30.0,
                            color: Colors.lightGreen,
                          ),
                        ) :  Container()
                      ],
                    ),
                    elevation: 20.0,
                  ),
                );
              }
              else{
                return Container(
                  color: Colors.grey.withOpacity(0.2),
                  child: SizedBox(
                    height: 10.0,
                    width: 10.0,
                    child: Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(Colors.black),
                        backgroundColor: Colors.lightGreen,
                      ),
                    ),
                  ),
                );
              }
            },
          );

  }

}
