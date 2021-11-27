


import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webpointtracker/views/loginpage.dart';
import 'package:webpointtracker/views/point_tracker.dart';

class AuthController extends GetxController{

  //auth controller.instance..make global in app

  static  AuthController instance = Get.find();

 //firebase user model available here

//email,password,name from firebase model
late Rx<User?> _user;


FirebaseAuth auth = FirebaseAuth.instance;

@override
  void onReady() {
  super.onReady();
  _user = Rx<User?>(auth.currentUser);
  //track user login,logout changes with
  //user will be notified
  _user.bindStream(auth.userChanges());
  //ever function take listener/stream an callback function
  ever(_user,_initialScreen);
}

  _initialScreen(User? user){
    if(user ==null){
      print('login page');
      Get.offAll(() => LoginPage());
    }else{
      Get.offAll(() => MyHomePage(title: "home page"));
    }
  }

  void register(String email,password)async{
  try {
   await auth.createUserWithEmailAndPassword(email: email, password: password);

  } catch (e){
    Get.snackbar("About User", "User Message",
    backgroundColor: Colors.redAccent,
    snackPosition: SnackPosition.BOTTOM,
      titleText: Text("Account creation failed",
        style: TextStyle(color: Colors.white),
      ),
      messageText: Text(e.toString(),
      style: TextStyle(color: Colors.white),),
    );

  }
  }
  void login(String email,password)async{
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);

    } catch (e){
      Get.snackbar("About Login", "Login Message",
        backgroundColor: Colors.redAccent,
        snackPosition: SnackPosition.BOTTOM,
        titleText: Text("Login failed",
          style: TextStyle(color: Colors.white),
        ),
        messageText: Text(e.toString(),
          style: TextStyle(color: Colors.white),),
      );

    }
  }


  void logOut(){
  auth.signOut();
  }


  }









