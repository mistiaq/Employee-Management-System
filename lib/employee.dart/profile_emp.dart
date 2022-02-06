import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:employee_manegement/employee.dart/imageupload/show_images.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'imageupload/image_upload.dart';
import '../national/model.dart';

class profile_emp extends StatefulWidget {
  @override
  _profile_empState createState() => _profile_empState();
}

class _profile_empState extends State<profile_emp> {
  // User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedinUser = UserModel();

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("Employee Table")
        .doc(loggedinUser.uid)
        .get()
        .then((value) {
      this.loggedinUser = UserModel.fromMap(value.data());
      setState(() {});
    });
  }

  UploadTask? task;
  File? image;

  Future pickImage(ImageSource source) async {
    final image = await ImagePicker().pickImage(source: source);
    try {
      if (image == null) return;
      final imageTemporary = File(image.path);
      setState(() {
        this.image = imageTemporary;
      });
    } on PlatformException catch (e) {
      print("Failed to pick image: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Spacer(),
            SizedBox(height: 10,),
            image != null
                ? Image.file(
              image!, width: 160, height: 160, fit: BoxFit.cover,)
                : FlutterLogo(size: 160),
            const Center(
              child: Text("Add your Image"),
            ),
            SizedBox(height: 10,),
            ElevatedButton(
              onPressed: () {
                // uploadfile;
                Navigator.push(context, MaterialPageRoute(builder: (context) =>
                    imageupload(userId: loggedinUser.uid)));
              },

              child: const Icon(Icons.cloud_upload_outlined),
            ),
            SizedBox(height: 10,),
            ElevatedButton(
              onPressed: () {
                // selectfile;
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => showimages(userId: loggedinUser.uid)));
              },
              child: const Icon(Icons.camera_alt_outlined),
            ),
            SizedBox(height: 10,),
          ],
        ),
      ),
    );
  }
}