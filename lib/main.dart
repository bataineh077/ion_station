import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:get/get.dart';
import '/home/home_view.dart';
import '/utility/binding.dart';
import '/utility/routes_manager.dart';

import 'demo.dart';
import 'splash/splash_api.dart';

void main() {
 // SplashApi().socketConnection();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //  box.write('token', '');

    return Phoenix(
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
       // initialBinding: SplashBinding(),
        getPages: AppRouter.pages,
          initialBinding:SplashBinding() ,
        // ignore: deprecated_member_use
        initialRoute: '/splash',
        theme: ThemeData(backgroundColor: Color(0xFFEFF3FA),scaffoldBackgroundColor: Color(0xFFEFF3FA),
          appBarTheme: AppBarTheme(backgroundColor:  Color(0xFFEFF3FA),titleTextStyle:TextStyle(color: Colors.black),
              iconTheme: IconThemeData(color: Colors.black),elevation:0.2),
        ),
        // onInit:()=> IsAuth(),
      ),
    );
  }
}