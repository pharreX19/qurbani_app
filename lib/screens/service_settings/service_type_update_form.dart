import 'package:flutter/material.dart';
import 'package:qurbani/config/size_config.dart';
import 'package:qurbani/providers/service_type_validation_provider.dart';
import 'package:qurbani/widgets/common/custom_text_field.dart';

class ServiceTypeUpdateForm extends StatelessWidget {
  final ServiceTypeValidationProvider validationService;
  
  ServiceTypeUpdateForm({this.validationService});
  @override
  Widget build(BuildContext context) {
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
                controller: validationService.serviceTypeNameController,
                hintText: validationService.serviceTypeName.value ?? 'Service Type',//serviceTypeName,//_services[_selectedIndex] == '+' ? '' : _services[_selectedIndex],
                enabled: false,
              ),
              SizedBox(
                height: SizeConfig.blockSizeVertical * 2,
              ),
              CustomTextField(
                  controller: validationService.serviceTypePriceController, //servicePriceController,
                  enabled: true,
                  hintText: validationService.serviceTypePrice.value == null  ? '0.0' : validationService.serviceTypePrice.value.toString(),//Get.find<ServiceTypeSettingsController>().selectedServiceTypePrice.value.toString(),
                  errorText: validationService.serviceTypePrice.error,//Get.find<ServiceTypeSettingsController>().serviceTypePriceFieldError.value,
                  onChanged: (String price){
                    validationService.onChangeServiceTypePrice(price);
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
                      value: validationService.serviceTypeStatus.value, //serviceTypeIsActive ?? false,//Get.find<ServiceTypeSettingsController>().selectedServiceTypeIsActive.value ?? serviceTypes[0]['is_active'],
                      onChanged: (value) {
                        validationService.onChangeServiceTypStatus(value);
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
}
