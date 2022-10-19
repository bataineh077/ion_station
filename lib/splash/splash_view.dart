import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/splash/splash_controller.dart';



class SplashView extends StatelessWidget {

  SplashController controller = Get.put(SplashController());

  @override
  Widget build(BuildContext context) {
        return const Scaffold(
          backgroundColor: Colors.white,

          body:  Center(
            child: Image(image: AssetImage("assets/images/icon_charging.png"),color: Colors.black,),
          ),
        );

  }
}
