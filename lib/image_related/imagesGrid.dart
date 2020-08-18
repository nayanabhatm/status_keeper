import 'package:flutter/material.dart';
import 'package:statuskeeper/models/viewModel.dart';
import 'package:provider/provider.dart';
import 'package:statuskeeper/image_related/imageCard.dart';
import 'package:statuskeeper/screens/displayImage.dart';

class ImagesGrid extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    var viewModelImagesData = Provider.of<StatusViewModel>(context , listen: false);
        return GridView.builder(
            gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 1.0,
                  mainAxisSpacing: 1.0,
            ),
            itemCount: viewModelImagesData.imageFilesWhatsappDirCount ,
            itemBuilder:(context,index){
              return Container(
                child: GestureDetector(
                  onTap: (){
                    if(!viewModelImagesData.isLongPress){
                        Navigator.push(context, MaterialPageRoute(builder: (_) {
                          return DisplayImage(index: index, imageFilePath: viewModelImagesData.imageFilesWhatsAppDir[index].imagePath,);
                        })
                        );
                    }
                    else {
                      viewModelImagesData.toggleIsSelected(index,'images');
                    }
                  },
                  onLongPress: () {
                    if(!viewModelImagesData.isLongPress)
                            viewModelImagesData.resetIsSelected('images');

                    viewModelImagesData.toggleIsLongPress();
                    viewModelImagesData.toggleIsSelected(index,'images');
                  },

                  child: Hero(
                    tag: 'index$index',
                    child: ImageCard(
                      imageFile:viewModelImagesData.imageFilesWhatsAppDir[index],
                    ),
                  ),
                ),
              ) ;
            }
        );
  }
}


