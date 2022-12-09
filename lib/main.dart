

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:get/get.dart';
import '/utility/binding.dart';
import '/utility/routes_manager.dart';


Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();



  runApp(const MyApp());
}




class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return Phoenix(
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        getPages: AppRouter.pages,
          initialBinding:SplashBinding() ,
        initialRoute: '/splash',
      ),
    );
  }
}