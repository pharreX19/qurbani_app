import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qurbani/config/size_config.dart';
import 'package:qurbani/controllers/dashboard_controller.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qurbani/widgets/common/custom_text_field.dart';


class RequestForm extends StatelessWidget {
//  final String requestedService;
//  final DateTime requestedServiceDate;
//  RequestForm({this.requestedService, this.requestedServiceDate});
  final List<int> quantityList = [1, 2];

  void _onQuantitySelected(int quantity){
      Get.find<DashboardController>().setServiceQuantity(quantity);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: (){
            Navigator.pop(context);
            Get.find<DashboardController>().clearErrors();
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
                    Obx((){
                      return CustomTextField(
                        suffixIcon: Icons.person,
                        hintText: 'Child\'s Name',
                        onChanged: Get.find<DashboardController>().onChangedChildNameTextField,
                        errorText: Get.find<DashboardController>().childNameFieldError.value,
                      );
                      // return TextField(
                      //     enabled: Get.find<DashboardController>().childName == null ? true : false,
                      //     maxLength: 100,
                      //     keyboardType: TextInputType.name,
                      //     onChanged: Get.find<DashboardController>().onChangedChildNameTextField,
                      //     decoration: InputDecoration(
                      //         contentPadding: EdgeInsets.symmetric(
                      //           vertical: SizeConfig.blockSizeVertical * 2,
                      //           horizontal: SizeConfig.blockSizeVertical * 2,
                      //         ),
                      //         fillColor: Colors.grey[100],
                      //         filled: true,
                      //         suffixIcon: Icon(Icons.person,color: Colors.grey[500]),
                      //         border: OutlineInputBorder(
                      //             borderSide: BorderSide.none,
                      //             borderRadius: BorderRadius.circular(4.0)
                      //         ),
                      //         floatingLabelBehavior: FloatingLabelBehavior.auto,
                      //         hintText: 'Child Name',
                      //         hintStyle: TextStyle(color: Colors.grey[500]),
                      //         counterText: '',
                      //         errorText: Get.find<DashboardController>().childNameFieldError.value == '' ? null :
                      //         Get.find<DashboardController>().childNameFieldError.value
                      //     )
                      // );
                    }),
                    SizedBox(height: SizeConfig.blockSizeVertical * 4,),
                    Obx((){
                      return CustomTextField(
                        suffixIcon: Icons.person,
                        hintText: 'Contact Number',
                        onChanged: Get.find<DashboardController>().onChangedContactNumberTextField,
                        errorText: Get.find<DashboardController>().contactNumberFieldError.value,
                      );
                      // return Container(
                      //   child: TextField(
                      //       maxLength: 10,
                      //       keyboardType: TextInputType.number,
                      //       onChanged: Get.find<DashboardController>().onChangedContactNumberTextField,
                      //       decoration: InputDecoration(
                      //           contentPadding: EdgeInsets.symmetric(
                      //               vertical: SizeConfig.blockSizeVertical * 2,
                      //               horizontal: SizeConfig.blockSizeVertical * 2,
                      //           ),
                      //           fillColor: Colors.grey[100],
                      //           filled: true,
                      //           suffixIcon: Icon(Icons.phone, color: Colors.grey[500]),
                      //           border: OutlineInputBorder(
                      //               borderSide: BorderSide.none,
                      //               borderRadius: BorderRadius.circular(4.0)
                      //           ),
                      //           floatingLabelBehavior: FloatingLabelBehavior.auto,
                      //           hintText: 'Contact No.',
                      //           hintStyle: TextStyle(color: Colors.grey[500]),
                      //           counterText: '',
                      //           errorText: Get.find<DashboardController>().contactNumberFieldError.value == '' ? null :
                      //           Get.find<DashboardController>().contactNumberFieldError.value
                      //       )
                      //   ),
                      // );
                    }),
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
                              _onQuantitySelected(element);
                            },
                            child: Obx((){
                              return Container(
                                width: SizeConfig.blockSizeHorizontal * 13,
                                margin: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal * 4),
                                padding: EdgeInsets.all(SizeConfig.blockSizeHorizontal * 4),
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: element == Get.find<DashboardController>().serviceQuantity.value ? Colors.teal : Colors.grey[100]
                                ),
                                child: Center(child: Text('$element')),
                              );
                            }),
                          );
                        }).toList(),
                      ),
                    ),
                    // SizedBox(height: SizeConfig.blockSizeVertical * 2,),
                    Obx((){
                      return ListTile(
                          leading: Icon(Icons.image,
                            color: Get.find<DashboardController>().receiptUploadFieldError.value.isEmpty ? Colors.black45 : Colors.red[600],),
                          title: Text('Bank Receipt', style: TextStyle(
                            color: Get.find<DashboardController>().receiptUploadFieldError.value.isEmpty ? Colors.black : Colors.red[600],
                          ),),
                          trailing: Get.find<DashboardController>().receiptUrl.value.isNotEmpty ?
                            Text('Uploaded') : Icon(Icons.upload_rounded,
                            color: Get.find<DashboardController>().receiptUploadFieldError.value.isEmpty ? Colors.grey[500] : Colors.red[600]),
                      onTap: () => Get.find<DashboardController>().pickReceiptImage(),
                      );
                    }),
                    ListTile(
                        leading: Icon(Icons.monetization_on_outlined),
                        title: Text('Total Price'),
                        trailing: Obx(() => Text('MVR ${Get.find<DashboardController>().totalPrice.value}'),)
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
                onPressed: (){
                  Get.find<DashboardController>().submitRequestForm();
                },
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
