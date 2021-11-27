import 'dart:html';

import 'package:flutter/material.dart';
import 'package:get/get.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Expanded(
          flex: 1,
          child: Column(
            children: [
            Image.asset(
            "spring.jpg",scale: 1.0,),
              ElevatedButton(onPressed: (){
                Get.toNamed("Homepage");
              }, child: Text("go to home page"))
            ],
          ),
        ),
      ),
    );
  }
}
