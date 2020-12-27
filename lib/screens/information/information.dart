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
            body: Obx((){
              return Padding(
                padding: EdgeInsets.only(top: SizeConfig.blockSizeVertical * 3),
                child: ListView.builder(
                  itemCount: Get.find<InformationController>().information.length,
                  itemBuilder: (context, int index){
                    return ListTile(
                      leading: Icon(Icons.info_outline_rounded),
                      title: Text(Get.find<InformationController>().information[index]['question'], overflow: TextOverflow.ellipsis, maxLines: 1,),
                      subtitle: Text(Get.find<InformationController>().information[index]['answer'], overflow: TextOverflow.ellipsis, maxLines: 1,),
                      onTap: (){
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => InformationDetails(
                          information: Get.find<InformationController>().information[index]
                        )));
                      },
                    );
                  },
                ),
              );
            })
      )),
    );
  }
}
