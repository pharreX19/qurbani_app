import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:qurbani/config/size_config.dart';
import 'package:qurbani/controllers/service_settings_controller.dart';
import 'package:qurbani/controllers/service_type_settings_controller.dart';
import 'package:qurbani/providers/service_type_validation_provider.dart';
import 'package:qurbani/widgets/common/custom_text_field.dart';
import 'package:qurbani/widgets/common/main_layout.dart';
import 'package:qurbani/widgets/common/submit_button.dart';

class ServiceSettings extends StatefulWidget {
  final QueryDocumentSnapshot service;
  final String serviceName;

  ServiceSettings({this.service, this.serviceName});

  @override
  _ServiceSettingsState createState() => _ServiceSettingsState();
}

class _ServiceSettingsState extends State<ServiceSettings> {
  List<DocumentSnapshot> serviceTypes;
//  RxMap<dynamic, dynamic> selectedServiceType = {}.obs;
  String _submitButtonText = 'Update Service';
  IconData _submitButtonIcon = Icons.check;
  String serviceTypeId;
  bool serviceTypeIsActive;
  final   TextEditingController servicePriceController = TextEditingController(text: '0.0');
  String serviceTypeName = 'Service Type';
  ServiceTypeValidationProvider _validationService;

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
                 hintText: _validationService.serviceTypeName.value ?? 'Service Type',//serviceTypeName,//_services[_selectedIndex] == '+' ? '' : _services[_selectedIndex],
                 enabled: false,
               ),
              SizedBox(
                height: SizeConfig.blockSizeVertical * 2,
              ),
              CustomTextField(
                  // controller: servicePriceController,
                  enabled: true,
                  hintText: _validationService.serviceTypePrice.value == null  ? '0.0' : _validationService.serviceTypePrice.value.toString(),//Get.find<ServiceTypeSettingsController>().selectedServiceTypePrice.value.toString(),
                  errorText: _validationService.serviceTypePrice.error,//Get.find<ServiceTypeSettingsController>().serviceTypePriceFieldError.value,
                  onChanged: (String price){
                    _validationService.onChangeServiceTypePrice(price);
                  }  //Get.find<ServiceTypeSettingsController>().onServicePriceChanged,
                ),
              SizedBox(
                height: SizeConfig.blockSizeVertical * 2,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Service Status'),
                  Switch(activeColor: Colors.teal,
                       value: _validationService.serviceTypeStatus.value, //serviceTypeIsActive ?? false,//Get.find<ServiceTypeSettingsController>().selectedServiceTypeIsActive.value ?? serviceTypes[0]['is_active'],
                       onChanged: (value) {
                            _validationService.onChangeServiceTypStatus(value);
                          // setState(() {
                          //   serviceTypeIsActive = value;
                          // });
//                           Get.find<ServiceTypeSettingsController>().selectedServiceTypeIsActive.value = value;
                         // });
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
              ...serviceTypes.map((serviceType){
                return InkWell(
                    onTap: (){
//                      Get.find<ServiceTypeSettingsController>().selectedServiceTypeName.value = serviceType['type'];
//                       Get.find<ServiceTypeSettingsController>().selectedServiceTypePrice.value =  serviceType['price'] * 1.0;
//                      Get.find<ServiceTypeSettingsController>().selectedServiceTypeId.value = serviceType.id;
//                      Get.find<ServiceTypeSettingsController>().selectedServiceTypeIsActive.value = serviceType['is_active'];
//                       setState(() {
//                         serviceTypeId = serviceType.id;
//                         serviceTypeIsActive = serviceType['is_active'];
//                         servicePriceController.text =  serviceType['price'].toString();
//                         serviceTypeName = serviceType['type'];
//                       });
                      _validationService.onChangeServiceTypeId(serviceType.id);
                      _validationService.onChangeServiceTypStatus(serviceType['is_active']);
                      _validationService.onChangeServiceTypePrice(serviceType['price'].toString());
                      _validationService.onChangeServiceTypeName(serviceType['type']);
                      // Get.find<ServiceSettingsController>().selectedServiceType.assignAll({
                      //   'id':serviceType.id,
                      //   ...serviceType.data()
                      // });
//                      Get.find<ServiceSettingsController>().selectedServiceTypeIndex.value = serviceTypes.indexOf(serviceType);
                    },
                    child: Container(
                          height: SizeConfig.blockSizeVertical * 5,
                          decoration: BoxDecoration(
                              color: serviceType.id == _validationService.serviceTypeId.value /*serviceTypeId*/ ? Colors.teal.shade50 : Colors.transparent,
                              border: Border.all(color: Colors.teal.shade100),
                              borderRadius: BorderRadius.circular(10.0)
                          ),
                          width: SizeConfig.blockSizeVertical * 10,
                          margin: EdgeInsets.symmetric(horizontal: SizeConfig.blockSizeHorizontal * 1, vertical: SizeConfig.blockSizeVertical * 1),
                          child: Center(child: Text(serviceType['type'].toString().toLowerCase())))
                );
              })
            ],
          )
        ],
      ),
    );
  }

  _submitCallback(){
    Get.find<ServiceTypeSettingsController>().updateServiceType(
        {
          'id': _validationService.serviceTypeId.value,
          'is_active':  _validationService.serviceTypeStatus.value,
          'price': _validationService.serviceTypePrice.value.toString()
        }, context);
  }

  @override
  void dispose() {
    super.dispose();
    servicePriceController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ServiceTypeSettingsController serviceTypeSettingsController = Get.put(ServiceTypeSettingsController());
    Get.find<ServiceTypeSettingsController>().serviceName = widget.serviceName;
    Get.find<ServiceTypeSettingsController>().documentSnapshot = widget.service;
    _validationService = Provider.of<ServiceTypeValidationProvider>(context);
    return SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
      body: MainLayout(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.serviceName),

            // Text(widget.service['name']),
            SizedBox(
              height: SizeConfig.blockSizeVertical * 3,
            ),
            StreamBuilder(
              stream: serviceTypeSettingsController.serviceTypes,
              builder: (context, AsyncSnapshot snapshot){
                if(snapshot.hasError){
                  return Center(
                    child: Text('An error occurred, please try again'),
                  );
                }
                if(snapshot.hasData){
                  serviceTypes = snapshot.data.documents;
                  return Column(
                    children: [
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
                          submitCallback: (!_validationService.isValid) ? null : _submitCallback
                          ,
                        ),
                      ),
                      _buildServiceTypes(),
                    ],
                  );
                }
                return Center(
                    child: CircularProgressIndicator()
                  );
              },
            )
            // StreamBuilder(
            //   stream: widget.service.reference.collection(widget.serviceName).snapshots(),
            //   builder: (context, AsyncSnapshot snapshot){
            //     if(snapshot.hasError){
            //       return Center(
            //         child: Text('Something went wrong, please try again later'),
            //       );
            //     }
            //     if(snapshot.hasData){
            //       serviceTypes = snapshot.data.documents;
            //       Get.find<ServiceSettingsController>().selectedServiceType.assignAll({
            //         'id': serviceTypes[0].id,
            //         ...serviceTypes[0].data()
            //       });
            //       return Column(
            //         children: [
            //           _buildServiceUpdateForm(),
            //           Padding(
            //             padding: EdgeInsets.only(
            //                 left: SizeConfig.blockSizeHorizontal * 1,
            //                 right: SizeConfig.blockSizeHorizontal * 1,
            //                 top: SizeConfig.blockSizeHorizontal * 3
            //             ),
            //             child: SubmitButton(
            //               title: _submitButtonText,
            //               icon: _submitButtonIcon,
            //               submitCallback: _submitCallback
            //               ,
            //             ),
            //           ),
            //           _buildServiceTypes(),
            //         ],
            //       );
            //     }
            //     return Center(child: CircularProgressIndicator());
            //   },
            // )
          ],
        ),
      ),
    ));
  }
}
