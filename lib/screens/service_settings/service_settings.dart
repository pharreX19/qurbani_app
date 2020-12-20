import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qurbani/config/size_config.dart';
import 'package:qurbani/controllers/service_settings_controller.dart';
import 'package:qurbani/screens/settings/settings.dart';
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
  // bool _isServiceActivated = true;
  final List<String> _services = [
    'Cow', 'Camel', 'Sheep', 'Goat', 'Others', '+'
  ];
  // final TextEditingController serviceTypeController = TextEditingController();
  final TextEditingController servicePriceController = TextEditingController();

  int _selectedIndex = 0;
  String _submitButtonText = 'Update Service';
  IconData _submitButtonIcon = Icons.check;

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
             Obx((){
               print(Get.find<ServiceSettingsController>().selectedServiceType);
               return  CustomTextField(
                 // controller: Get.find<ServiceSettingsController>().serviceTypeController,
                 hintText: Get.find<ServiceSettingsController>().selectedServiceType['name'],//_services[_selectedIndex] == '+' ? '' : _services[_selectedIndex],
                 enabled: false,
                 onChanged: Get.find<ServiceSettingsController>().onServiceTypeChanged,
               );
             }),
              SizedBox(
                height: SizeConfig.blockSizeVertical * 2,
              ),
              Obx((){
                return CustomTextField(
                  controller: servicePriceController,
                  // controller: Get.find<ServiceSettingsController>().servicePriceController,
                  enabled: true,
                  hintText: Get.find<ServiceSettingsController>().selectedServiceType.value['price'].toString(),
                  onChanged: Get.find<ServiceSettingsController>().onServicePriceChanged,

                  // leading: Padding(
                  //   padding: EdgeInsets.only(
                  //       right: SizeConfig.blockSizeHorizontal * 2),
                  //   child: Text('MVR'),
                  // ),
                );
              }),
              SizedBox(
                height: SizeConfig.blockSizeVertical * 2,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Service Status'),
                 Obx((){
                   return  Switch(activeColor: Colors.teal,
                       value: Get.find<ServiceSettingsController>().selectedServiceType.value['isActive'],
                       onChanged: (value) {
                         // setState(() {
                           Get.find<ServiceSettingsController>().updateSelectedService('isActive', value);
                         // _isServiceActivated = value;
                         // });
                       });
                 })
                ],
              ),
            ],
          )
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
              ...Get.find<ServiceSettingsController>().serviceTypes.map((service){
                return InkWell(
                  onTap: (){
                    // setState(() {
                    //   _selectedIndex = _services.indexOf(service);
                    servicePriceController.clear();
                    Get.find<ServiceSettingsController>().selectedServiceType.assignAll(service);
                      // if(_services[_selectedIndex] == '+'){
                      //   // _isServiceActivated = false;
                      //   _submitButtonText = 'Create Service';
                      //   _submitButtonIcon = Icons.save;
                      // }else{
                      //   _submitButtonText = 'Update Service';
                      //   _submitButtonIcon = Icons.check;
                      // }
                    // });
                  },
                  child: Obx((){
                    return Container(
                        height: SizeConfig.blockSizeVertical * 5,
                        decoration: BoxDecoration(
                            color: service ==  Get.find<ServiceSettingsController>().selectedServiceType.value ? Colors.teal.shade50 : Colors.transparent,
                            border: Border.all(color: Colors.teal.shade100),
                            borderRadius: BorderRadius.circular(10.0)
                        ),
                        width: SizeConfig.blockSizeVertical * 10,
                        margin: EdgeInsets.symmetric(horizontal: SizeConfig.blockSizeHorizontal * 1, vertical: SizeConfig.blockSizeVertical * 1),
                        child: Center(child: Text(service['name'])));
                  })
                );
              })
            ],
          )
        ],
      ),
    );
  }

  _submitCallback(){
    Get.find<ServiceSettingsController>().updateService();
    servicePriceController.clear();
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
            Text(Get.find<ServiceSettingsController>().service.value),
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
              child: SubmitButton(
                title: _submitButtonText,
                icon: _submitButtonIcon,
                submitCallback: _submitCallback
                ,
              ),
            ),
            _buildServiceTypes(),
          ],
        ),
      ),
    ));
  }
}
