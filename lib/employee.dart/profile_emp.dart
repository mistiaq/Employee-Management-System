import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'FirebaseApi.dart';
import 'dart:io';
import 'package:path/path.dart';

class profile_emp extends StatefulWidget {
  @override
  _profile_empState createState() => _profile_empState();
}

class _profile_empState extends State<profile_emp> {
  UploadTask? task;
  // File? file;
  File? image;
  Future pickImage(ImageSource source) async{
    final image = await ImagePicker().pickImage(source: source);
    try {
      if(image==null) return;
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
    final fileName = image != null ? basename(image!.path) : 'No file selected';
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Spacer(),
            SizedBox(height: 10,),
            image != null?Image.file(image!, width: 160, height: 160,fit: BoxFit.cover,):FlutterLogo(size:160),
            const Center(
              child: Text("Add your Image"),
            ),
            SizedBox(height: 10,),
            ElevatedButton(
              onPressed: () {
                // selectfile;
                pickImage(ImageSource.gallery);
              },
              child: const Icon(Icons.add_photo_alternate_rounded),
            ),
            SizedBox(height: 10,),
            Text(fileName, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            SizedBox(height: 10,),
            ElevatedButton(
              onPressed: () {
                uploadfile;
              },
              child: const Icon(Icons.cloud_upload_outlined),
            ),
            SizedBox(height: 10,),
            ElevatedButton(
              onPressed: () {
                // selectfile;
                pickImage(ImageSource.camera);
              },
              child: const Icon(Icons.camera_alt_outlined),
            ),
            SizedBox(height: 10,),
          ],
        ),
      ),
    );
  }


  // Future selectfile() async {
  //   final result = await FilePicker.platform.pickFiles(allowMultiple: false);
  //   if (result == null) return;
  //   final path = result.files.single.path!;
  //   setState(() {
  //     file = File(path);
  //   });
  // }

  Future uploadfile() async {
    if (image == null) return;

    final fileName = basename(image!.path);
    final destination = "files/$fileName";

    // task =
        firebaseapi.uploadFile(destination, image!);
    // setState(() {
    //
    // });
    // if(task == null) return;
    //
    // final snapshot = await task!.whenComplete(() {});
    // final urlDownload= await snapshot.ref.getDownloadURL();
    // print("Download-Link: $urlDownload");
  }

}
