import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class profile_edit extends StatefulWidget {
  // const profile_edit({Key? key}) : super(key: key);

  @override
  _profile_editState createState() => _profile_editState();
}

class _profile_editState extends State<profile_edit> {
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
        .child("$userid/profile-pic")
        .child("post_$postID");

    await ref.putFile(_image!);
    downloadURL = await ref.getDownloadURL();

    await _firestore
        .collection("Employee Table")
        .doc(userid)
        .collection("profile-pic")
        .add({"downloadURL": downloadURL}).whenComplete(() => showSnackBar(
            "Image Uploaded Successfully", Duration(milliseconds: 500)));

    await _firestore.collection("Employee Table").doc(userid).update({"profile-pic":downloadURL});
  }

  showSnackBar(String text, Duration d) {
    final snackText = SnackBar(
      content: Text(text),
      duration: d,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackText);
  }

  Future update_fname(String fname) async {
    FirebaseFirestore _firestore = FirebaseFirestore.instance;
    await _firestore
        .collection("Employee Table")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({"First Name": fname}).whenComplete(
            () => showSnackBar("Uploaded", Duration(milliseconds: 400)));
  }

  Future update_lname(String lname) async {
    FirebaseFirestore _firestore = FirebaseFirestore.instance;
    await _firestore
        .collection("Employee Table")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({"Last Name": lname}).whenComplete(
            () => showSnackBar("Uploaded", Duration(milliseconds: 400)));
  }

  Future update_cnum(String cnum) async {
    FirebaseFirestore _firestore = FirebaseFirestore.instance;
    await _firestore
        .collection("Employee Table")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({"Contact Number": cnum}).whenComplete(
            () => showSnackBar("Uploaded", Duration(milliseconds: 400)));
  }

  Future update_desig(String desig) async {
    //final nows = DateFormat("dd-MM-yyyy").format(DateTime.now()).toString();
    FirebaseFirestore _firestore = FirebaseFirestore.instance;
    await _firestore
        .collection("Employee Table")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({"Designation": desig}).whenComplete(
            () => showSnackBar("Uploaded", Duration(milliseconds: 400)));
  }

  Future update_bio(String bio) async {
    //final nows = DateFormat("dd-MM-yyyy").format(DateTime.now()).toString();
    FirebaseFirestore _firestore = FirebaseFirestore.instance;
    await _firestore
        .collection("Employee Table")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({"Bio": bio}).whenComplete(
            () => showSnackBar("Uploaded", Duration(milliseconds: 400)));
  }

  Future update_lprofile(String lprofile) async {
    //final nows = DateFormat("dd-MM-yyyy").format(DateTime.now()).toString();
    FirebaseFirestore _firestore = FirebaseFirestore.instance;
    await _firestore
        .collection("Employee Table")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({"LinkedIn": lprofile}).whenComplete(
            () => showSnackBar("Uploaded", Duration(milliseconds: 400)));
  }

  Future update_gprofile(String gprofile) async {
    //final nows = DateFormat("dd-MM-yyyy").format(DateTime.now()).toString();
    FirebaseFirestore _firestore = FirebaseFirestore.instance;
    await _firestore
        .collection("Employee Table")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({"Github": gprofile}).whenComplete(
            () => showSnackBar("Uploaded", Duration(milliseconds: 400)));
  }





  Future update_email(String emailadd) async {
    FirebaseFirestore _firestore = FirebaseFirestore.instance;
    await _firestore
        .collection("Employee Table")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({"Email": emailadd}).whenComplete(
            () => showSnackBar("Uploaded", Duration(milliseconds: 400)));

    FirebaseAuth _auth = FirebaseAuth.instance;
    await _auth.currentUser!.updateEmail(emailadd);
  }

  Future update_pass(String password) async {
    FirebaseAuth _auth = FirebaseAuth.instance;
    await _auth.currentUser!.updatePassword(password);
  }


  TextEditingController edit_fname = TextEditingController();
  TextEditingController edit_lname = TextEditingController();
  TextEditingController edit_cnum = TextEditingController();
  TextEditingController edit_email = TextEditingController();
  TextEditingController edit_pass = TextEditingController();
  TextEditingController edit_desig = TextEditingController();
  TextEditingController edit_bio = TextEditingController();
  TextEditingController edit_lprofile = TextEditingController();
  TextEditingController edit_gprofile = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              //Image Selection Container
              Container(
                width: 400,
                height: 512,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.red)),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: _image == null
                            ? const Center(child: Text("No Image Selected"))
                            : Image.file(_image!),
                      ),
                    ],
                  ),
                ),
              ),

              //Select image and Upload Image Button
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 2,
                      child: ElevatedButton(
                          onPressed: () {
                            imagePickermethod();
                          },
                          child: Text("Select Image")),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      flex: 2,
                      child: ElevatedButton(
                          onPressed: () {
                            if (_image != null) {
                              uploadimagemethod();
                            } else {
                              showSnackBar("Select Image First",
                                  Duration(milliseconds: 400));
                            }
                          },
                          child: Text("Upload Image")),
                    )
                  ]),
              SizedBox(
                height: 10,
              ),

              //Editing First name
              Row(
                children: [
                  Expanded(
                    flex: 4,
                    child: Container(
                      height: 65,
                      // width: MediaQuery.of(context).size.width*0.75,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.blue),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: TextField(
                        controller: edit_fname,
                        decoration: InputDecoration(
                          hintText: "Joe",
                          labelText: "Edit First Name",
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Expanded(
                      flex: 1,
                      child: ElevatedButton(
                        onPressed: () {
                          update_fname(edit_fname.text);
                        },
                        child: Container(
                            height: 50,
                            // width: MediaQuery.of(context).size.width*0.75,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.blue),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                            child: Icon(
                              Icons.update_sharp,
                            )),
                      ))
                ],
              ),
              SizedBox(
                height: 10,
              ),

              //Editing Last name
              Row(
                children: [
                  Expanded(
                    flex: 4,
                    child: Container(
                      height: 65,
                      // width: MediaQuery.of(context).size.width*0.75,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.blue),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: TextField(
                        controller: edit_lname,
                        decoration: InputDecoration(
                          hintText: "Parkar",
                          labelText: "Edit last name",
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Expanded(
                      flex: 1,
                      child: ElevatedButton(
                        onPressed: () {
                          update_lname(edit_lname.text);
                        },
                        child: Container(
                            height: 50,
                            // width: MediaQuery.of(context).size.width*0.75,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.blue),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                            child: Icon(
                              Icons.update_sharp,
                            )),
                      ))
                ],
              ),
              SizedBox(
                height: 10,
              ),

              //Editing Contact Number
              Row(
                children: [
                  Expanded(
                    flex: 4,
                    child: Container(
                      height: 65,
                      // width: MediaQuery.of(context).size.width*0.75,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.blue),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: TextField(
                        controller: edit_cnum,
                        decoration: InputDecoration(
                          hintText: "+880 1866 318127",
                          labelText: "Edit Contact Number",
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Expanded(
                      flex: 1,
                      child: ElevatedButton(
                        onPressed: () {
                          update_cnum(edit_cnum.text);
                        },
                        child: Container(
                            height: 50,
                            // width: MediaQuery.of(context).size.width*0.75,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.blue),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                            child: Icon(
                              Icons.update_sharp,
                            )),
                      ))
                ],
              ),
              SizedBox(
                height: 10,
              ),

              //email pass
              //email password
              //Editing Email Address
              // Expanded(
              //   flex: 1,
              //   child: Row(
              //     children: [
              //       Expanded(
              //         flex: 4,
              //         child: Container(
              //           height: 65,
              //             decoration: BoxDecoration(
              //             border: Border.all(color: Colors.blue),
              //             borderRadius:
              //                 BorderRadius.all(Radius.circular(10)),
              //           ),
              //           child: TextField(
              //             controller: edit_email,
              //             decoration: InputDecoration(
              //               hintText: "xyz@domain.com",
              //               labelText: "Edit Email Address",
              //             ),
              //           ),
              //         ),
              //       ),
              //       SizedBox(
              //         width: 5,
              //       ),
              //       Expanded(
              //           flex: 1,
              //           child: ElevatedButton(
              //             onPressed: () {
              //               update_email(edit_email.text);
              //             },
              //             child: Container(
              //                 height: 50,
              //                 // width: MediaQuery.of(context).size.width*0.75,
              //                 decoration: BoxDecoration(
              //                   border: Border.all(color: Colors.blue),
              //                   borderRadius:
              //                       BorderRadius.all(Radius.circular(10)),
              //                 ),
              //                 child: Icon(
              //                   Icons.update_sharp,
              //                 )),
              //           ))
              //     ],
              //   ),
              // ),
              // SizedBox(
              //   height: 10,
              // ),
              //
              // //Editing PassWord
              // Expanded(
              //   flex: 1,
              //   child: Row(
              //     children: [
              //       Expanded(
              //         flex: 4,
              //         child: Container(
              //           height: 65,
              //           // width: MediaQuery.of(context).size.width*0.75,
              //           decoration: BoxDecoration(
              //             border: Border.all(color: Colors.blue),
              //             borderRadius:
              //                 BorderRadius.all(Radius.circular(10)),
              //           ),
              //           child: TextField(
              //             obscureText: true,
              //             controller: edit_pass,
              //             decoration: InputDecoration(
              //               hintText: "******",
              //               labelText: "Edit Password",
              //             ),
              //           ),
              //         ),
              //       ),
              //       SizedBox(
              //         width: 5,
              //       ),
              //       Expanded(
              //           flex: 1,
              //           child: ElevatedButton(
              //             onPressed: () {
              //               update_pass(edit_pass.text);
              //             },
              //             child: Container(
              //                 height: 50,
              //                 // width: MediaQuery.of(context).size.width*0.75,
              //                 decoration: BoxDecoration(
              //                   border: Border.all(color: Colors.blue),
              //                   borderRadius:
              //                       BorderRadius.all(Radius.circular(10)),
              //                 ),
              //                 child: Icon(
              //                   Icons.update_sharp,
              //                 )),
              //           ))
              //     ],
              //   ),
              // ),
              // SizedBox(
              //   height: 10,
              // ),

              //Editing Designation
              Row(
                children: [
                  Expanded(
                    flex: 4,
                    child: Container(
                      height: 65,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.blue),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: TextField(
                        // obscureText: true,
                        controller: edit_desig,
                        decoration: InputDecoration(
                          hintText: "e.g. Software Engineer, Designer",
                          labelText: "Edit Designation",
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Expanded(
                      flex: 1,
                      child: ElevatedButton(
                        onPressed: () {
                          update_desig(edit_desig.text);
                        },
                        child: Container(
                            height: 50,
                            // width: MediaQuery.of(context).size.width*0.75,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.blue),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                            child: Icon(
                              Icons.update_sharp,
                            )),
                      ))
                ],
              ),
              SizedBox(
                height: 10,
              ),

              //Editing Bio
              Row(
                children: [
                  Expanded(
                    flex: 4,
                    child: Container(
                      height: 65,
                      // width: MediaQuery.of(context).size.width*0.75,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.blue),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: TextField(
                        // obscureText: true,
                        controller: edit_bio,
                        decoration: const InputDecoration(
                          hintText: "e.g. Learner, Passionate",
                          labelText: "Edit Bio",
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Expanded(
                      flex: 1,
                      child: ElevatedButton(
                        onPressed: () {
                          update_bio(edit_bio.text);
                        },
                        child: Container(
                            height: 50,
                            // width: MediaQuery.of(context).size.width*0.75,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.blue),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                            child: const Icon(
                              Icons.update_sharp,
                            )),
                      ))
                ],
              ),
              SizedBox(
                height: 10,
              ),

              //Editing LinkedIn Profile Link
              Row(
                children: [
                  Expanded(
                    flex: 4,
                    child: Container(
                      height: 65,
                      // width: MediaQuery.of(context).size.width*0.75,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.blue),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: TextField(
                        // obscureText: true,
                        controller: edit_lprofile,
                        decoration: const InputDecoration(
                          hintText: "LinkedIn Profile Link",
                          labelText: "Edit LinkedIn Profile Link",
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Expanded(
                      flex: 1,
                      child: ElevatedButton(
                        onPressed: () {
                          update_lprofile(edit_lprofile.text);
                        },
                        child: Container(
                            height: 50,
                            // width: MediaQuery.of(context).size.width*0.75,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.blue),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                            child: Icon(
                              Icons.update_sharp,
                            )),
                      ))
                ],
              ),
              SizedBox(
                height: 10,
              ),

              //Editing Github Profile Link
              Row(
                children: [
                  Expanded(
                    flex: 4,
                    child: Container(
                      height: 65,
                      // width: MediaQuery.of(context).size.width*0.75,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.blue),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: TextField(
                        // obscureText: true,
                        controller: edit_gprofile,
                        decoration: const InputDecoration(
                          hintText: "Github Profile Link",
                          labelText: "Edit Github Profile Link",
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Expanded(
                      flex: 1,
                      child: ElevatedButton(
                        onPressed: () {
                          update_gprofile(edit_gprofile.text);
                        },
                        child: Container(
                            height: 50,
                            // width: MediaQuery.of(context).size.width*0.75,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.blue),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10)),
                            ),
                            child: const Icon(
                              Icons.update_sharp,
                            )),
                      ))
                ],
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
