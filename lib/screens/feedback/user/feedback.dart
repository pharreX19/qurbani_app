import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:qurbani/config/size_config.dart';
import 'package:qurbani/controllers/feedback_controller.dart';
import 'package:qurbani/providers/feedback_validation_provider.dart';
import 'package:qurbani/widgets/common/custom_text_field.dart';
import 'package:qurbani/widgets/common/main_layout.dart';
import 'package:qurbani/widgets/common/submit_button.dart';

class Feedback extends StatefulWidget {
  @override
  _FeedbackState createState() => _FeedbackState();
}

class _FeedbackState extends State<Feedback> {
  final FeedbackController _questionsAndNamesController = Get.put(FeedbackController());
  // final TextEditingController textEditingController = TextEditingController();
  FeedbackValidationProvider _validationService;

  @override
  void dispose() {
    super.dispose();
    _validationService.resetValidation();
    // textEditingController.dispose();
  }

  void _submitFeedback(){
    FocusScope.of(context).unfocus();
    Get.find<FeedbackController>().onSubmit(context, _validationService.feedbackMessage.value, _validationService.resetValidation);
  }

  @override
  Widget build(BuildContext context) {
    _validationService = Provider.of<FeedbackValidationProvider>(context);
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
                    CustomTextField(
                        controller: _validationService.feedbackMessageController, //Get.find<QuestionsAndNamesController>().textEditingController,
                        hintText: _validationService.feedbackMessage.value ?? 'You message goes here...',
                       onChanged: (String message){
                         _validationService.onChangeFeedbackMessage(message);
                       },
                        errorText: _validationService.feedbackMessage.error,
                        maxLength: 255,
                        maxLines: 8,
                      ),
                    SizedBox(
                      height: SizeConfig.blockSizeVertical * 2,
                    ),
                    SubmitButton(
                      title: 'Send',
                      icon: Icons.send,
                      submitCallback: _validationService.isValid ? _submitFeedback : null,
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
