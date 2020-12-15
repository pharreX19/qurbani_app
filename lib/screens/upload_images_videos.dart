import 'package:flutter/material.dart';
import 'package:qurbani/config/size_config.dart';
import 'package:qurbani/widgets/common/main_layout.dart';

class UploadImagesVideos extends StatefulWidget {
  @override
  _UploadImagesVideosState createState() => _UploadImagesVideosState();
}

class _UploadImagesVideosState extends State<UploadImagesVideos> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: MainLayout(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Upload Images and Videos'),
                SizedBox(
                  height: SizeConfig.blockSizeVertical * 3,
                ),
                
              ]),
        ),
      ),
    );
  }
}
