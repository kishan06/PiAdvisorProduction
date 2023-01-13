import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class CustomRoundedLoadingButton extends StatelessWidget {
  CustomRoundedLoadingButton(
      {Key? key,
      required this.controller,
      required this.validateData,
      required this.text})
      : super(key: key);
  var controller = RoundedLoadingButtonController();
  final GestureTapCallback? validateData;
  String text;
  @override
  Widget build(BuildContext context) {
    return RoundedLoadingButton(
      height: 60,
      resetAfterDuration: true,
      resetDuration: Duration(seconds: 5),
      width: MediaQuery.of(context).size.width * 1,
      color: const Color.fromRGBO(247, 129, 4, 1),
      successColor: const Color.fromRGBO(247, 129, 4, 1),
      controller: controller,
      onPressed: () => validateData, // _validateData(),
      valueColor: Colors.black,
      borderRadius: 10,
      child: Text(
        text,
        style: TextStyle(
          color: Color(0xFFFFFFFF),
          fontSize: 20,
          fontFamily: 'Productsans',
        ),
      ),
    );
  }
}
