import 'package:employee_manegement/national/Employee_list.dart';
import 'package:flutter/material.dart';

class _mainPage extends StatefulWidget {
  @override
  _mainPage_State createState() => _mainPage_State();
}
class _mainPage_State extends State<_mainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: SingleChildScrollView(
          child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width * 0.5,
            child: Column(
              children: [
                Row(children:[]),
                ElevatedButton(
                  onPressed: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=> Employee_list()));
                  },
                  child: Text("Add Employee"),
                )
              ],
            ),

          ),
        ),
      ),
    );
  }
}
