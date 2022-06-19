import 'package:credo/CONFIG/colors.dart';
import 'package:flutter/material.dart';
import '../EXPORTS/exports.files.dart';

Widget inputField(BuildContext context, controller, label, icon) {
  return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 8),
      child: Material(
        elevation: 3,
        child: Container(
          decoration: const BoxDecoration(border: Border()),
          height: 46,
          child: TextField(
            controller: controller,
            cursorColor: greencolor,
            decoration: InputDecoration(
              prefixIcon: Icon(icon),
              filled: true,
              hintText: label,
              border: const UnderlineInputBorder(
                  borderSide: BorderSide(color: greencolor)),
              focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: greencolor)),
            ),
          ),
        ),
      ));
}

Widget inputFieldPass(
    BuildContext context, controller, label, icon, isObscur, passIcon,eventPass) {
  return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 8),
      child: Material(
        elevation: 3,
        child: Container(
          decoration: const BoxDecoration(border: Border()),
          height: 46,
          child: TextField(
            controller: controller,
            cursorColor: greencolor,
            obscureText: isObscur,
            decoration: InputDecoration(
              prefixIcon: Icon(icon),
              suffixIcon: GestureDetector(child: Icon(passIcon),onTap: eventPass,),
              filled: true,
              hintText: label,
              border: const UnderlineInputBorder(
                  borderSide: BorderSide(color: greencolor)),
              focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: greencolor)),
            ),
          ),
        ),
      ));
}
