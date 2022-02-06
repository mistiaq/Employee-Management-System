import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class imageupload extends StatefulWidget {
  String? userId;
  imageupload({Key? key, this.userId}) : super(key: key);
  @override
  _imageuploadState createState() => _imageuploadState();
}
class _imageuploadState extends State<imageupload> {
  File? _image;
  String? downloadURL;
  var userid = FirebaseAuth.instance.currentUser!.uid.toString();
  final imagePicker = ImagePicker();
  Future imagePickermethod() async {
    final pick = await imagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pick != null) {
        _image = File(pick.path);
      } else {
        showSnackBar("No file selected", Duration(milliseconds: 400));
      }
    });
  }
  Future uploadimagemethod() async {
    final postID = DateTime.now().millisecondsSinceEpoch.toString();
    FirebaseFirestore _firestore = FirebaseFirestore.instance;
    Reference ref = FirebaseStorage.instance
        .ref()
        .child("${userid}/images")
        .child("post_$postID");

    await ref.putFile(_image!);
    downloadURL = await ref.getDownloadURL();

    await _firestore.collection("Employee Table")
        .doc(userid)
        .collection("images")
        .add({"downloadURL":downloadURL}).whenComplete(() =>
        showSnackBar(
            "Image Uploaded Successfully",
            Duration(milliseconds: 500)));
  }
  showSnackBar(String text, Duration d) {
    final snackText = SnackBar(
      content: Text(text),
      duration: d,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackText);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Image Upload"),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(8),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: SizedBox(
              height: 550,
              width: double.infinity,
              child: Column(
                children: [
                  const Text("Upload Image"),
                  const SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    flex: 4,
                    child: Container(
                      width: 300,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.red)),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: _image == null
                                  ? const Center(
                                      child: Text("No Image Selected"))
                                  : Image.file(_image!),
                            ),
                            ElevatedButton(
                                onPressed: () {
                                  imagePickermethod();
                                },
                                child: Text("Select Images")),
                            ElevatedButton(
                                onPressed: () {
                                  if (_image != null) {
                                    uploadimagemethod();
                                  } else {
                                    showSnackBar("Select Image First",
                                        Duration(milliseconds: 400));
                                  }
                                },
                                child: Text("Upload Images")),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
