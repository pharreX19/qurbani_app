import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:qurbani/config/size_config.dart';
import 'package:qurbani/controllers/name_settings_controller.dart';
import 'package:qurbani/providers/name_validator_provider.dart';
import 'package:qurbani/screens/name_list_settings/name_origin_search_delegate.dart';
import 'package:qurbani/widgets/common/custom_text_field.dart';
import 'package:qurbani/widgets/common/main_layout.dart';
import 'package:qurbani/widgets/common/submit_button.dart';

class AddName extends StatefulWidget {
  @override
  _AddNameState createState() => _AddNameState();
}

class _AddNameState extends State<AddName> {

  List<String> _gendersTitle = ['Male', 'Female'];
  final TextEditingController _englishNameController = TextEditingController();
  final TextEditingController _arabicNameController = TextEditingController();
  final TextEditingController _dhivehiNameController = TextEditingController();
  final TextEditingController _nameMeaningController = TextEditingController();
  NameValidationProvider validationService;
    // {'gender': 'Male', 'checked': true},
    // {'gender': 'Female', 'checked': false}
  // ];

  List<String> _nameOriginList = ['Arabic', 'Hebrew', 'Turkish'];
  List<dynamic> nameGender = ['Male'];

  void _clearForm(){
    _englishNameController.text = '';
    _arabicNameController.text = '';
    _dhivehiNameController.text = '';
    _nameMeaningController.text = '';
  }

  void _submitForm(){
    Get.find<NameSettingsController>().registerName({
      'name_en': _englishNameController.text,
      'name_ar': _arabicNameController.text,
      'name_dh': _dhivehiNameController.text,
      'meaning': _nameMeaningController.text,
      'origin' : validationService.nameOrigin.value,
      'gender' : validationService.nameGender.value
    }, _clearForm);
  }

  @override
  Widget build(BuildContext context) {
    validationService = Provider.of<NameValidationProvider>(context);
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          child: MainLayout(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('Add new name'),
              SizedBox(
                height: SizeConfig.blockSizeVertical * 3,
              ),
              Card(
                elevation: 0,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: SizeConfig.blockSizeHorizontal * 4,
                      vertical: SizeConfig.blockSizeVertical * 2),
                  child: Column(
                    children: [
                      CustomTextField(
                          suffixIcon: Icons.person,
                          hintText: 'الاسم بالعربي',
                          textDirection: TextDirection.rtl,
                          controller: _arabicNameController,
                          onChanged: (String value){
                            validationService.onArabicNameChanged(value);
                          },//Get.find<NameSettingsController>().onArabicNameChanged,
                          errorText: validationService.nameInArabic.error //Get.find<NameSettingsController>().arabicNameFieldError.value,
                        ),
                      SizedBox(height: SizeConfig.blockSizeVertical * 2,),
                      CustomTextField(
                          suffixIcon: Icons.person,
                          hintText: 'ނަން ދިވެހިބަހުން',
                          controller: _dhivehiNameController,
                          textDirection: TextDirection.rtl,
                          onChanged: (String value){
                            validationService.onDhivehiNameChanged(value);
                          }, //Get.find<NameSettingsController>().onDhivehiNameChanged,
                          errorText: validationService.nameInDhivehi.error//Get.find<NameSettingsController>().dhivehiNameFieldError.value,
                        ),
                      SizedBox(height: SizeConfig.blockSizeVertical * 2,),
                     CustomTextField(
                          leading: Icons.person,
                          hintText: 'Name in English',
                          controller: _englishNameController,
                          onChanged: (String value){
                            validationService.onEnglishNameChanged(value);
                          }, //Get.find<NameSettingsController>().onEnglishNameChanged,
                          errorText: validationService.nameInEnglish.error// Get.find<NameSettingsController>().englishNameFieldError.value,
                        ),
                      SizedBox(height: SizeConfig.blockSizeVertical * 2,),
                      CustomTextField(
                          hintText: 'Name meaning',
                          maxLines: 5,
                          maxLength: 255,
                          controller: _nameMeaningController,
                          onChanged: (String value){
                            validationService.onNameMeaningChanged(value);
                          },//Get.find<NameSettingsController>().onNameMeaningChanged,
                          errorText: validationService.nameMeaning.error// Get.find<NameSettingsController>().nameMeaningFieldError.value,
                        ),
                      SizedBox(height: SizeConfig.blockSizeVertical * 2,),
                      ..._gendersTitle.map((gender){
                        return ListTile(
                            trailing: Checkbox(
                              value: validationService.nameGender.value.contains(gender), //nameGender.contains(gender),
                              onChanged: (value){
                                validationService.onNameGenderChanged(gender, value);
                                // setState(() {
                                //   if(value){
                                //     nameGender.add(gender);
                                //   }else{
                                //     nameGender.remove(gender);
                                //   }
                                // });
                              },
                             fillColor: MaterialStateProperty.all(Colors.teal),
                              materialTapTargetSize: MaterialTapTargetSize.padded,
                            ),
                            title: Text(gender),
                          );
                      }),
                      validationService.nameGender.error == null ? Container() :
                      Padding(
                         padding: EdgeInsets.only(
                             left: SizeConfig.blockSizeHorizontal * 3.5,
                             bottom: SizeConfig.blockSizeHorizontal * 3
                         ),
                         child: Align(
                           alignment: Alignment.centerLeft,
                           child: Text(validationService.nameGender.error,
                             style: TextStyle(color: Colors.red[600]),),
                         ),
                       ),
                     ListTile(
                         title: Text(validationService.nameOrigin.value),//Get.find<NameSettingsController>().origin.value);
                         trailing: Padding(
                           padding: EdgeInsets.only(right: SizeConfig.blockSizeHorizontal * 2.5,),
                           child: Icon(Icons.location_on_outlined, color: Colors.teal,),
                         ),
                         onTap: (){
                            showSearch(context: context, delegate: NameOriginSearchDelegate(searchSuggestions: _nameOriginList,
                                validationService: validationService));
                         },
                       ),
                     // }),
                      SizedBox(height: SizeConfig.blockSizeVertical * 3,),
                      SubmitButton(
                        title: 'Save',
                        icon: Icons.save,
                        submitCallback: (validationService.isValid) ? _submitForm : null
                      )
                    ],
                  ),
                ),
              )
            ]),
          )
        )
      ),
    );
  }
}
