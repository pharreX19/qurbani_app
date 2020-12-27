import 'package:cloud_firestore/cloud_firestore.dart';
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
  List<DocumentSnapshot> names;

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
              StreamBuilder(
                stream: Get.find<NameSettingsController>().names,
                builder: (context, AsyncSnapshot snapshot){
                  if(snapshot.hasError){
                    return Center(
                      child: Text('An error occurred, please try again later'),
                    );
                  }
                  if(snapshot.hasData){
                    names = snapshot.data.documents;

                    return Expanded(
                      child: ListView.builder(
                        itemCount: names.length,
                        itemBuilder: (context, int index){
                          return Dismissible(
                            direction: DismissDirection.endToStart,
                            background: Icon(Icons.zoom_out_rounded),
                            secondaryBackground: slideLeftBackground(),
                            onDismissed: (dismissDirection){
                              Get.find<NameSettingsController>().deleteName(index);
                            },
                            key: Key('$index'),
                            child: ListTile(
                              title: Text(names[index]['name_en']),
                              subtitle: Text(names[index]['meaning']),
                              trailing: Icon(Icons.arrow_forward_ios_rounded, size: SizeConfig.blockSizeHorizontal * 5,),
                              onTap: (){
                                Get.find<NameSettingsController>().name = names[index].data();
                                Navigator.of(context).push(MaterialPageRoute(builder: (context) => NameEdit(name: names[index],)));
                              },
                            ),
                          );
                        },
                      ),
                    );
                  }
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                },
              )
            ],
          ),
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            backgroundColor: Colors.teal,
            autofocus: true,
            onPressed: (){
              // Get.find<NameSettingsController>().name = {'origin' : 'Arabic'};
              //   'name_en': '',
              //   'name_ar': '',
              //   'name_dh': '',
              //   'meaning': '',
              //   'gender':'Male',
              //   'origin': 'Arabic'
              // });
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddName()));
            },
          ),
        ));
  }
}
