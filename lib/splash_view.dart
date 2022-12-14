import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ion_station/splash_controller.dart';



class SplashView extends StatelessWidget {

  SplashController controller = Get.put(SplashController());

  @override
  Widget build(BuildContext context) {
        return const Scaffold(
          backgroundColor: Colors.white,

          body:  Center(
            child: Icon(Icons.ac_unit),
          ),
        );

  }
}
