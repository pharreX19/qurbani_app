import 'package:flutter/material.dart';
import 'package:qurbani/config/size_config.dart';
import 'package:qurbani/screens/names/search_delegate.dart';

class Names extends StatefulWidget {
  final String tag;
  final String imagepath;

  Names({this.tag, this.imagepath});
  @override
  _NamesState createState() => _NamesState();
}

class _NamesState extends State<Names> {
  IconData searchCloseIcon = Icons.search;
  final List<String> searchList = List.generate(20, (index) => 'index $index');

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled){
            return <Widget>[
              SliverAppBar(
                actions: [
                  Padding(
                    padding: EdgeInsets.only(right: SizeConfig.blockSizeHorizontal * 3),
                    child: IconButton(icon: Icon(searchCloseIcon), onPressed: (){
                        showSearch(context: context, delegate: Search(searchSuggestions: searchList));
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
                    Tab(icon: Icon(Icons.sports_baseball_rounded,))
                  ],
                ),
              ),
            ];
          },
          body: TabBarView(
            children: [
              ListView.builder(itemCount: 30, itemBuilder: (context, int index){
                return Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: SizeConfig.blockSizeHorizontal * 10,
                      // right: SizeConfig.blockSizeHorizontal * 10,
                      // bottom: SizeConfig.blockSizeHorizontal * 2,
                      // top: SizeConfig.blockSizeHorizontal * 2

                  ),
                  child: Column(
                    children: [
                      index == 0 ? Container() : Divider(height: SizeConfig.blockSizeVertical * 4,),
                      Row(
                        children: [
                          Text('Azha'),
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
                        ],
                      ),
                    ],
                  )
                );
              },),
              ListView.builder(itemCount: 30, itemBuilder: (context, int index){
                return Row(
                  children: [
                    Text('Azha'),
                    Column(
                      children: [
                        Text('Gender: Female'),
                        Text('Origin: Greek')
                      ],
                    )
                  ],
                );
              },)
            ],
          ),
        ),
      ),
    );
  }
}
