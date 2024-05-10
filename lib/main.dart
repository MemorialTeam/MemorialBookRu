import 'package:memorial_book/memorial_book_app.dart';
import 'managers/messaging_manager.dart';
import 'package:flutter/material.dart';
import 'dart:io';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initFirebaseMessaging();
  HttpOverrides.global = MyHttpOverrides();
  runApp(const MemorialBookApp());
}

class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}