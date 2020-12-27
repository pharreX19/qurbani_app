import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qurbani/config/size_config.dart';
import 'package:qurbani/controllers/name_settings_controller.dart';
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
    // {'gender': 'Male', 'checked': true},
    // {'gender': 'Female', 'checked': false}
  // ];

  List<String> _nameOriginList = ['Arabic', 'Hebrew', 'Turkish'];

  @override
  Widget build(BuildContext context) {
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
                      Obx((){
                        return CustomTextField(
                          suffixIcon: Icons.person,
                          hintText: 'الاسم بالعربي',
                          textDirection: TextDirection.rtl,
                          onChanged: Get.find<NameSettingsController>().onArabicNameChanged,
                          errorText: Get.find<NameSettingsController>().arabicNameFieldError.value,
                        );
                      }),
                      SizedBox(height: SizeConfig.blockSizeVertical * 2,),
                      Obx((){
                        return CustomTextField(
                          suffixIcon: Icons.person,
                          hintText: 'ނަން ދިވެހިބަހުން',
                          textDirection: TextDirection.rtl,
                          onChanged: Get.find<NameSettingsController>().onDhivehiNameChanged,
                          errorText: Get.find<NameSettingsController>().dhivehiNameFieldError.value,
                        );
                      }),
                      SizedBox(height: SizeConfig.blockSizeVertical * 2,),
                      Obx((){
                        return CustomTextField(
                          leading: Icon(Icons.person, color: Colors.teal,),
                          hintText: 'Name in English',
                          onChanged: Get.find<NameSettingsController>().onEnglishNameChanged,
                          errorText: Get.find<NameSettingsController>().englishNameFieldError.value,
                        );
                      }),
                      SizedBox(height: SizeConfig.blockSizeVertical * 2,),
                      Obx((){
                        return CustomTextField(
                          hintText: 'Name meaning',
                          maxLines: 5,
                          maxLength: 255,
                          onChanged: Get.find<NameSettingsController>().onNameMeaningChanged,
                          errorText: Get.find<NameSettingsController>().nameMeaningFieldError.value,
                        );
                      }),
                      SizedBox(height: SizeConfig.blockSizeVertical * 2,),
                      ..._gendersTitle.map((gender){
                        return Obx((){
                          return ListTile(
                            trailing: Checkbox(
                              value: Get.find<NameSettingsController>().nameGender.contains(gender),
                              onChanged: (value){
                                if(value){
                                  Get.find<NameSettingsController>().onNameGenderChanged(gender);
                                }
                                setState(() {
                                  // gender['checked'] = value;
                                });
                              },
                              fillColor: MaterialStateProperty.all(Colors.teal),
                              materialTapTargetSize: MaterialTapTargetSize.padded,
                            ),
                            title: Text(gender),
                          );
                        });
                      }),
                     Obx((){
                       return Padding(
                         padding: EdgeInsets.only(
                             left: SizeConfig.blockSizeHorizontal * 3.5,
                             bottom: SizeConfig.blockSizeHorizontal * 3
                         ),
                         child: Align(
                           alignment: Alignment.centerLeft,
                           child: Text(Get.find<NameSettingsController>().nameGenderFieldError.value,
                             style: TextStyle(color: Colors.red[600]),),
                         ),
                       );
                     }),
                     ListTile(
                         title: Obx((){
                           return Text(Get.find<NameSettingsController>().origin.value);
                         }),
                         trailing: Padding(
                           padding: EdgeInsets.only(right: SizeConfig.blockSizeHorizontal * 2.5,),
                           child: Icon(Icons.location_on_outlined, color: Colors.teal,),
                         ),
                         onTap: (){
                            showSearch(context: context, delegate: NameOriginSearchDelegate(searchSuggestions: _nameOriginList));
                         },
                       ),
                     // }),
                      SizedBox(height: SizeConfig.blockSizeVertical * 3,),
                      SubmitButton(
                        title: 'Save',
                        icon: Icons.save,
                        submitCallback: Get.find<NameSettingsController>().registerName,
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
