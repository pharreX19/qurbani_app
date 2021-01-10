import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qurbani/config/size_config.dart';
import 'package:video_player/video_player.dart';

class ChewieListItem extends StatefulWidget {
  final VideoPlayerController videoPlayerController;
  final bool looping;

  ChewieListItem({this.looping, this.videoPlayerController, Key key}) : super(key: key);

  @override
  _ChewieListItemState createState() => _ChewieListItemState();
}

class _ChewieListItemState extends State<ChewieListItem> {
  ChewieController _chewieController;

  @override
  void initState() {
    print(widget.videoPlayerController.value.aspectRatio);
    super.initState();
    _chewieController = ChewieController(
      fullScreenByDefault: true,
      allowedScreenSleep: false,
      deviceOrientationsAfterFullScreen: [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown],
//      deviceOrientationsOnEnterFullScreen: [DeviceOrientation.landscapeRight, DeviceOrientation.landscapeLeft],
      videoPlayerController: widget.videoPlayerController,
      aspectRatio: 10/12,
      autoInitialize: true,
      looping: widget.looping,
      errorBuilder: (context, errorMessage){
        return Center(
          child: Text(errorMessage, style: TextStyle(color: Colors.white),),
        );
      }
    );
  }

  @override
  void dispose() {
    widget.videoPlayerController.dispose();
  _chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Chewie(
            controller: _chewieController,
          ),
        ),
      ],
    );
  }
}
