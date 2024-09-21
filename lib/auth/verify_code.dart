import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:getwayaapp/ui/post/post_Screen.dart';
import 'package:getwayaapp/ui/utils.dart';
import 'package:getwayaapp/ui/widgets/roundedButton.dart';

class VerifyCodeScreen extends StatefulWidget {
  final String verificationId;
  const VerifyCodeScreen({super.key, required this.verificationId});

  @override
  State<VerifyCodeScreen> createState() => _VerifyCodeScreenState();
}

class _VerifyCodeScreenState extends State<VerifyCodeScreen> {
  final verifycodecontroller = TextEditingController();
  bool loading = false;
  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Verify Screen'),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 80,
          ),
          TextField(
              controller: verifycodecontroller,
              keyboardType: TextInputType.phone ,
              decoration: InputDecoration(hintText: 'six digit Code'),
            ),
          Roundedbutton(
            title: 'Verfy',
            loading: loading,
            onTap: () async{
              setState(() {
                loading = true;
              });
              final crendital = PhoneAuthProvider.credential(
                  verificationId: widget.verificationId,
                  smsCode: verifycodecontroller.text.toString());
                  try{
                    await auth.signInWithCredential(crendital);
                    Navigator.push(context, MaterialPageRoute(builder: (context) => PostScreen(),));
                  }catch(e){
                    setState(() {
                loading = false;
              });
              Utils().toastmessage(e.toString());
                  }
            },
          )
        ],
      ),
    );
  }
}
