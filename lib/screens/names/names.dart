import 'package:flutter/material.dart';
import 'package:qurbani/config/size_config.dart';

class Names extends StatefulWidget {
  final String tag;
  final String imagepath;

  Names({this.tag, this.imagepath});
  @override
  _NamesState createState() => _NamesState();
}

class _NamesState extends State<Names> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled){
          return <Widget>[
            SliverAppBar(
              expandedHeight: SizeConfig.blockSizeVertical * 30,
              floating: true,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                title: Text('Baby Name'),
                background: Hero(tag: widget.tag, child: Image.asset(widget.imagepath, fit: BoxFit.cover,)),
              ),
            ),
          ];
        },
        body: Text('Text'),
      ),
    );
  }
}
