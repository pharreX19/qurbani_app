import 'package:flutter/material.dart';
import 'package:qurbani/config/size_config.dart';
import 'package:qurbani/screens/media/chewie_list_item.dart';
import 'package:video_player/video_player.dart';

class WatchVideo extends StatelessWidget {
  final String videoUrl;


  WatchVideo({this.videoUrl});

  @override
  Widget build(BuildContext context) {
    print('VIDEO URL IS $videoUrl');
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.teal),
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
      body: Column(
        children: [
          Text('Sample Video'),
          SizedBox(height: SizeConfig.blockSizeVertical * 1.5,),
          Text('29 August 2020'),
          Expanded(
            child: ChewieListItem(
              videoPlayerController: VideoPlayerController.network(videoUrl),
            ),
          ),
          SizedBox(height: SizeConfig.blockSizeVertical * 1,)
        ],
      ),
    );
  }
}
