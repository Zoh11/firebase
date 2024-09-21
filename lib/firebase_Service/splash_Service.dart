import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:getwayaapp/auth/login_Screen.dart';
import 'package:getwayaapp/ui/uploadImage.dart';

class SplashService {
  void islogin (BuildContext context){
    final auth = FirebaseAuth.instance;
    final User = auth.currentUser;
    if(User != null){
   Timer(Duration(seconds: 3), () {
    Navigator.push(context, MaterialPageRoute(builder: (context) => UploadimageScreen(),));
  },
  
  );
    }else{
       Timer(Duration(seconds: 3), () {
    Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen(),));
  },);
    }
 
  }
}