

import 'package:get/get.dart';
import '../splash/splash_api.dart';
import '/home/home_controller.dart';
import '/splash/splash_controller.dart';

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