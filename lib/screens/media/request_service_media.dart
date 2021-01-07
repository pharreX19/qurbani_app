import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qurbani/config/size_config.dart';
import 'package:qurbani/controllers/upload_media_controller.dart';
import 'package:qurbani/screens/media/media_grid_veiw.dart';
import 'package:qurbani/screens/requests/admin/view_image.dart';
import 'package:qurbani/widgets/common/main_layout.dart';

class RequestServiceMedia extends StatelessWidget {
  final Stream mediaStream;
  final Map<String, dynamic> title;

  RequestServiceMedia({this.mediaStream, this.title});

  @override
  Widget build(BuildContext context) {
    UploadMediaController _controller =  Get.put(UploadMediaController());
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.teal),
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: Text('${title['type']}', style: TextStyle(color: Colors.teal),),
        centerTitle: true,
      ),
      body: MainLayout(
          child: StreamBuilder(
        stream: mediaStream,
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) {
            return Expanded(
              child: Center(
                child: Text('An error occurred, please try again later'),
              ),
            );
          }
          if (snapshot.hasData) {
            List<QueryDocumentSnapshot> media = snapshot.data.documents;
            if(media.length > 0){
              return MediaGridView(media: media);
            }else{
              return Center(
                child: Text('No images/videos found!'),
              );
            }
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      )),
    );
  }
}
