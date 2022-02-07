import 'package:employee_manegement/SignUp_SignIn_Login/employee_curved_nav.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'SignUp_SignIn_Login/login_page.dart';
import 'employee.dart/_attenedence.dart';
import 'employee.dart/home.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
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
                        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>employee_curved_nav()));
                        // Navigator.of(context).push(MaterialPageRoute(builder: (context)=>daily_attendence()));
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
