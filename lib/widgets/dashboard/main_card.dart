import 'package:flutter/material.dart';
import 'package:qurbani/config/size_config.dart';
import 'package:qurbani/controllers/dashboard_controller.dart';

class MainCard extends StatelessWidget {

  final String title;
  final String imagePath;
  final Widget detailsPage;
  MainCard({this.title, this.imagePath, this.detailsPage});

  void _navigateToDetailsPage(BuildContext context){
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => detailsPage));
  }

  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap: (){
        _navigateToDetailsPage(context);
      },
      child: Stack(
        children: [
          Container(
            margin: EdgeInsets.symmetric(
                horizontal: SizeConfig.blockSizeHorizontal * 2
            ),
            width: SizeConfig.blockSizeHorizontal * 93,
//            height: SizeConfig.blockSizeHorizontal * 42,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
            ),
          ),
          Hero(
            tag: title,
            child: Container(
              width: SizeConfig.blockSizeHorizontal * 100,
//              height: SizeConfig.blockSizeHorizontal * 43,
              padding: EdgeInsets.symmetric(vertical : SizeConfig.blockSizeHorizontal * 12.5),
              decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage(imagePath), fit: BoxFit.cover),
                color: Colors.red,
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
              ),
              child: Column(
                children: [
                  // Center(child: Text(title))
                ]
              ),
            ),
          ),
          Container(
            width: SizeConfig.blockSizeHorizontal * 100,
//            height: SizeConfig.blockSizeHorizontal * 43,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [
                    Colors.transparent,
                    Colors.black.withOpacity(0.8),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter
              ),
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
            ),
          )
        ],
      ),
    );
  }
}
