import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qurbani/config/size_config.dart';
import 'package:qurbani/controllers/questions_and_names_controller.dart';
import 'package:qurbani/widgets/common/custom_text_field.dart';
import 'package:qurbani/widgets/common/main_layout.dart';
import 'package:qurbani/widgets/common/submit_button.dart';

class NewQuestionName extends StatefulWidget {
  final QuestionsAndNamesController _questionsAndNamesController =
      Get.put(QuestionsAndNamesController());
  @override
  _NewQuestionNameState createState() => _NewQuestionNameState();
}

class _NewQuestionNameState extends State<NewQuestionName> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          child: MainLayout(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('Settings'),
              SizedBox(
                height: SizeConfig.blockSizeVertical * 3,
              ),
              Card(
                margin: EdgeInsets.symmetric(
                    horizontal: SizeConfig.blockSizeHorizontal * 0),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: SizeConfig.blockSizeHorizontal * 6,
                      vertical: SizeConfig.blockSizeHorizontal * 4),
                  child: Column(
                    children: [
                      Obx(() {
                        return CustomTextField(
                          hintText: 'Name',
                          onChanged: Get.find<QuestionsAndNamesController>()
                              .setQuestionOrName,
                          errorText: Get.find<QuestionsAndNamesController>()
                              .questionOrNamesFieldError
                              .value,
                          maxLength: 255,
                          maxLines: 8,
                        );
                      }),
                      SubmitButton(
                        title: 'Send',
                        icon: Icons.send,
                        submitCallback:
                            Get.find<QuestionsAndNamesController>().onSubmit,
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: SizeConfig.blockSizeVertical * 3,
                    left: SizeConfig.blockSizeHorizontal * 2),
                child: Text('You can expect a response within 24-48 hours.'),
              )
            ]),
          ),
        ),
      ),
    );
  }
}
