import 'package:flutter/material.dart';
import 'package:qurbani/config/size_config.dart';
import 'package:qurbani/screens/service_settings/service_settings.dart';
import 'package:qurbani/widgets/common/main_layout.dart';

class Settings extends StatelessWidget {

  final List<Map<String, dynamic>> _services = [
    {'title' : 'Udhiya', 'price': 'MVR 700', 'icon' : Icons.waterfall_chart },
    {'title' : 'Aqeeqah', 'price': 'MVR 1000', 'icon' : Icons.anchor_sharp },
    {'title' : 'Sadaqat', 'price': 'MVR 1500','icon' : Icons.anchor_sharp },
    {'title' : 'Others', 'price': 'MVR 1700', 'icon' : Icons.adjust_sharp }
  ];

  Widget _buildCategory(BuildContext context, String title){
    return Padding(
      padding: EdgeInsets.only(top: SizeConfig.blockSizeVertical * 3),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
//          Padding(
//            padding: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal * 3, bottom: SizeConfig.blockSizeVertical * 0.8),
//            child: Text(title),
//          ),
          ListTile(
            tileColor: Colors.grey[100],
            title: Text(title),
            trailing: Icon(Icons.arrow_forward_ios_rounded, size: SizeConfig.blockSizeHorizontal * 5,),
            onTap: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => ServiceSettings(title: title,)));
            },
          )
        ],
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: MainLayout(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Settings'),
                SizedBox(
                  height: SizeConfig.blockSizeVertical * 3,
                ),
//                Padding(
//                  padding: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal * 3, bottom: SizeConfig.blockSizeVertical * 0.8),
//                  child: Text('Services'),
//                ),
                ..._services.map((service){
                  return ListTile(
                    tileColor: Colors.grey[100],
                    title: Text(service['title']),
                    trailing: Icon(Icons.arrow_forward_ios_rounded, size: SizeConfig.blockSizeHorizontal * 5,),
                    onTap: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => ServiceSettings(title: service['title'],)));
                    },
                  );
                }),
                _buildCategory(context, 'Name List'),
                _buildCategory(context, 'Questions')

              ])
        ),
      ),
    );
  }
}
