import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:employee_manegement/national/flutter_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
      "Password":e,
    };
    Common_Toast().customtoast("Employee added");
    collectionReference.doc().set(data).whenComplete(() =>
        print('Post Added')).
    catchError((onError)=>
        print("Failed to add user: $onError"));
  }


  TextEditingController f_name_controller = TextEditingController();
  TextEditingController l_name_controller = TextEditingController();
  TextEditingController email_controller = TextEditingController();
  TextEditingController contact_num_controller = TextEditingController();
  TextEditingController verify_num_controller = TextEditingController();
  TextEditingController pass_controller = TextEditingController();
  TextEditingController confirm_pass_controller = TextEditingController();
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
              Row(
                children: [
                  Expanded(
                    flex: 4,
                    child:
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
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Expanded(
                    flex: 1,
                      child: ElevatedButton(
                        onPressed: (){},
                        child: Text("Verify"),
                      ),
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                controller: verify_num_controller,
                decoration: const InputDecoration(
                    icon: Icon(Icons.verified_rounded),
                    labelText: "OTP",
                    hintText: "*****",
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
            ],
          ),
        ),
      ),
    );
  }
}
