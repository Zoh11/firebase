import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:getwayaapp/auth/login_Screen.dart';
import 'package:getwayaapp/ui/utils.dart';
import 'package:getwayaapp/ui/widgets/roundedButton.dart';
import 'package:image_picker/image_picker.dart';

import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class UploadimageScreen extends StatefulWidget {
  const UploadimageScreen({super.key});

  @override
  State<UploadimageScreen> createState() => _UploadimageScreenState();
}

class _UploadimageScreenState extends State<UploadimageScreen> {
  bool loading = false;
  File? _images;
  final picker = ImagePicker();

  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;
  DatabaseReference databaseRef = FirebaseDatabase.instance.ref('post');
  Future getImageGallery() async {
    final PickedFile =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 80);
    setState(() {
      if (PickedFile != null) {
        _images = File(PickedFile.path);
      } else {
        print('Image is not pick');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add image'),
      actions: [
          IconButton(
              onPressed: () {
            
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginScreen(),
                        )).onError((error, stackTrace) {
                      Utils().toastmessage(error.toString());
                    });
                  
              },
              icon: Icon(Icons.logout_outlined)),
        ],),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: InkWell(
                onTap: () {
                  getImageGallery();
                },
                child: Container(
                  width: 200,
                  height: 200,
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.black)),
                  child: _images != null
                      ? Image.file(
                          _images!.absolute,
                          width: 400,
                          height: 400,
                        )
                      : Icon(
                          Icons.image,
                        ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Roundedbutton(
              title: 'Upload',
              loading: loading,
              onTap: () async {
                setState(() {
                  loading = true;
                });
                firebase_storage.Reference ref = firebase_storage
                    .FirebaseStorage.instance
                    .ref('/foldername/' + DateTime.now().microsecondsSinceEpoch.toString());
                firebase_storage.UploadTask uploadTask =
                    ref.putFile(_images!.absolute);
                 Future.value(uploadTask)
                    .then(
                  (value) async {
                    var newUrl = await ref.getDownloadURL();
                databaseRef
                    .child('1')
                    .set({'id': '1212', 'title': newUrl.toString()}).then(
                  (value) {
                    setState(() {
                      loading = false;
                    });
                    Utils().toastmessage('Uploaded');
                  },
                 ).onError(
                  (error, stackTrace) {
                    setState(() {
                      loading = false;
                    });
                  },
                );
                  },
                )
                    .onError(
                  (error, stackTrace) {
                    Utils().toastmessage(error.toString());
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
