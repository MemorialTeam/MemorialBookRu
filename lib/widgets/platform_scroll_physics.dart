import 'dart:io';
import 'package:flutter/material.dart';

ScrollPhysics platformScrollPhysics() {
  if(Platform.isAndroid) {
    return const ClampingScrollPhysics();
  } else {
    return const BouncingScrollPhysics();
  }
}