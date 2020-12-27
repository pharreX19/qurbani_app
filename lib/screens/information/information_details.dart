import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qurbani/config/size_config.dart';
import 'package:qurbani/controllers/information_controller.dart';
import 'package:qurbani/widgets/common/custom_app_bar.dart';
import 'package:qurbani/widgets/common/main_layout.dart';
import 'package:url_launcher/url_launcher.dart';

class InformationDetails extends StatelessWidget {
  final Map<String, dynamic> information;
  InformationDetails({this.information});

  Future<void> _launchInBrowser(String url) async {
    if (await canLaunch(url)) {
      await launch(
        'https://www.google.com',
        forceSafariVC: false,
        forceWebView: false,
        headers: <String, String>{'my_header_key': 'my_header_value'},
      );
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: CustomAppBar().build(context),
          body: MainLayout(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(information['question']),
                SizedBox(height: SizeConfig.blockSizeVertical * 5,),
                Expanded(child: SingleChildScrollView(
                  child: Text(information['answer']),
                )),
                // Spacer(),
                SizedBox(height: SizeConfig.blockSizeVertical * 3,),
                Text('References', style: TextStyle(fontStyle: FontStyle.italic),),
                SizedBox(height: SizeConfig.blockSizeVertical * 0.7,),
                Container(
                  height: SizeConfig.blockSizeVertical * 3 * information['references'].length,
                  margin: EdgeInsets.only(bottom: SizeConfig.blockSizeVertical * 1),
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: information['references'].length,
                    itemBuilder: (context, int index){
                      return InkWell(
                        onTap: (){
                          _launchInBrowser(information['references'][index]);
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: SizeConfig.blockSizeVertical * 0.4),
                          child: Text(information['references'][index]),
                        ),
                      );
                    },
                  ),
                )
              ],
            )
          )
      )
    );
  }
}
