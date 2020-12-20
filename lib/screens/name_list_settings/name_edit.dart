import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qurbani/config/size_config.dart';
import 'package:qurbani/controllers/name_settings_controller.dart';
import 'package:qurbani/widgets/common/main_layout.dart';
import 'package:qurbani/widgets/common/submit_button.dart';

class NameEdit extends StatefulWidget {
  @override
  _NameEditState createState() => _NameEditState();
}

class _NameEditState extends State<NameEdit> {
  // final TextEditingController _arabicNameController = TextEditingController(text: 'Arabic Name');
  // final TextEditingController _englishNameController = TextEditingController(text: 'English Name');
  // final TextEditingController _nameMeaningController = TextEditingController(text: 'Name Meaning');

  @override
  Widget build(BuildContext context) {
    print(Get.find<NameSettingsController>().name);
    return SafeArea(
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
                Obx((){
                  return TextField(
                    textAlign: TextAlign.center,
                    // controller: Get.find<NameSettingsController>().arabicNameController,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: Get.find<NameSettingsController>().name['name_ar']
                    ),
                    onChanged: Get.find<NameSettingsController>().onArabicNameChanged,
                  );
                }),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: SizeConfig.blockSizeVertical * 2),
                  child: Obx((){
                    return TextField(
                      textAlign: TextAlign.center,
                      // controller: Get.find<NameSettingsController>().englishNameController,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: Get.find<NameSettingsController>().name['name_en']
                      ),
                      onChanged: Get.find<NameSettingsController>().onEnglishNameChanged,
                    );
                  })
                ),
                Obx((){
                  return TextField(
                    textAlign: TextAlign.center,
                    // controller: Get.find<NameSettingsController>().nameMeaningController,
                    maxLines: 6,
                    maxLength: 255,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: SizeConfig.blockSizeHorizontal * 2,
                          vertical: SizeConfig.blockSizeHorizontal * 4,
                        ),
                        border: InputBorder.none,
                        fillColor: Colors.grey[100],
                        filled: true,
                        hintText: Get.find<NameSettingsController>().name['meaning']
                    ),
                    onChanged: Get.find<NameSettingsController>().onNameMeaningChanged,
                  );
                }),
                SizedBox(height: SizeConfig.blockSizeVertical * 1,),
                SubmitButton(title: 'Update', icon: Icons.check, submitCallback: Get.find<NameSettingsController>().updateOrRegisterName,)
              ],
            )
          ]),
        ),
      ),
    );
  }
}
