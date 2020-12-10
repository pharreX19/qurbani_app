import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qurbani/config/size_config.dart';
import 'package:qurbani/controllers/dashboard_controller.dart';

class RequestForm extends StatefulWidget {
//  final String requestedService;
//  final DateTime requestedServiceDate;

//  RequestForm({this.requestedService, this.requestedServiceDate});

  @override
  _RequestFormState createState() => _RequestFormState();
}

class _RequestFormState extends State<RequestForm> {
  final List<String> quantityList = ['1', '2'];
  int totalPrice;

  void _onQuantitySelected(String quantity){
    setState(() {
      Get.find<DashboardController>().setServiceQuantity(int.parse(quantity));
      totalPrice = UNIT_PRICE * selectedServiceQuantity;
    });
  }

  @override
  void initState() {
    super.initState();
    totalPrice = UNIT_PRICE * selectedServiceQuantity;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      resizeToAvoidBottomPadding: false,
      body: Container(
        padding: EdgeInsets.only(
          top: SizeConfig.blockSizeVertical * 5,
          right: SizeConfig.blockSizeVertical * 2,
          left: SizeConfig.blockSizeVertical * 2,
        ),
        child: Column(
          children: [
            Text(Get.find<DashboardController>().serviceType),
            SizedBox(height: SizeConfig.blockSizeVertical * 1,),
            Text(Get.find<DashboardController>().serviceDate.toLocal().toString()),
            SizedBox(height: SizeConfig.blockSizeVertical * 8,),
            // Row(
            //   children: [
            //     Text('Quantity'),
            //     Spacer(),
            //     ...quantityList.map((element){
            //       return GestureDetector(
            //         onTap: (){
            //           _onQuantitySelected(element);
            //         },
            //         child: Container(
            //           width: SizeConfig.blockSizeHorizontal * 15,
            //           margin: EdgeInsets.only(right: SizeConfig.blockSizeHorizontal * 4),
            //           padding: EdgeInsets.all(SizeConfig.blockSizeHorizontal * 4),
            //           decoration: BoxDecoration(
            //               borderRadius: BorderRadius.circular(10.0),
            //               color: element == selectedServiceQuantity.toString() ? Colors.teal : Colors.grey[100]
            //           ),
            //           child: Center(child: Text(element)),
            //         ),
            //       );
            //     })
            //   ],
            // ),
            // SizedBox(height: SizeConfig.blockSizeVertical * 2,),
            TextFormField(
              maxLength: 100,
              keyboardType: TextInputType.name,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0)
                ),
                floatingLabelBehavior: FloatingLabelBehavior.auto,
                labelText: 'Child Name',
                counterText: '',
              )
            ),
            SizedBox(height: SizeConfig.blockSizeVertical * 4,),
            TextFormField(
              maxLength: 10,
              keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0)
                  ),
                  floatingLabelBehavior: FloatingLabelBehavior.auto,
                  labelText: 'Contact No.',
                  counterText: '',
                )
            ),
            SizedBox(height: SizeConfig.blockSizeVertical * 4,),
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
                    child: Container(
                      width: SizeConfig.blockSizeHorizontal * 13,
                      margin: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal * 4),
                      padding: EdgeInsets.all(SizeConfig.blockSizeHorizontal * 4),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: element == selectedServiceQuantity.toString() ? Colors.teal : Colors.grey[100]
                      ),
                      child: Center(child: Text(element)),
                    ),
                  );
                }).toList(),
              ),
            ),
            // SizedBox(height: SizeConfig.blockSizeVertical * 2,),
            ListTile(
              leading: Icon(Icons.image),
              title: Text('Bank Receipt upload'),
              trailing: Text('IMAGE'),
            ),
            ListTile(
              leading: Icon(Icons.monetization_on_outlined),
              title: Text('Total Price'),
              trailing: Text('MVR $totalPrice'),
            ),
            Spacer(),
            ButtonTheme(
              minWidth: SizeConfig.blockSizeHorizontal * 95,
              height: SizeConfig.blockSizeVertical * 5,
              child: RaisedButton.icon(
                onPressed: (){},
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
