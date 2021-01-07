// import 'package:file_picker/file_picker.dart';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
//import 'package:file_picker/file_picker.dart';
import 'package:qurbani/config/size_config.dart';
import 'package:qurbani/controllers/upload_media_controller.dart';
import 'package:qurbani/providers/media_upload_validation_provider.dart';
import 'package:qurbani/screens/media/media_grid_veiw.dart';
import 'package:qurbani/screens/requests/admin/view_image.dart';
import 'package:qurbani/widgets/common/main_layout.dart';
import 'package:qurbani/widgets/common/submit_button.dart';

class UploadImagesVideos extends StatefulWidget {
  String requestId;

  UploadImagesVideos({this.requestId});

  @override
  _UploadImagesVideosState createState() => _UploadImagesVideosState();
}

class _UploadImagesVideosState extends State<UploadImagesVideos> {
  final UploadMediaController _uploadMediaController = Get.put(UploadMediaController());
  MediaUploadValidationProvider _validationService;

  void _submitUpload(){
    FocusScope.of(context).unfocus();
    _uploadMediaController.uploadMedia(_validationService.title.value.toString().toLowerCase(), widget.requestId, _validationService);
  }

  @override
  Widget build(BuildContext context) {
    _validationService = Provider.of<MediaUploadValidationProvider>(context);
    return SafeArea(
      child: Stack(
        children: [
          Scaffold(
            appBar: AppBar(
              elevation: 0.0,
              backgroundColor: Colors.transparent,
              leading: IconButton(
                icon: Icon(Icons.arrow_back_ios, color: Colors.teal,),
                onPressed: (){
                  Navigator.pop(context);
                },
              ),
            ),
            resizeToAvoidBottomInset: false,
            body: MainLayout(
              child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('Upload Images and Videos'),
                SizedBox(
                  height: SizeConfig.blockSizeVertical * 5,
                ),
                TextField(
                  controller: _validationService.titleController,
                  onChanged: _validationService.onTitleChanged,
                  maxLength: 100,
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(
                      vertical: SizeConfig.blockSizeVertical * 2,
                      horizontal: SizeConfig.blockSizeVertical * 2,
                    ),
                    fillColor: Colors.grey[100],
                    filled: true,
                    suffixIcon: IconButton(icon: Icon(Icons.camera), color: Colors.grey[500], onPressed: (){
                      _uploadMediaController.pickImage(_validationService);
                    },),
                    border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(4.0)),
                    floatingLabelBehavior: FloatingLabelBehavior.auto,
                    hintText: 'Title',
                    hintStyle: TextStyle(color: Colors.grey[500]),
                    counterText: '',
                    errorText: _validationService.title.error,
                  ),),
//                Row(
//                  mainAxisAlignment: MainAxisAlignment.spaceAround,
//                  children: [
//
//                    Container(
//                      margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical * 3),
//                      width: SizeConfig.blockSizeHorizontal * 30,
//                      height: SizeConfig.blockSizeHorizontal * 20,
//                      decoration: BoxDecoration(
//                        color: Colors.grey[200],
//                      ),
//                      child: IconButton(
//                        onPressed: _uploadMediaController.pickVideo, //() async{
//                         // final FilePickerResult pickedImage = await FilePicker.platform.pickFiles(allowMultiple: true, type: FileType.custom, allowedExtensions: ['jpg', 'png']);
////                        },
//                        icon: Icon(Icons.video_call, size: SizeConfig.blockSizeHorizontal * 10, color: Colors.grey[400],),
//                      ),
//                    ),
//                  ],
//                ),
                StreamBuilder(
                  stream: Get.find<UploadMediaController>().fetchRequestImages(widget.requestId),
                  builder: (context, AsyncSnapshot snapshot){
                    if(snapshot.hasData && snapshot.data.documents.length > 0){
                      List<QueryDocumentSnapshot> media = snapshot.data.documents;
                      print(media);
                      return Expanded(
                        child: MediaGridView(media: media)
                      );
                    }
                    return Container();
                  },
                ),
                Expanded(
                    child: Column(
                        children: [
                          Obx((){
                            if(_uploadMediaController.images.length == 0){
                              return Expanded(child: Center(child: Text('No Images/ Videos found to upload!')));
                            }
                            return Padding(
                                padding: EdgeInsets.only(top: SizeConfig.blockSizeVertical * 2),
                                child: Wrap(
                                    spacing: SizeConfig.blockSizeHorizontal * 1,
                                    children: [
                                      ..._uploadMediaController.images.map((element) => FractionallySizedBox(
                                          widthFactor: 0.24,
                                          child: _uploadMediaController.allowedImageExtensions.contains(element.toString().split('.').last) ?
                                          InkWell(
                                            onTap: (){
                                              Navigator.of(context).push(MaterialPageRoute(builder: (context) => ViewImage(imageUrl: element)));
                                            },
                                            child: Stack(
                                              children: [
                                                Image.file(File(element)),
                                                Positioned(
                                                    top: SizeConfig.blockSizeHorizontal * -3,
                                                    right: SizeConfig.blockSizeHorizontal * 0,
                                                    child: IconButton(icon: Icon(Icons.cancel, color: Colors.black87,), onPressed: (){
                                                      _uploadMediaController.removeMedia(element, _validationService);
                                                    },)),
                                              ],
                                            ),
                                          ) :
                                          Stack(
                                            alignment: Alignment.center,
                                            children: [
                                              Image.asset('assets/images/information.jpg'),
                                              Icon(Icons.play_circle_outline, size: SizeConfig.blockSizeHorizontal * 10,)
                                            ],
                                          ))),
                                    ])
                            );
                          }),
//                      Container(
//                        margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical * 3),
//                        width: SizeConfig.blockSizeHorizontal * 30,
//                        height: SizeConfig.blockSizeHorizontal * 20,
//                        decoration: BoxDecoration(
//                          color: Colors.grey[200],
//                        ),
//                        child: IconButton(
//                          onPressed: _uploadMediaController.pickImage,
//                          icon: Icon(Icons.image, size: SizeConfig.blockSizeHorizontal * 10, color: Colors.grey[400],),
//                        ),
//                      ),
                        ]
                    )
                ),
                SubmitButton(
                  title: 'Upload',
                  icon: Icons.file_upload,
                  submitCallback: _validationService.isValid ? _submitUpload : null,
                )
//                ButtonTheme(
//                    minWidth: SizeConfig.blockSizeHorizontal * 100,
//                    child: RaisedButton.icon(onPressed: (){}, color: Colors.teal, label: Text('Upload'), icon: Icon(Icons.file_upload),))
              ]),
            ),
          ),
          Obx((){
            if(Get.find<UploadMediaController>().isUploadingImages.value){
              return Container(
                width: SizeConfig.blockSizeHorizontal * 100,
                height: SizeConfig.blockSizeVertical * 100,
                color: Colors.black87,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Please wait...', style: TextStyle(decoration: TextDecoration.none, fontWeight: FontWeight.normal, fontSize: SizeConfig.blockSizeHorizontal * 4, color: Colors.white),),
                    SizedBox(height: SizeConfig.blockSizeVertical * 3,),
                    CircularProgressIndicator()
                  ],
                ),
              );
            }
            return Container();
          })
        ],
      )
    );
  }
}
