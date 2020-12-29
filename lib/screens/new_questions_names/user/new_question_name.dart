import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qurbani/config/size_config.dart';
import 'package:qurbani/controllers/questions_and_names_controller.dart';
import 'package:qurbani/widgets/common/custom_text_field.dart';
import 'package:qurbani/widgets/common/main_layout.dart';
import 'package:qurbani/widgets/common/submit_button.dart';

class NewQuestionName extends StatefulWidget {
  @override
  _NewQuestionNameState createState() => _NewQuestionNameState();
}

class _NewQuestionNameState extends State<NewQuestionName> {
  final QuestionsAndNamesController _questionsAndNamesController = Get.put(QuestionsAndNamesController());
  final TextEditingController textEditingController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    textEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          child: MainLayout(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('Ask a question'),
              SizedBox(
                height: SizeConfig.blockSizeVertical * 3,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: SizeConfig.blockSizeHorizontal * 1,
                    vertical: SizeConfig.blockSizeHorizontal * 4),
                child: Column(
                  children: [
                    Obx(() {
                      return CustomTextField(
                        controller: textEditingController, //Get.find<QuestionsAndNamesController>().textEditingController,
                        hintText: 'You message goes here...',
//                        onChanged: Get.find<QuestionsAndNamesController>().setQuestionOrName,
                        errorText: Get.find<QuestionsAndNamesController>().questionOrNamesFieldError.value,
                        maxLength: 255,
                        maxLines: 8,
                      );
                    }),
                    SizedBox(
                      height: SizeConfig.blockSizeVertical * 2,
                    ),
                    SubmitButton(
                      title: 'Send',
                      icon: Icons.send,
                      submitCallback: (){
                        Get.find<QuestionsAndNamesController>().onSubmit(context, textEditingController.text);
                          textEditingController.text = '';
                        },
                    ),
                  ],
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
