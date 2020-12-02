import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:statuskeeper/models/status_store.dart';
import 'package:statuskeeper/models/video.dart';

class VideoCard extends StatelessWidget {
  final StatusVideo videoFile;
  VideoCard({this.videoFile});

  @override
  Widget build(BuildContext context) {
    var state = Provider.of<StatusStore>(context);
    return FutureBuilder(
      future: videoFile.bytes,
      builder: (BuildContext context, AsyncSnapshot<Uint8List> snapshot) {
        if (snapshot.hasData) {
          return Container(
            child: Card(
              child: Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  videoFile.isSelected
                      ? ColorFiltered(
                          colorFilter: ColorFilter.mode(
                              Colors.black.withOpacity(0.4), BlendMode.dstATop),
                          child: Image.memory(
                            snapshot.data,
                            fit: BoxFit.cover,
                          ),
                        )
                      : Image.memory(
                          snapshot.data,
                          fit: BoxFit.cover,
                        ),
                  state.isLongPress
                      ? Align(
                          alignment: Alignment.bottomRight,
                          child: Icon(
                            videoFile.isSelected
                                ? Icons.check_box
                                : Icons.check_box_outline_blank,
                            size: 30.0,
                            color: Colors.lightGreen,
                          ),
                        )
                      : Container()
                ],
              ),
              elevation: 20.0,
            ),
          );
        } else {
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
