import 'package:employee_manegement/demo4all.dart';
import 'package:employee_manegement/national/flutter_toast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class login_page extends StatefulWidget{
  @override
  _login_state createState() => _login_state();
}

class _login_state extends State<login_page> {
  Future login_user(String email, String password) async{
    try{
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
      Common_Toast().customtoast("Logged In Succesfully");
      Navigator.of(context).push(MaterialPageRoute(builder: (context)=> demo_for_all()));
    } on FirebaseAuthException catch(e){
      if(e.code == "ERROR_USER_DISABLED")
        Common_Toast().customtoast("The account with which the email is associated exists but has been disabled.");
      else if(e.code == "ERROR_USER_NOT_FOUND")
        Common_Toast().customtoast("No account could be found that matches the specified email address.");
      else if(e.code == "ERROR_EMAIL_ALREADY_IN_USE ")
        Common_Toast().customtoast("User is attempting to create a new account, or change the email address for an existing account that is already in use by another account. ");
      else if(e.code == "FirebaseAuthWeakPasswordException")
        Common_Toast().customtoast("the password specified during an account creation or password update operation is insufficiently strong.");
    } catch (e){
      print(e);
      Common_Toast().customtoast(e.toString());
    }
  }
  String img = 'assets/img.jpg';
  TextEditingController email_controller = TextEditingController();
  TextEditingController password_controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(
              controller: email_controller,
              decoration: const InputDecoration(
                icon: Icon(Icons.attach_email),
                labelText: "Enter Email",
                hintText: "abc@xyz.com",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                )
              ),
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              obscureText: true,
              controller: password_controller,
              decoration: const InputDecoration(
                icon: Icon(Icons.password),
                labelText: "Enter Password",
                hintText: "********",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                )
              ),
            ),
            ElevatedButton(
              onPressed: (){
                login_user(email_controller.text, password_controller.text);
              },
              child: Text("Login"),
            ),
          ],
        ),
      )
        );
  }
}