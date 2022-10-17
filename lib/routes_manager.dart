import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:ion_station/home.dart';
import 'package:ion_station/splash_view.dart';

import 'binding.dart';


class AppRouter {
  static List<GetPage> pages =  [

    GetPage(name: "/home", page:()=> Home() , binding: HomeBinding()),

    GetPage(name: "/splash", page: ()=> SplashView() , binding: SplashBinding()),



  ];
}