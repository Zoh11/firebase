import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:getwayaapp/ui/utils.dart';
import 'package:getwayaapp/ui/widgets/roundedButton.dart';

class ForgotpasswordScreen extends StatefulWidget {
  const ForgotpasswordScreen({super.key});

  @override
  State<ForgotpasswordScreen> createState() => _ForgotpasswordScreenState();
}

class _ForgotpasswordScreenState extends State<ForgotpasswordScreen> {
  final emailcontroller = TextEditingController();
  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('forgot Password'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFormField(
              
              controller: emailcontroller,
              decoration: InputDecoration(hintText: 'Email'),
            ),
            SizedBox(height: 40,)
          ,Roundedbutton(title: 'Verify', onTap: () {
            auth.sendPasswordResetEmail(email: emailcontroller.text.toString()).then((value) {
              Utils().toastmessage("we have send you Email  to recover password, Please check email");
            },).onError(  (error, stackTrace) {
              Utils().toastmessage(error.toString());
            },); 
          },)
          ],
        ),
      ),
    );
  }
}
