import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'FirebaseApi.dart';
import 'dart:io';
import 'package:path/path.dart';

class profile_emp extends StatefulWidget {
  @override
  _profile_empState createState() => _profile_empState();
}

class _profile_empState extends State<profile_emp> {
  UploadTask? task;
  File? file;

  @override
  Widget build(BuildContext context) {
    final fileName = file != null ? basename(file!.path) : 'No file selected';
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Center(
              child: Text("Add your Image"),
            ),
            ElevatedButton(
              onPressed: () {
                selectfile;
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
            task!= null? buildUploadStatus(task!):Container(),
          ],
        ),
      ),
    );
  }


  Future selectfile() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);
    if (result == null) return;
    final path = result.files.single.path!;
    setState(() {
      file = File(path);
    });
  }

  Future uploadfile() async {
    if (file == null) return;

    final fileName = basename(file!.path);
    final destination = "files/$fileName";

    task = firebaseapi.uploadFile(destination, file!);
    setState(() {

    });
    if(task == null) return;

    final snapshot = await task!.whenComplete(() {});
    final urlDownload= await snapshot.ref.getDownloadURL();
    print("Download-Link: $urlDownload");
  }

}
