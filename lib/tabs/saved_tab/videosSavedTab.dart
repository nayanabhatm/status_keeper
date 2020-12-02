import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:statuskeeper/models/status_store.dart';
import 'package:statuskeeper/screens/playVideo.dart';
import 'package:statuskeeper/tabs/videos_tab/videoCard.dart';

class VideosSaved extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var state = Provider.of<StatusStore>(context);
    return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 1.0,
          mainAxisSpacing: 1.0,
        ),
        itemCount: state.videosSavedCount,
        itemBuilder: (context, index) {
          return Container(
            child: GestureDetector(
              onTap: () {
                if (!state.isLongPress) {
                  Navigator.push(context, MaterialPageRoute(builder: (_) {
                    return VideoPlayScreen(
                        index: index,
                        videoFileName: state.videosSaved[index].videoPath);
                  }));
                } else {
                  state.toggleIsSelected(index, StatusType.savedVideo);
                }
              },
              onLongPress: () {
                if (!state.isLongPress)
                  state.resetIsSelected(StatusType.savedVideo);

                state.toggleIsLongPress();
                state.toggleIsSelected(index, StatusType.savedVideo);
              },
              child: VideoCard(
                videoFile: state.videosSaved[index],
              ),
            ),
          );
        });
  }
}
