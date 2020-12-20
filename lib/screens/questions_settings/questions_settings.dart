import 'package:flutter/material.dart';
import 'package:qurbani/config/size_config.dart';
import 'package:qurbani/widgets/common/custom_text_field.dart';
import 'package:qurbani/widgets/common/main_layout.dart';
import 'package:qurbani/widgets/common/submit_button.dart';

class QuestionsSettings extends StatefulWidget {
  @override
  _QuestionsSettingsState createState() => _QuestionsSettingsState();
}

class _QuestionsSettingsState extends State<QuestionsSettings> {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: MainLayout(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Questions'),
                SizedBox(
                  height: SizeConfig.blockSizeVertical * 3,
                ),
              ],
            ),
          ),
        ));
  }
}
