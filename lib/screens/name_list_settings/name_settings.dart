import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qurbani/config/size_config.dart';
import 'package:qurbani/controllers/name_settings_controller.dart';
import 'package:qurbani/screens/name_list_settings/name_add.dart';
import 'package:qurbani/screens/name_list_settings/name_edit.dart';
import 'package:qurbani/widgets/common/custom_text_field.dart';
import 'package:qurbani/widgets/common/main_layout.dart';
import 'package:qurbani/widgets/common/submit_button.dart';

class NameSettings extends StatefulWidget {
  final NameSettingsController _nameSettingsController = Get.put(NameSettingsController());
  @override
  _NameSettingsState createState() => _NameSettingsState();
}

class _NameSettingsState extends State<NameSettings> {
  final nameList = List.generate(20, (index) => 'Name Item $index');

  Widget slideLeftBackground() {
    return Container(
      color: Colors.red,
      child: Align(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Text(
              " Delete",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.right,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: SizeConfig.blockSizeHorizontal * 3),
              child: Icon(
                Icons.delete,
                color: Colors.white,
              ),
            ),
          ],
        ),
        alignment: Alignment.centerRight,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Name List'),
              SizedBox(
                height: SizeConfig.blockSizeVertical * 3,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: 20,
                  itemBuilder: (context, int index){
                    return Dismissible(
                      direction: DismissDirection.endToStart,
                      background: Icon(Icons.zoom_out_rounded),
                      secondaryBackground: slideLeftBackground(),
                      onDismissed: (dismissDirection){

                      },
                      key: Key('$index'),
                      child: ListTile(
                        title: Text('Name $index'),
                        subtitle: Text('Subtitle $index'),
                        trailing: Icon(Icons.arrow_forward_ios_rounded, size: SizeConfig.blockSizeHorizontal * 5,),
                        onTap: (){
                          Get.find<NameSettingsController>().setName(
                              {
                                'name_en': 'Name in English',
                                'name_ar': 'Name in Arabic',
                                'name_dh': 'Name in Dhivehi',
                                'meaning': 'Name Meaning',
                                'gender':'Male',
                                'origin': 'Arabic'
                              }
                          );
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => NameEdit()));
                        },
                      ),
                    );
                  },
                ),
              )
            ],
          ),
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            backgroundColor: Colors.teal,
            autofocus: true,
            onPressed: (){
              Get.find<NameSettingsController>().setName({
                'name_en': '',
                'name_ar': '',
                'name_dh': '',
                'meaning': '',
                'gender':'Male',
                'origin': 'Arabic'
              });
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddName()));
            },
          ),
        ));
  }
}
