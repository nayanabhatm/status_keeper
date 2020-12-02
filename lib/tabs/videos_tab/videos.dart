import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:statuskeeper/models/status_store.dart';
import 'package:statuskeeper/screens/playVideo.dart';
import 'package:statuskeeper/tabs/videos_tab/videoCard.dart';

class Videos extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var state = Provider.of<StatusStore>(context, listen: false);
    return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 1.0,
          mainAxisSpacing: 1.0,
        ),
        itemCount: state.videosCount,
        itemBuilder: (context, index) {
          return Container(
            child: GestureDetector(
              onTap: () {
                if (!state.isLongPress) {
                  Navigator.push(context, MaterialPageRoute(builder: (_) {
                    return VideoPlayScreen(
                        index: index,
                        videoFileName: state.videos[index].videoPath);
                  }));
                } else {
                  state.toggleIsSelected(index, StatusType.video);
                }
              },
              onLongPress: () {
                if (!state.isLongPress) state.resetIsSelected(StatusType.video);

                state.toggleIsLongPress();
                state.toggleIsSelected(index, StatusType.video);
              },
              child: VideoCard(
                videoFile: state.videos[index],
              ),
            ),
          );
        });
  }
}
