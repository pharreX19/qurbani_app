import 'package:flutter/material.dart';
import 'package:qurbani/config/size_config.dart';
import 'package:qurbani/screens/image_video_upload/upload_images_videos.dart';

class RequestOptionsBottomSheet extends StatefulWidget {
  @override
  _RequestOptionsBottomSheetState createState() => _RequestOptionsBottomSheetState();
}

class _RequestOptionsBottomSheetState extends State<RequestOptionsBottomSheet> {

  bool _hideCompleted = true;

  void _downloadReceipt(){
    Navigator.of(context).pop();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Downloading bank receipt'),));
  }

  void _uploadImagesOrVideos(){
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => UploadImagesVideos()));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: SizeConfig.blockSizeVertical * 1),
      height: SizeConfig.blockSizeVertical * 29,
      child: Column(
        children: [
          ListTile(
            leading: Icon(Icons.download_sharp),
            title: Text('Download receipt'),
            onTap: _downloadReceipt,
          ),
          ListTile(
            leading: Icon(Icons.camera_alt_outlined),
            title: Text('Upload images/videos'),
            onTap: _uploadImagesOrVideos,
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.list),
            title: Text('Hide completed'),
            trailing: _hideCompleted ?  Icon(Icons.check) : null,
            onTap: (){
              setState(() {
                _hideCompleted = !_hideCompleted;
              });
            },
          ),
        ],
      )
    );
  }
}
