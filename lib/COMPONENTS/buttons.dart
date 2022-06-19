import 'package:flutter/material.dart';
import '../EXPORTS/exports.files.dart';

Widget button(BuildContext context, event, label) {
  return Padding(
    padding: const EdgeInsets.only(top: 8, bottom: 8),
    child: SizedBox(
      height: 46,
      width: fullWidth(context),
      child: OutlinedButton(
        onPressed: event,
        child: Text(
          label,
          style: const TextStyle(color: Colors.white),
        ),
        style: OutlinedButton.styleFrom(
            backgroundColor: greencolor),
      ),
    ),
  );
}
