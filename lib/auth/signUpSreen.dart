import 'package:flutter/material.dart';
import 'package:getwayaapp/ui/utils.dart';
import 'package:getwayaapp/ui/widgets/roundedButton.dart';
import 'package:firebase_auth/firebase_auth.dart';


class Signupsreen extends StatefulWidget {
  
  const Signupsreen({super.key});

  @override
  State<Signupsreen> createState() => _SignupsreenState();
}

class _SignupsreenState extends State<Signupsreen> {
  bool loading = false;
  final _formKey = GlobalKey<FormState>();
  final namecontroller = TextEditingController();
  final fnamecontroller = TextEditingController();
  final emailcontroller = TextEditingController();
  final passcontroller = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override 
  void dispose() {
    super.dispose();
    emailcontroller.dispose();
    passcontroller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Center(child: Text('Login')),
          automaticallyImplyLeading: false,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: emailcontroller,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(23)),
                          hintText: 'Email',
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Enter The Email';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: passcontroller,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(23)),
                          hintText: 'password',
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Enter the Password';
                          }
                          return null;
                        },
                      ),
                    ],
                  )),
              SizedBox(
                height: 10,
              ),
              Roundedbutton(
                loading:  loading,
                title: 'SignUp',
                onTap: () {
                  if (_formKey.currentState!.validate()) {
                    setState(() {
                      loading = true;
                    });
                    _auth.createUserWithEmailAndPassword(
                        email: emailcontroller.text.toString(),
                        password: passcontroller.text.toString()).then((value){
                          setState(() {
                      loading = false;
                    });
                        }).onError((error, stackTrace){
                         Utils().toastmessage(error.toString());
                         setState(() {
                      loading = false;
                    });
                        });
                  }
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(" have an account"),
                  TextButton(onPressed: () {}, child: Text('Login'))
                ],
              )
            ],
          ),
        ));
  }
}


