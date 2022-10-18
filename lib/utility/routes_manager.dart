import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '/home/home_view.dart';
import '/splash/splash_view.dart';

import 'binding.dart';



class AppRouter {
  static List<GetPage> pages =  [

    GetPage(name: "/home", page:()=> Home() , binding: HomeBinding()),

    GetPage(name: "/splash", page: ()=> SplashView() , binding: SplashBinding()),



  ];
}