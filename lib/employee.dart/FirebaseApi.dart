import 'dart:io';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';

class firebaseapi{
  static UploadTask? uploadFile(String destination, File file) {
    try {
      final ref = FirebaseStorage.instance.ref(destination);

      return ref.putFile(file);
    } on FirebaseException catch (e) {
      print(e.message.toString());
      return null;
    }
  }
  static UploadTask? uploadBytes(String destination, Uint8List data) {
    try {
      final ref = FirebaseStorage.instance.ref(destination);

      return ref.putData(data);
    } on FirebaseException catch (e) {
      print(e.message.toString());
      return null;
    }
  }
  Widget buildUploadStatus(UploadTask task) =>
      StreamBuilder<TaskSnapshot>(
      stream: task.snapshotEvents,
      builder: (context, snapshot){
        if(snapshot.hasData){
          final snap = snapshot.data!;
          final progress = snap.bytesTransferred / snap.totalBytes;
          return Text('$progress %',
            style: TextStyle(fontSize: 20,
                fontWeight: FontWeight.bold),
          );
        }else{
          return Container();
        }
      }
  );
}
