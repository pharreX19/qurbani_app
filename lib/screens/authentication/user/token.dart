import 'package:flutter/material.dart';
import 'package:qurbani/config/size_config.dart';
import 'package:qurbani/widgets/common/main_layout.dart';

class Token extends StatefulWidget {
  @override
  _TokenState createState() => _TokenState();
}

class _TokenState extends State<Token> {
  final List<FocusNode> focusNode = [FocusNode(), FocusNode(), FocusNode(), FocusNode()];

  final List<TextEditingController> textEditingController = [
    TextEditingController(text: '0'),
    TextEditingController(text: '0'),
    TextEditingController(text: '0'),
    TextEditingController(text: '0')
  ];

  @override
  void initState() {
    super.initState();
    focusNode[1].addListener(() {
      print('NOW LISTENING');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: SizeConfig.blockSizeVertical * 10),
        child: Column(
          children: [
            Text('Enter the code you received via SMS'),
            Spacer(),
            Center(child: Text('Your 6 digit Code')),
            Wrap(
              children: List.generate(4, (index){
                return FractionallySizedBox(
                  widthFactor: 0.25,
                  // height: SizeConfig.blockSizeHorizontal * 20,
                  child: Container(
                    child: TextFormField(
                      textAlign: TextAlign.center,
                      controller: textEditingController[index],
                      showCursor: false,
                      focusNode: focusNode[index],
                      autofocus: index == 0 ? true : false,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration.collapsed(
                          hintText: '0',
                      ),
                      maxLength: 2,
                      onChanged: (value){
                        print(value);
                        textEditingController[index].text = value.substring(1);
                        if(value.isNotEmpty && index < 3){
                          FocusScope.of(context).requestFocus(focusNode[index+1]);
                        }else if(value.isEmpty && index > 0){
                          FocusScope.of(context).requestFocus(focusNode[index-1]);
                        }
                      },
                    ),
                  ),
                );
              }),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
