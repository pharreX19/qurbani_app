// import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
//import 'package:file_picker/file_picker.dart';
import 'package:qurbani/config/size_config.dart';
import 'package:qurbani/widgets/common/main_layout.dart';

class UploadImagesVideos extends StatefulWidget {
  @override
  _UploadImagesVideosState createState() => _UploadImagesVideosState();
}

class _UploadImagesVideosState extends State<UploadImagesVideos> {
//  FilePicker imagePicker = FilePicker();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
                maxLength: 100,
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(
                    vertical: SizeConfig.blockSizeVertical * 2,
                    horizontal: SizeConfig.blockSizeVertical * 2,
                  ),
                  fillColor: Colors.grey[100],
                  filled: true,
                  suffixIcon: Icon(Icons.camera, color: Colors.grey[500]),
                  border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(4.0)),
                  floatingLabelBehavior: FloatingLabelBehavior.auto,
                  hintText: 'Title',
                  hintStyle: TextStyle(color: Colors.grey[500]),
                  counterText: '',
                ),),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical * 5),
                      width: SizeConfig.blockSizeHorizontal * 30,
                      height: SizeConfig.blockSizeHorizontal * 30,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                      ),
                      child: IconButton(
                        icon: Icon(Icons.image, size: SizeConfig.blockSizeHorizontal * 10, color: Colors.grey[400],),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical * 5),
                      width: SizeConfig.blockSizeHorizontal * 30,
                      height: SizeConfig.blockSizeHorizontal * 30,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                      ),
                      child: IconButton(
                        onPressed: () async{
                         // final FilePickerResult pickedImage = await FilePicker.platform.pickFiles(allowMultiple: true, type: FileType.custom, allowedExtensions: ['jpg', 'png']);
                        },
                        icon: Icon(Icons.video_call, size: SizeConfig.blockSizeHorizontal * 10, color: Colors.grey[400],),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: Center(child: Text('No Images/ Videos found!')),
                ),
                ButtonTheme(
                    minWidth: SizeConfig.blockSizeHorizontal * 100,
                    child: RaisedButton.icon(onPressed: (){}, color: Colors.teal, label: Text('Upload'), icon: Icon(Icons.file_upload),))
          ]),
        ),
      ),
    );
  }
}
