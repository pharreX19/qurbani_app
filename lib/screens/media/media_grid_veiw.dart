import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qurbani/config/size_config.dart';
import 'package:qurbani/controllers/upload_media_controller.dart';
import 'package:qurbani/screens/media/watch_video.dart';
import 'package:qurbani/screens/requests/admin/view_image.dart';

class MediaGridView extends StatelessWidget {
  final UploadMediaController _controller = Get.put(UploadMediaController());
  final List<dynamic> media;

  MediaGridView({this.media});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        itemCount: media.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            crossAxisSpacing: 2.0,
            mainAxisSpacing: 2.0
        ),
        itemBuilder: (context, int index) {
          return InkWell(
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => ViewImage(imageUrl: media[index]['image_url'],)));
              },
              child: _controller.allowedImageExtensions.contains(media[index]['image_url'].toString().split('?')[0].split('.').last) ?
              Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey[50], width: 4.0),
                    image: DecorationImage(image: NetworkImage(media[index]['image_url']), fit: BoxFit.cover)),
              ) :
              InkWell(
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => WatchVideo(videoUrl: media[index]['image_url'],)));
                },
                child: Stack(
                  alignment: Alignment.center,
                  fit: StackFit.expand,
                  children: [
                    Image.asset('assets/images/information.jpg',  fit: BoxFit.cover),
                    Icon(Icons.play_circle_outline, size: SizeConfig.blockSizeHorizontal * 11,)
                  ],
                ),
              )
          );
        });
  }
}
