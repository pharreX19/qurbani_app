import 'package:flutter/material.dart';
import 'package:qurbani/config/size_config.dart';
import 'package:qurbani/widgets/common/custom_text_field.dart';
import 'package:qurbani/widgets/common/main_layout.dart';
import 'package:qurbani/widgets/common/submit_button.dart';

class ServiceSettings extends StatefulWidget {
  final String title;
  ServiceSettings({this.title});

  @override
  _ServiceSettingsState createState() => _ServiceSettingsState();
}

class _ServiceSettingsState extends State<ServiceSettings> {
  bool _isServiceActivated = true;
  final List<String> _services = [
    'Cow', 'Camel', 'Sheep', 'Goat', 'Others', '+'
  ];

  int _selectedIndex = 0;
  String _submitButtonText = 'Update Service';

  Widget _buildServiceUpdateForm(){
    return Card(
      child: Padding(
        padding: EdgeInsets.only(
            left: SizeConfig.blockSizeHorizontal * 6,
            right: SizeConfig.blockSizeHorizontal * 6,
            top: SizeConfig.blockSizeHorizontal * 8,
            bottom: SizeConfig.blockSizeHorizontal * 4
        ),
        child: Column(
          children: [
            CustomTextField(
              hintText: _services[_selectedIndex] == '+' ? '' : _services[_selectedIndex],
              enabled: true,

            ),
            SizedBox(
              height: SizeConfig.blockSizeVertical * 2,
            ),
            CustomTextField(
              enabled: true,
              hintText: '1700',
              leading: Padding(
                padding: EdgeInsets.only(
                    right: SizeConfig.blockSizeHorizontal * 2),
                child: Text('MVR'),
              ),
            ),
            SizedBox(
              height: SizeConfig.blockSizeVertical * 2,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Service Status'),
                Switch(activeColor: Colors.teal, value: _isServiceActivated, onChanged: (value) {
                  setState(() {
                    _isServiceActivated = value;
                  });
                }),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildServiceTypes(){
    return  Padding(
      padding: EdgeInsets.only(top: SizeConfig.blockSizeVertical * 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Service Types'),
          SizedBox(height: SizeConfig.blockSizeVertical * 2,),
          Wrap(
            children: [
              ..._services.map((service){
                return InkWell(
                  onTap: (){
                    setState(() {
                      _selectedIndex = _services.indexOf(service);
                      if(_services[_selectedIndex] == '+'){
                        _isServiceActivated = false;
                        _submitButtonText = 'Create Service';
                      }
                    });
                  },
                  child: Container(
                      height: SizeConfig.blockSizeVertical * 5,
                      decoration: BoxDecoration(
                          color: service == _services[_selectedIndex] ? Colors.teal.shade50 : Colors.transparent,
                          border: Border.all(color: Colors.teal.shade100),
                          borderRadius: BorderRadius.circular(10.0)
                      ),
                      width: SizeConfig.blockSizeVertical * 10,
                      margin: EdgeInsets.symmetric(horizontal: SizeConfig.blockSizeHorizontal * 1, vertical: SizeConfig.blockSizeVertical * 1),
                      child: Center(child: Text(service))),
                );
              })
            ],
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
      body: MainLayout(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.title),
            SizedBox(
              height: SizeConfig.blockSizeVertical * 3,
            ),
            _buildServiceUpdateForm(),
            Padding(
              padding: EdgeInsets.only(
                  left: SizeConfig.blockSizeHorizontal * 1,
                  right: SizeConfig.blockSizeHorizontal * 1,
                  top: SizeConfig.blockSizeHorizontal * 3
              ),
              child: SubmitButton(title: _submitButtonText, icon: Icons.check,),
            ),
            _buildServiceTypes(),
          ],
        ),
      ),
    ));
  }
}
