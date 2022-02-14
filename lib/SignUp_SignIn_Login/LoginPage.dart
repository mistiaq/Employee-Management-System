import 'package:employee_manegement/Employee/Home/Home.dart';
import 'package:employee_manegement/SignUp_SignIn_Login/SignUp.dart';
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
      Common_Toast().customtoast("Logged In Succesfully", Duration(milliseconds: 400));
      Navigator.of(context).push(MaterialPageRoute(builder: (context)=> home()));
    } on FirebaseAuthException catch(e){    Common_Toast().customtoast(e.toString(), Duration(milliseconds: 400));
    }
  }
  TextEditingController email_controller = TextEditingController();
  TextEditingController password_controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment:CrossAxisAlignment.center,
                children: [
                  Text("Dont have an account?"),
                  TextButton(
                    onPressed: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=> sign_up()));
                    },
                    child: Text("Sign Up", style: TextStyle(decoration: TextDecoration.underline)),
                  )
                ],
              ),
              ElevatedButton(
                onPressed: (){
                  login_user(email_controller.text, password_controller.text);
                },
                child: Text("Login"),
              ),
            ],
          ),
        ),
      )
        );
  }
}