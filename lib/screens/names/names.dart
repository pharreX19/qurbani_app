import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qurbani/config/size_config.dart';
import 'package:qurbani/controllers/names_controller.dart';
import 'package:qurbani/screens/names/search_delegate.dart';

class Names extends StatefulWidget {
  final String tag;
  final String imagepath;
  final NamesController _namesController = Get.put(NamesController());

  Names({this.tag, this.imagepath});
  @override
  _NamesState createState() => _NamesState();
}

void _viewNameDetails(BuildContext context, Map<String, dynamic> name){
  showModalBottomSheet(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(10.0), topRight: Radius.circular(10.0))),
      context: context, builder: (context){
    return Container(
      padding: EdgeInsets.all(SizeConfig.blockSizeHorizontal * 5),
      height: SizeConfig.blockSizeVertical * 25,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(name['name']),
          SizedBox(height: SizeConfig.blockSizeVertical * 1,),
          Text('Name in arabic'),
          SizedBox(height: SizeConfig.blockSizeVertical * 1,),
          Text('Name in dhivehi'),
          SizedBox(height: SizeConfig.blockSizeVertical * 2.5,),
          Align(
            alignment: Alignment.centerLeft,
              child: Text(name['meaning']))
        ],
      ),
    );
  });
}

class _NamesState extends State<Names> {
  IconData searchCloseIcon = Icons.search;
  final List<String> searchList = List.generate(20, (index) => 'index $index');

  Widget _generateNameListWidget(int index,  [bool isFavoriteIconEnabled = true]){
    return InkWell(
      onTap: (){
        _viewNameDetails(context, Get.find<NamesController>().nameList[index]);
      },
      child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: SizeConfig.blockSizeHorizontal * 10,
            // right: SizeConfig.blockSizeHorizontal * 10,
            // bottom: SizeConfig.blockSizeHorizontal * 2,
            // top: SizeConfig.blockSizeHorizontal * 2

          ),
          child: Column(
            children: [
              Row(
                children: [
                  Text(Get.find<NamesController>().nameList[index]['name']),
                  Spacer(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.location_on_outlined, size: SizeConfig.blockSizeHorizontal * 5,),
                          Padding(
                            padding: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal * 1),
                            child: Text('Greek'),
                          )
                        ],
                      ),
                      SizedBox(height: SizeConfig.blockSizeVertical * 0.5,),
                      Row(
                        children: [
                          Icon(Icons.perm_identity, size: SizeConfig.blockSizeHorizontal * 5,),
                          Padding(
                            padding: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal * 1),
                            child: Text('Female'),
                          )
                        ],
                      )
                    ],
                  ),
                  isFavoriteIconEnabled ?  SizedBox(width: SizeConfig.blockSizeHorizontal* 8,) : Container(),
                  isFavoriteIconEnabled ? IconButton(icon: Icon(Get.find<NamesController>().nameList[index]['is_favorited'] ?
                  Icons.favorite : Icons.favorite_border, color: Colors.red[700],),
                      onPressed: (){
                        Get.find<NamesController>().toggleFavoriteName(index);
                      }) : Container(),
                ],
              ),
              Divider(height: SizeConfig.blockSizeVertical * 4, color: Colors.teal,),
            ],
          )
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled){
            return <Widget>[
              SliverAppBar(
                actions: [
                  Padding(
                    padding: EdgeInsets.only(right: SizeConfig.blockSizeHorizontal * 3),
                    child: IconButton(icon: Icon(searchCloseIcon), onPressed: (){
                        showSearch(context: context, delegate: Search(searchSuggestions: Get.find<NamesController>().nameList));
                    },),
                  ),
                ],
                expandedHeight: SizeConfig.blockSizeVertical * 30,
                floating: true,
                forceElevated: true,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  title: Text('Baby Name'),
                  background: Hero(tag: widget.tag, child: Image.asset(widget.imagepath, fit: BoxFit.cover,)),
                ),
                bottom: TabBar(
                  tabs: [
                    Tab(icon: Icon(Icons.sports_baseball_rounded,)),
                    Tab(icon: Icon(Icons.sports_baseball_rounded,)),
                    Tab(icon: Icon(Icons.favorite,))
                  ],
                ),
              ),
            ];
          },
          body: TabBarView(
            children: [
              Obx((){
                return ListView.builder(itemCount: Get.find<NamesController>().nameList.length, itemBuilder: (context, int index){
                  if(Get.find<NamesController>().nameList[index]['gender'] == 'female'){
                    return Container();
                  }
                    return _generateNameListWidget(index);
                },);
              }),
              Obx((){
                return ListView.builder(itemCount: Get.find<NamesController>().nameList.length, itemBuilder: (context, int index){
                  if(Get.find<NamesController>().nameList[index]['gender'] == 'male'){
                    return Container();
                  }
                  return _generateNameListWidget(index);
                },);
              }),
              Obx((){
                return ListView.builder(itemCount: Get.find<NamesController>().nameList.length, itemBuilder: (context, int index){
                  if(!Get.find<NamesController>().nameList[index]['is_favorited']){
                    return Container();
                  }
                  return _generateNameListWidget(index, false);
                },);
              }),
            ],
          ),
        ),
      ),
    );
  }
}
