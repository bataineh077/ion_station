import 'package:flutter/material.dart';
import 'package:ion_station/home.dart';

import 'demo.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //  box.write('token', '');

    return MaterialApp(
      debugShowCheckedModeBanner: false,
     // initialBinding: SplashBinding(),
     // getPages: AppRouter.pages,
      //  initialBinding:ControlBinding() ,
      // ignore: deprecated_member_use
      home: Home(),
      theme: ThemeData(backgroundColor: Color(0xFFEFF3FA),scaffoldBackgroundColor: Color(0xFFEFF3FA),
        appBarTheme: AppBarTheme(backgroundColor:  Color(0xFFEFF3FA),titleTextStyle:TextStyle(color: Colors.black),
            iconTheme: IconThemeData(color: Colors.black),elevation:0.2),
      ),
      // onInit:()=> IsAuth(),
    );
  }
}