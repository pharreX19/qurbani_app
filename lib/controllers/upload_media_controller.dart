import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:qurbani/providers/media_upload_validation_provider.dart';
import 'package:qurbani/services/api_service.dart';

class UploadMediaController extends GetxController{
  RxList<dynamic> videos = [].obs;
  RxList<dynamic> images = [].obs;
  List<String> allowedImageExtensions = ['jpg', 'png', 'jpeg'];
  List<String> allowedVideoExtensions = ['mp4', 'avi', 'mpg', 'mov'];


//  void pickVideo() async{
//    FilePickerResult result = await FilePicker.platform.pickFiles(allowMultiple: true, type: FileType.video);
//    if(result != null) {
//      List<String> temp = result.paths.map((path) => path).toList();
//      videos.addAll(temp);
//    } else {
//      // User canceled the picker
//    }
//  }

  void pickImage(MediaUploadValidationProvider validationService) async{
    List<String> allowedExtensions = [...allowedImageExtensions, ...allowedVideoExtensions];
    FilePickerResult result = await FilePicker.platform.pickFiles(allowMultiple: true, type: FileType.custom, allowedExtensions: allowedExtensions);
    if(result != null) {
//      List<String> temp = ;
      images.addAll(result.paths.map((path) => path).toList());
      validationService.setMediaCount(images.length);

      print(images);
    } else {
      // User canceled the picker
    }
  }

  void removeMedia(String media, MediaUploadValidationProvider validationService){
    images.removeWhere((element) => element == media);
    validationService.setMediaCount(images.length);
  }

  Future<void> uploadMedia(String title) async{
    List<String> base64Images = [];
    images.forEach((image) {
      List<int> imageBytes = File(image).readAsBytesSync();
      String base64Image = base64Encode(imageBytes);
        base64Images.add(base64Image);
    });
    ApiService.instance.updateRequest('requests/LsoyOKR7TU8L57QcCXHl/upload', {'title': title,  'images': base64Images});
  }

}