import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:employee_manegement/national/flutter_toast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../demo4all.dart';

class sign_up extends StatefulWidget {

  @override
  _sign_up_state createState() => _sign_up_state();
}

class _sign_up_state extends State<sign_up> {
  Future add_employee(a,b,c,d,e) async{
    CollectionReference collectionReference = FirebaseFirestore.instance.collection("Employee Table");
    Map<String, dynamic> data = <String, dynamic>{
      "First Name": a,
      "Last Name": b,
      "Email": c,
      "Contact Number": d,
      "Password":e
    };
    try{
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: c,
          password: e
      );
      Common_Toast().customtoast("Logged In Successfully");
      Navigator.of(context).push(MaterialPageRoute(builder: (context)=> demo_for_all()));
    } on FirebaseAuthException catch(e){
      if(e.code == "ERROR_USER_DISABLED") {
        Common_Toast().customtoast("The account with which the email is associated exists but has been disabled.");
      } else if(e.code == "ERROR_USER_NOT_FOUND") {
        Common_Toast().customtoast("No account could be found that matches the specified email address.");
      } else if(e.code == "ERROR_EMAIL_ALREADY_IN_USE ") {
        Common_Toast().customtoast("User is attempting to create a new account, or change the email address for an existing account that is already in use by another account. ");
      } else if(e.code == "FirebaseAuthWeakPasswordException") {
        Common_Toast().customtoast("the password specified during an account creation or password update operation is insufficiently strong.");
      }
    } catch (e){
      print(e);
      Common_Toast().customtoast(e.toString());
    }

    Common_Toast().customtoast("Employee added");
    collectionReference.doc().set(data).whenComplete(() =>
        print('Post Added')).
    catchError((onError)  =>
        print("Failed to add user: $onError"));


      }
    // await FirebaseAuth.instance.createUserWithEmailAndPassword(
    //     email: c,
    //     password: e
    // );
    // print("passed create");
    // await FirebaseAuth.instance.signInWithEmailAndPassword(
    //     email: c,
    //     password: e
    // );
    // print("passed signin");
    // Navigator.of(context).push(MaterialPageRoute(builder: (context)=> demo_for_all()));
    // Future login_user(String email, String password) async{
    //   try{
    //     await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
    //     Common_Toast().customtoast("Logged In Succesfully");
    //     Navigator.of(context).push(MaterialPageRoute(builder: (context)=> demo_for_all()));
    //   } on FirebaseAuthException catch(e){
    //     if(e.code == "ERROR_USER_DISABLED")
    //       Common_Toast().customtoast("The account with which the email is associated exists but has been disabled.");
    //     else if(e.code == "ERROR_USER_NOT_FOUND")
    //       Common_Toast().customtoast("No account could be found that matches the specified email address.");
    //     else if(e.code == "ERROR_EMAIL_ALREADY_IN_USE ")
    //       Common_Toast().customtoast("User is attempting to create a new account, or change the email address for an existing account that is already in use by another account. ");
    //     else if(e.code == "FirebaseAuthWeakPasswordException")
    //       Common_Toast().customtoast("the password specified during an account creation or password update operation is insufficiently strong.");
    //   } catch (e){
    //     print(e);
    //     Common_Toast().customtoast(e.toString());
    //   }
    // }

  //}
  var f_name_controller = TextEditingController();
  var l_name_controller = TextEditingController();
  var email_controller = TextEditingController();
  var contact_num_controller = TextEditingController();
  var pass_controller = TextEditingController();
  var confirm_pass_controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    bool is_phoneverified = false;
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
                    )
                ),
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
                    )
                ),
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
                    )
                ),
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
                    )
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                controller: pass_controller,
                obscureText: true,
                decoration: const InputDecoration(
                    icon: Icon(Icons.password_rounded),
                    labelText: "Enter Password",
                    hintText: "********",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    )
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                controller: confirm_pass_controller,
                obscureText: true,
                decoration: const InputDecoration(
                    icon: Icon(Icons.password_rounded),
                    labelText: "Confirm Password",
                    hintText: "********",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    )
                ),
              ),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: (){
                  // if(f_name_controller.toString().isEmpty && l_name_controller.toString().isEmpty && email_controller.toString().isEmpty && contact_num_controller.toString().isEmpty && pass_controller.toString().isEmpty && confirm_pass_controller.toString().isEmpty){
                  //   Common_Toast().customtoast("Any field cannot be blank");}
                  // else if(pass_controller!= confirm_pass_controller){ Common_Toast().customtoast("Password does not match");}
                  //Navigator.of(context).push(MaterialPageRoute(builder: (context)=> demo_for_all()));
                  add_employee(f_name_controller.text, l_name_controller.text, email_controller.text, contact_num_controller.text, pass_controller.text);
                },child: Text("Register"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
