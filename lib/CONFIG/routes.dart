import 'package:flutter/material.dart';

void goto(context, page) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => page),
  );
}

void back(context) => Navigator.of(context).pop();

goTo(context, page) => Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
