import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:statuskeeper/models/status_store.dart';
import 'package:statuskeeper/screens/displayImage.dart';
import 'package:statuskeeper/tabs/images_tab/imageCard.dart';
import 'package:statuskeeper/utils/constants.dart';

class ImagesSaved extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var state = Provider.of<StatusStore>(context);
    return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 1.0,
          mainAxisSpacing: 1.0,
        ),
        itemCount: state.imagesSavedCount,
        itemBuilder: (context, index) {
          return Container(
            child: GestureDetector(
              onTap: () {
                if (!state.isLongPress) {
                  Navigator.push(context, MaterialPageRoute(builder: (_) {
                    return DisplayImage(
                      index: index,
                      imageFilePath: state.imagesSaved[index].imagePath,
                    );
                  }));
                } else {
                  state.toggleIsSelected(index, StatusType.savedImage);
                }
              },
              onLongPress: () {
                if (!state.isLongPress)
                  state.resetIsSelected(StatusType.savedImage);

                state.toggleIsLongPress();
                state.toggleIsSelected(index, StatusType.savedImage);
              },
              child: Hero(
                tag: 'index$index',
                child: ImageCard(
                  imageFile: state.imagesSaved[index],
                ),
              ),
            ),
          );
        });
  }
}
