import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class daily_attendence extends StatefulWidget {
  @override
  _attendenceState createState() => _attendenceState();
}
class _attendenceState extends State<daily_attendence> {
 getText() {
    DateTime now = DateTime.now();
    showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: now.hour, minute: now.minute),
    ).then((TimeOfDay? value) {
      try {
        if (value != null) {
          final String x = value.format(context);
          return x;
        } else
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text("Select Time First")));
      } on Exception catch (e) {
        print(e);
        return null;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.07,
              width: MediaQuery.of(context).size.width * 0.9,
              margin: EdgeInsets.all(15),
              // ElevatedButton(
              //   onPressed: () {
              //     showDialog(
              //         context: context,
              //         builder: (BuildContext build){
              //           return AlertDialog(
              //               backgroundColor: Colors.teal,
              //               shape: RoundedRectangleBorder(
              //                   borderRadius: BorderRadius.circular(22.0)
              //               ),
              //               title: const Center(
              //                 child: Text("Opps No Internet"),
              //               ),
              //               actions: [
              //                 Center(
              //                   child: TextButton(
              //                     onPressed: (){
              //                       SystemNavigator.pop();
              //                     },
              //                     child: Text('Exit'),
              //                   ),
              //                 )
              //               ]
              //           );
              //         }
              //     );
              //   }, child: Text("Alert Dialogue"),
              // ),
              child: Card(
                elevation: 3,
                child: ElevatedButton(
                  onPressed: () {
                    getText();
                  },
                  child: const Text("Select Current Time"),
                ),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Text(getText()),
            SizedBox(
              height: 50,
            ),
            Container(
              margin: EdgeInsets.all(15),
              height: MediaQuery.of(context).size.height * 0.07,
              width: MediaQuery.of(context).size.width * 0.9,
              child: Card(
                elevation: 3,
                child: ElevatedButton(
                  onPressed: () {
                    showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime.now(),
                    ).then((DateTime? value) {
                      if (value != null) {
                        final DateFormat formatter = DateFormat('yyyy-MM-dd');
                        final String formatted = formatter.format(value);

                        ScaffoldMessenger.of(context)
                            .showSnackBar(SnackBar(content: Text(formatted)));
                      }
                    });
                  },
                  child: const Text("Select Today's Date"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
