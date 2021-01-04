import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:qurbani/config/size_config.dart';
import 'package:qurbani/controllers/requests_controller.dart';
import 'package:qurbani/providers/completed_service_visibility_provider.dart';
import 'package:qurbani/screens/image_video_upload/upload_images_videos.dart';
import 'package:qurbani/screens/requests/admin/view_image.dart';

class RequestOptionsBottomSheet extends StatefulWidget {
  final String receiptUrl;

  RequestOptionsBottomSheet({this.receiptUrl});

  @override
  _RequestOptionsBottomSheetState createState() => _RequestOptionsBottomSheetState();
}

class _RequestOptionsBottomSheetState extends State<RequestOptionsBottomSheet> {
  CompletedServiceVisibilityProvider _completedServiceVisibility;

  // bool _hideCompleted = true;

  void _downloadReceipt(){
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => ViewImage(imageUrl: widget.receiptUrl,)));
    // Navigator.of(context).pop();
    // Scaffold.of(context).showSnackBar(SnackBar(content: Text('Downloading bank receipt'),));
  }

  void _uploadImagesOrVideos(){
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => UploadImagesVideos()));

  }

  @override
  Widget build(BuildContext context) {
    _completedServiceVisibility = Provider.of<CompletedServiceVisibilityProvider>(context);
    return Container(
      padding: EdgeInsets.symmetric(vertical: SizeConfig.blockSizeVertical * 1),
      height: SizeConfig.blockSizeVertical * 29,
      child: Column(
        children: [
          ListTile(
            leading: Icon(Icons.image),
            title: Text('View receipt'),
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
              trailing: _completedServiceVisibility.hideCompleted ?  Icon(Icons.check) : null,
              onTap: (){
                _completedServiceVisibility.toggleHideCompleted();
              },
            ),
        ],
      )
    );
  }
}
