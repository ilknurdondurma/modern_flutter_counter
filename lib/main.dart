import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'splashPage.dart';
import 'views/loginPage.dart';


void main() async{
  // ilk giriş kontrolu için shared pref verisi
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setBool('First_time', false);
  bool isFirsttTime = prefs.getBool('First_time') ==false;
  runApp(MyApp(isFirsttTime: isFirsttTime));
}

class MyApp extends StatelessWidget {

  final bool isFirsttTime;

  const MyApp({Key? key, required this.isFirsttTime}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        home: isFirsttTime ? splashPage() : loginPage(),
    );
  }
}