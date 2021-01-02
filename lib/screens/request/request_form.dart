import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:qurbani/config/size_config.dart';
import 'package:qurbani/controllers/dashboard_controller.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qurbani/providers/request_validation_provider.dart';
import 'package:qurbani/widgets/common/custom_text_field.dart';


class RequestForm extends StatefulWidget {

  @override
  _RequestFormState createState() => _RequestFormState();
}

class _RequestFormState extends State<RequestForm> {
  RequestValidationProvider _validationService;
  final List<int> quantityList = [1, 2];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if( Get.find<DashboardController>().childName != null){
        _validationService.onChangedName(Get.find<DashboardController>().childName);
      }
      if(Get.find<DashboardController>().contactNo != null){
        _validationService.onChangedContactNumber(Get.find<DashboardController>().contactNo);
      }
      if(Get.find<DashboardController>().serviceQuantity != null){
        _validationService.onChangedQuantity(Get.find<DashboardController>().serviceQuantity);
      }
    });
  }

  void _submitRequest(){
    Get.find<DashboardController>().submitRequestForm({
      'name': _validationService.name.value,
      'contact': _validationService.contactNo.value,
      'quantity': _validationService.quantity.value,
      'receipt': _validationService.receipt.value,
      'price': _validationService.quantity.value * _validationService.unitPrice.value,
    });
  }

  @override
  Widget build(BuildContext context) {
    _validationService = Provider.of(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: (){
            Navigator.pop(context);
            _validationService.resetValues();
            // Get.find<DashboardController>().clearErrors();
          },
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.teal),
      ),
      resizeToAvoidBottomPadding: false,
      body: Container(
        padding: EdgeInsets.only(
          top: SizeConfig.blockSizeVertical * 2,
          right: SizeConfig.blockSizeVertical * 2,
          left: SizeConfig.blockSizeVertical * 2,
        ),
        child: Column(
          children: [
            Text(Get.find<DashboardController>().serviceType),
            SizedBox(height: SizeConfig.blockSizeVertical * 2,),
            Text(Get.find<DashboardController>().serviceDate.toLocal().toString()),
            SizedBox(height: SizeConfig.blockSizeVertical * 3,),
            Card(
              margin: EdgeInsets.symmetric(horizontal: SizeConfig.blockSizeHorizontal * 0),
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: SizeConfig.blockSizeHorizontal * 6,
                    vertical: SizeConfig.blockSizeHorizontal * 8
                ),
                child: Column(
                  children: [
                    CustomTextField(
                        suffixIcon: Icons.person,
                        hintText: Get.find<DashboardController>().childName ??  'Child\'s Name',
                        onChanged: (String name){
                          _validationService.onChangedName(name);
                        }, //Get.find<DashboardController>().onChangedChildNameTextField,
                        errorText: _validationService.name.error, //Get.find<DashboardController>().childNameFieldError.value,
                      ),
                    SizedBox(height: SizeConfig.blockSizeVertical * 4,),
                     CustomTextField(
                        suffixIcon: Icons.person,
                        maxLength: 20,
                        hintText:  Get.find<DashboardController>().contactNo ??  'Contact Number',
                        onChanged: (String contactNo){
                          _validationService.onChangedContactNumber(contactNo);
                        },//Get.find<DashboardController>().onChangedContactNumberTextField,
                        errorText: _validationService.contactNo.error, //Get.find<DashboardController>().contactNumberFieldError.value,
                      )
                  ],
                ),
              ),
            ),
            SizedBox(height: SizeConfig.blockSizeVertical * 2,),
            Card(
              margin: EdgeInsets.symmetric(horizontal: SizeConfig.blockSizeHorizontal * 0),
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: SizeConfig.blockSizeHorizontal * 2,
                    vertical: SizeConfig.blockSizeHorizontal * 4
                ),
                child: Column(
                  children: [
                    ListTile(
                      leading: Icon(Icons.pie_chart),
                      title: Text('Quantity'),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: quantityList.map((element){
                          return GestureDetector(
                            onTap: (){

                                _validationService.onChangedQuantity(element);
                                print('clicking ${ _validationService.quantity.value}');
                                print(element == _validationService.quantity.value);
                              // _onQuantitySelected(element);
                            },
                            child: Container(
                                width: SizeConfig.blockSizeHorizontal * 13,
                                margin: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal * 4),
                                padding: EdgeInsets.all(SizeConfig.blockSizeHorizontal * 4),
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: element == _validationService.quantity.value ? Colors.teal : Colors.grey[100]
                                ),
                                child: Center(child: Text('$element')),
                              ),
                          );
                        }).toList(),
                      ),
                    ),
                    // SizedBox(height: SizeConfig.blockSizeVertical * 2,),
                   ListTile(
                          leading: Icon(Icons.image,
                            color: _validationService.receipt.error == null ? Colors.black45 : Colors.red[600],),
                          title: Text('Bank Receipt', style: TextStyle(
                            color: _validationService.receipt.error == null ? Colors.black : Colors.red[600],
                          ),),
                          trailing: _validationService.receipt.value != null ?
                            Text('Uploaded') : Icon(Icons.upload_rounded,
                            color: _validationService.receipt.error == null ? Colors.grey[500] : Colors.red[600]),
                      onTap: _validationService.onChangedReceiptUrl //Get.find<DashboardController>().pickReceiptImage(),
                      ),
                    ListTile(
                        leading: Icon(Icons.monetization_on_outlined),
                        title: Text('Total Price'),
                        trailing: Text('MVR ${_validationService.unitPrice.value * _validationService.quantity.value}'),
                    ),
                  ],
                ),
              ),
            ),
            Spacer(),
            ButtonTheme(
              minWidth: SizeConfig.blockSizeHorizontal * 95,
              height: SizeConfig.blockSizeVertical * 5,
              child: RaisedButton.icon(
                onPressed: _validationService.isValid ? _submitRequest : null,
                label: Text('Send Request'),
                icon: Icon(Icons.send_rounded,),
              ),
              buttonColor: Colors.teal,
              textTheme: ButtonTextTheme.primary,
            )
          ],
        ),
      ),
    );
  }
}
