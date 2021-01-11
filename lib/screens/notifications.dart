import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qurbani/config/size_config.dart';
import 'package:qurbani/controllers/notification_controller.dart';
import 'package:qurbani/widgets/common/main_layout.dart';

class Notifications extends StatelessWidget {
  final NotificationController _controller = Get.put(NotificationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MainLayout(
        child: Column(
          children: [
            Text('Notifications'),
            SizedBox(height: SizeConfig.blockSizeVertical * 3,),
            StreamBuilder(
              stream: _controller.notifications(),
              builder: (context, AsyncSnapshot snapshot){
                if(snapshot.hasError){
                  return Center(
                    child: Text('An error occurred, please try again later'),
                  );
                }
                if(snapshot.hasData){
                  List<DocumentSnapshot> notifications = snapshot.data.documents;
                  return Expanded(
                    child: ListView.builder(
                      itemCount: 5,
                      itemBuilder: (context, int index){
                        return Text('Notification $index');
                      },
                    ),
                  );
                }
                return Expanded(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
