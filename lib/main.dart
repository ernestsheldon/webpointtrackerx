import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:webpointtracker/views/loginpage.dart';
import 'package:webpointtracker/views/point_tracker.dart';
import 'package:webpointtracker/views/registerpage.dart';
import 'package:webpointtracker/views/splashpage.dart';
//import 'package:webpointtracker/views/point_tracker.dart';
import 'package:webpointtracker/views/spring_feed_calculator.dart';
import 'package:get/get.dart';

import 'controllers/auth_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp().then((value) => Get.put(AuthController()));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Work Place App v1.0',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      initialRoute: "/",
      getPages: [
        GetPage(name: "/", page: ()=> LoginPage()),//MyHomePage(title: "Work Place app")),
        GetPage(name: "/splashpage", page: ()=> SplashScreen()),
        GetPage(name: "/loginpage", page: ()=> LoginPage()),
        GetPage(name: "/registerpage", page: ()=> RegisterPage()),
        GetPage(name: "/calculatorpage", page: () => SpringsCalculator(title: 'Calculator')),
      ],
      //home: MyHomePage(title: 'Point Tracker',),
    );
  }
}

