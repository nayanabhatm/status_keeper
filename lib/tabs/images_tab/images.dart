import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:statuskeeper/models/status_store.dart';
import 'package:statuskeeper/screens/displayImage.dart';
import 'package:statuskeeper/tabs/images_tab/imageCard.dart';

class Images extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var state = Provider.of<StatusStore>(context, listen: false);
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 1.0,
        mainAxisSpacing: 1.0,
      ),
      itemCount: state.imagesCount,
      itemBuilder: (context, index) {
        return Container(
          child: GestureDetector(
            onTap: () {
              if (!state.isLongPress) {
                Navigator.push(context, MaterialPageRoute(builder: (_) {
                  return DisplayImage(
                    index: index,
                    imageFilePath: state.images[index].imagePath,
                  );
                }));
              } else {
                state.toggleIsSelected(index, StatusType.image);
              }
            },
            onLongPress: () {
              if (!state.isLongPress) state.resetIsSelected(StatusType.image);

              state.toggleIsLongPress();
              state.toggleIsSelected(index, StatusType.image);
            },
            child: Hero(
              tag: 'index$index',
              child: ImageCard(
                imageFile: state.images[index],
              ),
            ),
          ),
        );
      },
    );
  }
}
