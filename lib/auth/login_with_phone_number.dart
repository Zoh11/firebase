import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:getwayaapp/auth/verify_code.dart';
import 'package:getwayaapp/ui/utils.dart';
import 'package:getwayaapp/ui/widgets/roundedButton.dart';

class LoginWithPhoneNumber extends StatefulWidget {
  const LoginWithPhoneNumber({super.key});

  @override
  State<LoginWithPhoneNumber> createState() => _LoginWithPhoneNumberState();
}

class _LoginWithPhoneNumberState extends State<LoginWithPhoneNumber> {
  final phonenumbercontroller = TextEditingController();
  bool loading = false;
  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Loginm'),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 80),
        child: Column(
          children: [
            SizedBox(
              height: 50,
            ), 
            TextField(
              controller: phonenumbercontroller,
              keyboardType: TextInputType.phone ,
              decoration: InputDecoration(hintText: '+92314++++++'),
            ),
            SizedBox(
              height: 50,
            ),
            Roundedbutton(
               title: 'Login',
              loading: loading,
              onTap: () {
                setState(() {
                  loading = true;
                });
                auth.verifyPhoneNumber(
                  phoneNumber: phonenumbercontroller.text,
                  verificationCompleted: (_) {
                    setState(() {
                  loading = false;
                });
                  },
                  verificationFailed: (e) {
                     setState(() {
                  loading = false;
                });  
                    Utils().toastmessage(e.toString());
                  },
                  codeSent: (String verificationId, int? token) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => VerifyCodeScreen(
                            verificationId: verificationId   ,

                          ),
                        ));
                         setState(() {
                  loading = false;
                });
                  },
                  codeAutoRetrievalTimeout: (e) {
                    Utils().toastmessage(e.toString());
                     setState(() {
                  loading = false;
                });
                  },
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
