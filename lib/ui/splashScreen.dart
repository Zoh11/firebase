import 'package:flutter/material.dart';
import 'package:getwayaapp/firebase_Service/splash_Service.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  SplashService splashScreen = SplashService();
  @override
  void initState() {

    super.initState();
    splashScreen.islogin(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Firebase Screen', style: TextStyle(fontSize: 34),),
      ),
    );
  }
}
