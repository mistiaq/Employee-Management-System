import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'SignUp_SignIn_Login/login_page.dart';
import 'SignUp_SignIn_Login/sign_up.dart';
import 'demo4all.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _mainstate createState() => _mainstate();
}

class _mainstate extends State<MyApp>{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Container(
              height: 50,
            width: 200,
              child: Card(
                elevation: 2,
                color: Colors.grey,
                child: ElevatedButton(
                    onPressed: (){
                      setState(() {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>login_page()));
                      });
                    },
                    child: Center(
                      child: Text("Admin?"),
                    )),
              ),
            ),
          ),
          Center(
            child: Container(
              height: 50,
            width: 200,
              color: Colors.white,
              child: Card(
                elevation: 2,
                color: Colors.grey,
                child: ElevatedButton(
                    onPressed: (){
                      setState(() {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>sign_up()));
                      });
                    },
                    child: Center(
                      child: Text("Employee?"),
                    )),
              ),
            ),
          ),
        ],
      )
    );
  }

}
