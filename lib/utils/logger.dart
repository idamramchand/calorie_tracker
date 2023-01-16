


import 'dart:ui';
import 'package:get/get.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Logger {
  static void log(message){
    if(kDebugMode){
      print("Calorie Tracker:::${message}");
    }
  }

  static void showScaffoldMessage({required String msg,Color color = Colors.blue,Color textColor = Colors.white,int duration = 2}) {
    final snackBar = SnackBar(
      content: Text(msg,style: TextStyle(color: textColor),),
      backgroundColor: color,
      duration: Duration(seconds: duration),
      padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 3),
    );
    ScaffoldMessenger.of(Get.context!).showSnackBar(snackBar);
  }
  static void showSnackBar({String title = 'Alert',required String msg, Color color = Colors.blue, Color textColor = Colors.white}) {
    Get.snackbar(title, msg,margin: const EdgeInsets.fromLTRB(5, 20, 10, 5),
        backgroundColor: color,
        colorText: Colors.white);
  }

}