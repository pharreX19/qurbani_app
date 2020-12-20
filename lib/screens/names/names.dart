import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qurbani/config/size_config.dart';
import 'package:qurbani/controllers/names_controller.dart';
import 'package:qurbani/screens/names/name_details_bottom_sheet.dart';
import 'package:qurbani/screens/names/name_search_delegate.dart';

class Names extends StatefulWidget {
  final String tag;
  final String imagePath;
  final NamesController _namesController = Get.put(NamesController());
  final Function continueWithAqeeqahCallback;

  Names({this.tag, this.imagePath, this.continueWithAqeeqahCallback});
  @override
  _NamesState createState() => _NamesState();
}

void _viewNameDetails(BuildContext context, Map<String, dynamic> name){
  showModalBottomSheet(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(10.0), topRight: Radius.circular(10.0))),
      context: context, builder: (context){
    return NameDetailsBottomSheet(name: name['name'], meaning: name['meaning'],);
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
                        showSearch(context: context, delegate: NameSearchDelegate(searchSuggestions: Get.find<NamesController>().nameList));
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
                  background: Hero(tag: widget.tag, child: Image.asset(widget.imagePath, fit: BoxFit.cover,)),
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
