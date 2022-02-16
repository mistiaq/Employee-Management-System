import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:employee_manegement/SignUp_SignIn_Login/LoginPage.dart';
import 'package:employee_manegement/national/flutter_toast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class sign_up extends StatefulWidget {
  @override
  _sign_up_state createState() => _sign_up_state();
}

class _sign_up_state extends State<sign_up> {
  var userid;
  Future add_employee(a, b, c, d, e) async {
    var downloadURL = "https://cdn3.iconfinder.com/data/icons/users-outline/60/50_-Blank_Profile-_user_people_group_team-512.png";
    // userid = FirebaseAuth.instance.currentUser!.uid.toString();
    CollectionReference refs =
        FirebaseFirestore.instance.collection("Employee Table");
    Map<String, dynamic> emp_data = <String, dynamic>{
      "First Name": a,
      "Last Name": b,
      "Email": c,
      "Contact Number": d,
      // "Password": e,
      // "uid": userid,
      "profile-pic":downloadURL,
    };
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: c, password: e);
      Common_Toast().customtoast("Please Log In", Duration(milliseconds: 400));
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => login_page()));
    } on FirebaseAuthException catch (e) {
      if (e.code == "ERROR_USER_DISABLED") {
        Common_Toast().customtoast(
            "The account with which the email is associated exists but has been disabled.", Duration(milliseconds: 400));
      } else if (e.code == "ERROR_USER_NOT_FOUND") {
        Common_Toast().customtoast(
            "No account could be found that matches the specified email address.", Duration(milliseconds: 400));
      } else if (e.code == "ERROR_EMAIL_ALREADY_IN_USE ") {
        Common_Toast().customtoast(
            "User is attempting to create a new account, or change the email address for an existing account that is already in use by another account. ", Duration(milliseconds: 400));
      } else if (e.code == "FirebaseAuthWeakPasswordException") {
        Common_Toast().customtoast(
            "the password specified during an account creation or password update operation is insufficiently strong.", Duration(milliseconds: 400));
      }} catch (e) {
      Common_Toast().customtoast(e.toString(), Duration(milliseconds: 400));
    }
    userid = FirebaseAuth.instance.currentUser!.uid.toString();
    refs.doc(userid)
        .set(emp_data)
        .whenComplete(() => print('Employee added'))
        .catchError((onError) => Common_Toast().customtoast("Failed to add user: $onError", Duration(milliseconds: 400)));
  }

  var f_name_controller = TextEditingController();
  var l_name_controller = TextEditingController();
  var email_controller = TextEditingController();
  var contact_num_controller = TextEditingController();
  var pass_controller = TextEditingController();
  var confirm_pass_controller = TextEditingController();
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
      body: Container(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextField(
                controller: f_name_controller,
                decoration: const InputDecoration(
                    icon: Icon(Icons.message_outlined),
                    labelText: "First Name",
                    hintText: "e.g. Joe",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    )),
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                controller: l_name_controller,
                decoration: const InputDecoration(
                    icon: Icon(Icons.message_outlined),
                    labelText: "Last Name",
                    hintText: "e.g. Parker",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    )),
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                controller: email_controller,
                decoration: const InputDecoration(
                    icon: Icon(Icons.email),
                    labelText: "Enter Email",
                    hintText: "e.g. abc@xyz.com",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    )),
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                controller: contact_num_controller,
                decoration: const InputDecoration(
                    icon: Icon(Icons.phone),
                    labelText: "Contact Number",
                    hintText: "e.g. +880 1*** ******",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    )),
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                obscureText: true,
                  controller: pass_controller,
                  // onSubmitted: check_pass(pass_controller.text),
                  decoration: InputDecoration(
                    icon: Icon(Icons.password_rounded,),
                    labelText: "Enter Password",
                    hintText: "******",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5)
                      ),
                    ),
                  ),
              ),
              // TextField(
              //
              //   obscureText: true,
              //   controller: pass_controller,
              //   decoration: InputDecoration(
              //       icon: Icon(Icons.password_rounded),
              //       labelText: "Enter Password",
              //       hintText: "********",
              //       border: OutlineInputBorder(
              //         borderRadius: BorderRadius.all(Radius.circular(5)),
              //       )),
              // ),
              SizedBox(
                height: 10,
              ),
              TextField(
                obscureText: true,
                controller: confirm_pass_controller,
                // obscureText: true,
                decoration: const InputDecoration(
                    icon: Icon(Icons.password_rounded),
                    labelText: "Confirm Password",
                    hintText: "********",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    )),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment:CrossAxisAlignment.center,
                children: [
                  Text("Already have an account?"),
                  TextButton(
                    onPressed: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=> login_page()));
                    },
                    child: Text("Log In", style: TextStyle(decoration: TextDecoration.underline)),
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: () {
                  if(pass_controller.text== "" && confirm_pass_controller.text == ""&& f_name_controller.text == ""&&l_name_controller.text == ""&& contact_num_controller.text == "" && email_controller.text == "")
                      showSnackBar("Any of the Field cannot be null", Duration(milliseconds: 500));
                  else if(pass_controller.text!=confirm_pass_controller.text)
                    showSnackBar("Password does not match",Duration(milliseconds: 500));
                  else {
                    add_employee(
                        f_name_controller.text,
                        l_name_controller.text,
                        email_controller.text,
                        contact_num_controller.text,
                        pass_controller.text);
                  }
                },
                child: Text("Register"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
