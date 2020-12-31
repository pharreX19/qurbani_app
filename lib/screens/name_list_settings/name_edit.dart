import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:qurbani/config/size_config.dart';
import 'package:qurbani/controllers/name_settings_controller.dart';
import 'package:qurbani/providers/name_validation_provider.dart';
import 'package:qurbani/widgets/common/main_layout.dart';
import 'package:qurbani/widgets/common/submit_button.dart';

class NameEdit extends StatefulWidget {
  final DocumentSnapshot name;

  NameEdit({this.name});

  @override
  _NameEditState createState() => _NameEditState();
}

class _NameEditState extends State<NameEdit> {
  NameValidationProvider _validationService;

  void _updateName(){
    FocusScope.of(context).unfocus();
    Get.find<NameSettingsController>().updateName(context, {
      'id' : widget.name.id,
      'name_en': _validationService.nameInEnglish.value,
      'name_dh': _validationService.nameInDhivehi.value,
      'name_ar' : _validationService.nameInArabic.value,
      'meaning' : _validationService.nameMeaning.value,
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {

      _validationService.onArabicNameChanged(widget.name['name_ar']);
      _validationService.onDhivehiNameChanged(widget.name['name_dh']);
      _validationService.onEnglishNameChanged(widget.name['name_en']);
      _validationService.onNameMeaningChanged(widget.name['meaning']);
    });
  }

  @override
  Widget build(BuildContext context) {
    _validationService = Provider.of<NameValidationProvider>(context);

    return WillPopScope(
      onWillPop: (){
        _validationService.resetValues();
        return Future.value(true);
      },
      child: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: MainLayout(
            child: Column(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('Edit Name'),
              SizedBox(
                height: SizeConfig.blockSizeVertical * 5,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextField(
                      textAlign: TextAlign.center,
                      controller: _validationService.arabicNameController, //Get.find<NameSettingsController>().arabicNameController,
                      onChanged: (name){
                        _validationService.onArabicNameChanged(name);
                      },
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: _validationService.nameInArabic.value,
                      ),
//                    onChanged: Get.find<NameSettingsController>().onArabicNameChanged,
                    ),
                  Padding(
                    padding: EdgeInsets.only(top: SizeConfig.blockSizeVertical * 2),
                    child: TextField(
                      textAlign: TextAlign.center,
                      onChanged: (name){
                        _validationService.onDhivehiNameChanged(name);
                      },
                      controller: _validationService.dhivehiNameController, //Get.find<NameSettingsController>().englishNameController,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: _validationService.nameInDhivehi.value
                      ),
//                      onChanged: Get.find<NameSettingsController>().onEnglishNameChanged,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: SizeConfig.blockSizeVertical * 2),
                    child: TextField(
                        textAlign: TextAlign.center,
                        onChanged: (name){
                          _validationService.onEnglishNameChanged(name);
                        },
                        controller: _validationService.englishNameController, //Get.find<NameSettingsController>().englishNameController,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: _validationService.nameInEnglish.value
                        ),
//                      onChanged: Get.find<NameSettingsController>().onEnglishNameChanged,
                      ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: SizeConfig.blockSizeVertical * 2),
                    child: TextField(
                        textAlign: TextAlign.center,
                         controller: _validationService.nameMeaningController, //Get.find<NameSettingsController>().nameMeaningController,
                        maxLines: 6,
                        maxLength: 255,
                        onChanged: (name){
                          _validationService.onNameMeaningChanged(name);
                        },
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: SizeConfig.blockSizeHorizontal * 2,
                              vertical: SizeConfig.blockSizeHorizontal * 4,
                            ),
                            border: InputBorder.none,
                            fillColor: Colors.grey[100],
                            filled: true,
                            hintText: _validationService.nameMeaning.value
                        ),
//                    onChanged: Get.find<NameSettingsController>().onNameMeaningChanged,
                      ),
                  ),
                  SizedBox(height: SizeConfig.blockSizeVertical * 1,),
                  SubmitButton(title: 'Update', icon: Icons.check,
                    submitCallback: _updateName)
                ],
              )
            ]),
          ),
        ),
      ),
    );
  }
}
