import 'package:flutter/material.dart';

List<Widget> generateElement({
  required List array,
  TextStyle? elementTextStyle,
}) {
  List<Widget> textArray = [
    const Text(''),
  ];
  for (var element in array) {
    textArray.add(
      Text(
        element.toString(),
        style: elementTextStyle,
      ),
    );
  }
  return textArray;
}