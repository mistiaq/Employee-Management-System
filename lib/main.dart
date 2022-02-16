import 'dart:async';
import 'package:employee_manegement/SignUp_SignIn_Login/LoginPage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';
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

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SplashScreen(),
    );
  }
}


 class SplashScreen extends StatefulWidget{
  @override
   _splashState createState() => _splashState();
}



class _splashState extends State<SplashScreen>{
  @override
  void initState(){
    Timer(Duration(seconds: 3), openOnBoard);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          alignment: Alignment.center,
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Image.asset(
            "assets/images/logo.jpg",
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
  void openOnBoard(){
    Navigator.of(context).push(MaterialPageRoute(builder: (context)=> login_page()));
  }

}






















//
// class MyApp extends StatefulWidget {
//   @override
//   _mainstate createState() => _mainstate();
// }
//
// class _mainstate extends State<MyApp>{
//   @override
//   Widget build(BuildContext context){
//     return Scaffold(
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           Center(
//             child: Container(
//               height: 50,
//             width: 200,
//               child: Card(
//                 elevation: 2,
//                 color: Colors.grey,
//                 child: ElevatedButton(
//                     onPressed: (){
//                       setState(() {
//                         Navigator.of(context).push(MaterialPageRoute(builder: (context)=>login_page()));
//                       });
//                     },
//                     child: Center(
//                       child: Text("Admin?"),
//                     )),
//               ),
//             ),
//           ),
//           Center(
//             child: Container(
//               height: 50,
//             width: 200,
//               color: Colors.white,
//               child: Card(
//                 elevation: 2,
//                 color: Colors.grey,
//                 child: ElevatedButton(
//                     onPressed: (){
//                       setState(() {
//                         Navigator.of(context).push(MaterialPageRoute(builder: (context)=>login_page()));
//                         // Navigator.of(context).push(MaterialPageRoute(builder: (context)=> home()));
//                       });
//                     },
//                     child: Center(
//                       child: Text("Employee?"),
//                     )),
//               ),
//             ),
//           ),
//         ],
//       )
//     );
//   }
//
// }
