

import 'package:get/get.dart';
import 'package:ion_station/controller.dart';
import 'package:ion_station/splash_controller.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController());

  }
}

class SplashBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SplashController>(() => SplashController());

  }
}