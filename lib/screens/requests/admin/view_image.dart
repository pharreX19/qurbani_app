import 'package:flutter/material.dart';
import 'package:qurbani/config/size_config.dart';

class ViewImage extends StatelessWidget {
  final String imageUrl;

  ViewImage({this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black87),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: SizeConfig.blockSizeHorizontal * 4, top: SizeConfig.blockSizeVertical * 1),
            child:  DropdownButton(
              dropdownColor: Colors.black87,
              underline: Container(),
              onChanged: (value){
                print(value);
              },
              icon: Icon(Icons.more_vert_rounded),
              items: [
                DropdownMenuItem(
                  value: 1,
                  child: Text('Save to gallery', style: TextStyle(color: Colors.white),),
                )
              ],
            )
          )
        ],
      ),
      body: Stack(
        children: [
          Center(
            child: imageUrl == null ? Text('No Image found') :
            Image.network(imageUrl, fit: BoxFit.cover,
              frameBuilder: (context, Widget child, int frame, bool wasSynchronouslyLoaded ){
                if(wasSynchronouslyLoaded){
                  return child;
                }
                return frame == null ? Center(
                  child: CircularProgressIndicator(),
                ) : child;
              },
            ),
          ),

        ],
      )
    );
  }
}
