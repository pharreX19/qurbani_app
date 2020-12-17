import 'package:flutter/material.dart';
import 'package:qurbani/config/size_config.dart';

class RequestPageView extends StatelessWidget {
  final Map<String, dynamic> requestedServiceInfo = {
    'date' : '20 Decemeber 2020',
    'status' : 'Pending',
    'name' : 'Ahmed Ali',
    'type' : 'Aqeeqah'
  } ;

  Widget _buildNameTag({String title, IconData icon}){
    return Row(
      children: [
        Icon(icon, color: Colors.white,),
        SizedBox(width: SizeConfig.blockSizeHorizontal * 1,),
        Text(title, style: TextStyle(color: Colors.white),)
      ],
    );
  }

  Widget _buildBackgroundImageContent(){
    return Padding(
        padding: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal * 4, bottom: SizeConfig.blockSizeHorizontal * 3),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              _buildNameTag(title: requestedServiceInfo['name'], icon: Icons.person),
              Padding(
                padding: EdgeInsets.symmetric(vertical: SizeConfig.blockSizeVertical * 0.7),
                child: _buildNameTag(title: requestedServiceInfo['type'], icon: Icons.miscellaneous_services),
              ),
              Row(
                children: [
                  _buildNameTag(title: requestedServiceInfo['date'], icon: Icons.today),
                  Spacer(),
                  Padding(
                    padding: EdgeInsets.only(right: SizeConfig.blockSizeHorizontal * 4),
                    child: Text(requestedServiceInfo['status'].toString().toUpperCase(), style: TextStyle(color: Colors.white),),
                  )
                ],
              )
            ]
        )
    );
  }

  Widget _buildBackgroundImageOverlay(){
    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: SizeConfig.blockSizeHorizontal * 1,
          vertical: SizeConfig.blockSizeVertical * 2),
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.3, 1.0],
            colors: [
              Colors.transparent,
              Colors.black.withOpacity(0.8),
            ]
        ),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: _buildBackgroundImageContent()
    );
  }

  Widget _buildBackgroundImage(){
    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: SizeConfig.blockSizeHorizontal * 1,
          vertical: SizeConfig.blockSizeVertical * 2),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0), color: Colors.teal),
      child: AspectRatio(
          aspectRatio: 1,
          child: ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Image.asset(
                'assets/images/information.jpg',
                fit: BoxFit.cover,
              ))),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        _buildBackgroundImage(),
        _buildBackgroundImageOverlay(),
      ],
    );
  }
}
