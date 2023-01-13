// ignore_for_file: file_names

import 'package:get/get.dart';
import 'package:piadvisory/Utils/textStyles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    Key? key,
    this.controller,
    this.hint,
    this.ontap,
    this.errortext,
    this.limitlength,
    this.maxlength,
    this.texttype,
    this.maxlines,
    this.keyboardType,
    this.inputFormatters,

  }) : super(key: key);

  final TextEditingController? controller;
  final String? hint;
  final String? errortext;
  final Function(String)? ontap;
  final int? limitlength;
  final int? maxlength;
  final TextInputType? texttype;
  final int? maxlines;
  final TextInputType? keyboardType;
  final FilteringTextInputFormatter? inputFormatters;
  

  @override
  Widget build(BuildContext context) {
    
    return TextFormField(
       maxLines: maxlines ?? 1,
       
      maxLength: maxlength,
      cursorColor:Color(0xFF303030).withOpacity(0.3),
      style: const TextStyle(
        //color: Colors.grey,
        fontFamily: 'Productsans',
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        //   contentPadding: EdgeInsets.all(15),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(color: Colors.grey, width: 2.0),
        ),
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(color: Colors.grey, width: 2.0),
        ),
        errorMaxLines: 3,
        hintText: hint,
        hintStyle: Get.isDarkMode?
          Theme.of(context).textTheme.headline3 :  blackStyle(context).copyWith(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Color(0xFF303030).withOpacity(0.3)),
        fillColor: Get.isDarkMode?Color(0xFF303030).withOpacity(0.3): Colors.white,
        filled: true,
        errorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(color: Colors.red, width: 2.0),
        ),
        focusedErrorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(color: Colors.red, width: 2.0),
        ),
        errorStyle: const TextStyle(
          fontSize: 16.0,
        ),
       
      ),
      controller: controller,
      keyboardType: texttype,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return errortext ?? "Empty value";
        }
        return null;
      },
      inputFormatters: [
        LengthLimitingTextInputFormatter(limitlength ?? 20),
       // FilteringTextInputFormatter.allow(RegExp("[a-zA-Z ]")), 
      ],
      onSaved: (value) {
        ontap?.call;
      },
    );
  }
}
