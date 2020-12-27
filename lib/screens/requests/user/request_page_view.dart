import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qurbani/config/size_config.dart';
import 'package:qurbani/controllers/requests_controller.dart';

class RequestPageView extends StatelessWidget {
  final DocumentSnapshot document;

  RequestPageView({this.document});

  Widget _buildNameTag({String title, IconData icon}){
    return Row(
      children: [
        Icon(icon, color: Colors.white,),
        SizedBox(width: SizeConfig.blockSizeHorizontal * 1,),
        Text(title, style: TextStyle(color: Colors.white),)
      ],
    );
  }

  Widget _buildContentFooter(){
    return Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          _buildNameTag(title: document['user']['name'], icon: Icons.person),
          Padding(
            padding: EdgeInsets.symmetric(vertical: SizeConfig.blockSizeVertical * 0.7),
            child: Row(
              children: [
                _buildNameTag(title: document['service']['name'],
                    icon: Icons.miscellaneous_services),
                Text(' - ${document['service']['type']} -', style: TextStyle(color: Colors.white),)
              ],
            )
          ),
          Row(
            children: [
              _buildNameTag(title: '${DateTime.fromMillisecondsSinceEpoch(
                  document['date'].seconds * 1000)}', icon: Icons.today),
              Spacer(),
              Text(
                document['status'].toString().toUpperCase(),
                style: TextStyle(color: document['status'].toString().toLowerCase() == 'rejected' ?
                Colors.red : Colors.white),)
            ],
          )
        ]
    );
  }

  Widget _buildBackgroundImageContent(BuildContext context){
    return Column(
        children: [
          document['status'].toString().toLowerCase() == 'pending' ?
          InkWell(
            onTap: (){
              Get.find<RequestsController>().updateRequestStatus(context, document.id, 'Cancelled');
            },
            child: Align(
                alignment: Alignment.centerRight,
                child: Icon(Icons.cancel_outlined, color: Colors.white,)),
          ) :
          Container(),
          document['status'].toString().toLowerCase() == 'rejected' ?
          Expanded(child: Center(
            child: Text(document['rejected_reason'], style: TextStyle(color: Colors.red),),)) :
          document['status'].toString().toLowerCase() == 'cancelled' ?
          Expanded(
            child: Center(
              child: Icon(Icons.cancel_outlined, size: SizeConfig.blockSizeHorizontal * 20, color: Colors.red,),
            ),
          ) :
          Spacer(),
          _buildContentFooter(),
        ],
    );
  }

  Widget _buildBackgroundImageOverlay(BuildContext context){
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
              document['status'].toString().toLowerCase() == 'rejected' ||
                  document['status'].toString().toLowerCase() == 'cancelled' ?
                  Colors.black.withOpacity(0.8) :Colors.transparent,
              Colors.black.withOpacity(0.8),
            ]
        ),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Padding(
        padding: EdgeInsets.all(
            SizeConfig.blockSizeHorizontal * 4,
        ),
        child: _buildBackgroundImageContent(context)
        ),
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
        _buildBackgroundImageOverlay(context),
      ],
    );
  }
}
