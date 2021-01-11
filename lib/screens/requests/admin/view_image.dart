import 'dart:io';

import 'package:flutter/material.dart';
import 'package:qurbani/config/size_config.dart';

class ViewImage extends StatefulWidget {
  final String imageUrl;

  ViewImage({this.imageUrl});

  @override
  _ViewImageState createState() => _ViewImageState();
}

class _ViewImageState extends State<ViewImage> with SingleTickerProviderStateMixin{
  AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this, duration: Duration(milliseconds: 100));
//    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    print(_animationController.value);
    return Scaffold(
//      backgroundColor: Colors.white,
//      appBar: AppBar(
//        iconTheme: IconThemeData(color: Colors.black87),
//        backgroundColor: Colors.transparent,
//        elevation: 0.0,
//        actions: [
//          Padding(
//            padding: EdgeInsets.only(right: SizeConfig.blockSizeHorizontal * 4, top: SizeConfig.blockSizeVertical * 1),
//            child:  DropdownButton(
//              dropdownColor: Colors.black87,
//              underline: Container(),
//              onChanged: (value){
//                print(value);
//              },
//              icon: Icon(Icons.more_vert_rounded),
//              items: [
//                DropdownMenuItem(
//                  value: 1,
//                  child: Text('Save to gallery', style: TextStyle(color: Colors.white),),
//                )
//              ],
//            )
//          )
//        ],
//      ),
      body: widget.imageUrl == null ? Text('No Image found') :
        Stack(
          children: [
            InkWell(
              onTap: (){
                print(_animationController.status);
                if(_animationController.isCompleted){
                  _animationController.reverse();
                }else{
                  _animationController.forward();
                }
              },
              child: widget.imageUrl.startsWith('http') ?
              Image.network(widget.imageUrl, fit: BoxFit.fill,
                width: SizeConfig.blockSizeHorizontal * 100,
                height: SizeConfig.blockSizeVertical * 100,
                frameBuilder: (context, Widget child, int frame, bool wasSynchronouslyLoaded ){
                  if(wasSynchronouslyLoaded){
                    return child;
                  }
                  return frame == null ? Center(
                    child: CircularProgressIndicator(),
                  ) : child;
                },
              ):
              Image.file(File(widget.imageUrl), width: SizeConfig.blockSizeHorizontal * 100, height: SizeConfig.blockSizeVertical * 100,),
            ),
            AnimatedBuilder(
              animation: _animationController,
              builder: (context, child){
                return Transform.translate(
                  offset: Offset(0, -_animationController.value * 64),
                  child: Container(
                    padding: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal * 4, right: SizeConfig.blockSizeHorizontal * 4, top: SizeConfig.blockSizeVertical * 4),
                    color: Colors.white.withOpacity(0.3),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(icon: Icon(Icons.arrow_back), onPressed: (){
                          Navigator.of(context).pop();
                        }),
                        DropdownButton(
                          dropdownColor: Colors.black87,
                          underline: Container(),
                          onChanged: (value){
                            print(value);
                          },
                          icon: Icon(Icons.more_vert_rounded, color: Colors.black87,),
                          items: [
                            DropdownMenuItem(
                              value: 1,
                              child: Text('Save to gallery', style: TextStyle(color: Colors.white),),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        )
    );
  }
}
