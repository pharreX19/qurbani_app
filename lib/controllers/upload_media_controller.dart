import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qurbani/providers/media_upload_validation_provider.dart';
import 'package:qurbani/services/api_service.dart';

class UploadMediaController extends GetxController{
  RxList<dynamic> videos = [].obs;
  RxList<dynamic> images = [].obs;
  List<String> allowedImageExtensions = ['jpg', 'png', 'jpeg'];
  List<String> allowedVideoExtensions = ['mp4', 'avi', 'mpg', 'mov'];
  RxBool isUploadingImages = false.obs;

//  void pickVideo() async{
//    FilePickerResult result = await FilePicker.platform.pickFiles(allowMultiple: true, type: FileType.video);
//    if(result != null) {
//      List<String> temp = result.paths.map((path) => path).toList();
//      videos.addAll(temp);
//    } else {
//      // User canceled the picker
//    }
//  }

  Stream<QuerySnapshot> fetchRequestImages(String id){
    return FirebaseFirestore.instance.collection('requests').doc(id).collection('images').snapshots();
  }

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

  Future<void> uploadMedia(String title, String id, MediaUploadValidationProvider validationService) async{
    List<String> mediaList = [];
    images.forEach((image) {
      mediaList.add(image);
//      List<int> imageBytes = File(image).readAsBytesSync();
//      String base64Image = base64Encode(imageBytes);
//        base64Images.add(base64Image);
    });
    print(mediaList);
    try{
      isUploadingImages.value = true;
      dynamic response = await ApiService.instance.uploadMedia('requests/$id/upload', {'title': title,  'image': mediaList});
      images.assignAll([]);
      validationService.setMediaCount(0);
      isUploadingImages.value = false;
//      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Files upload successfully')));
    }catch(e){
      print('Exception while uploading images $e');
    }
  }

}