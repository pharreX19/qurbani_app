import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qurbani/config/size_config.dart';
import 'package:qurbani/controllers/information_controller.dart';
import 'package:qurbani/screens/information/information_details.dart';
import 'package:qurbani/widgets/common/main_layout.dart';

class Information extends StatelessWidget {
  final InformationController _informationController = Get.put(InformationController());
  final String tag;
  final String imagePath;
  Information({this.tag, this.imagePath});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              expandedHeight: SizeConfig.blockSizeVertical * 30,
              floating: true,
              forceElevated: true,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                title: Text('Information'),
                background: Hero(
                    tag: tag,
                    child: Image.asset(
                      imagePath,
                      fit: BoxFit.cover,
                    )),
              ),
            ),
          ];
        },
            body: StreamBuilder(
              stream: Get.find<InformationController>().information,
              builder: (context, AsyncSnapshot snapshot){
                if(snapshot.hasError){
                  return Center(
                    child: Text('An error occurred, please try again later'),
                  );
                }
                if(snapshot.hasData){
                  List<DocumentSnapshot> informationList = snapshot.data.documents;
                  return Padding(
                    padding: EdgeInsets.only(top: SizeConfig.blockSizeVertical * 3),
                    child: ListView.builder(
                      itemCount: informationList.length,
                      itemBuilder: (context, int index){
                        return ListTile(
                          leading: Icon(Icons.info_outline_rounded),
                          title: Text(informationList[index]['question'], overflow: TextOverflow.ellipsis, maxLines: 1,),
                          subtitle: Text(informationList[index]['answer'], overflow: TextOverflow.ellipsis, maxLines: 1,),
                          onTap: (){
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => InformationDetails(
                                document: informationList[index]
                            )));
                          },
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
      )),
    );
  }
}
