import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:getwayaapp/ui/utils.dart';
import 'package:getwayaapp/ui/widgets/roundedButton.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({super.key});

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  bool loading = false;
  final databaseRef = FirebaseDatabase.instance.ref('post');
  final postcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add post'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            TextFormField(
              controller: postcontroller,
              maxLines: 4,
              decoration: InputDecoration(
                  hintText: 'What is your mind', border: OutlineInputBorder()),
            ),
            SizedBox(
              height: 50,
            ),
            Roundedbutton(
              title: 'Add',
              loading: loading,
              onTap: () {
                setState(() {
                  loading = true;
                });
                String id = DateTime.now().millisecondsSinceEpoch.toString();
                databaseRef.child(id).set({
                  'title': postcontroller.text.toString(),
                  'id': id
                }).then((value) {
                  Utils().toastmessage('post Added');
                  setState(() {
                    loading = false;
                  });
                }).onError(
                  (error, stackTrace) {
                    Utils().toastmessage(error.toString());
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
