import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:webpointtracker/views/pointviewlist.dart';

import 'package:intl/intl.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:webpointtracker/views/spring_feed_calculator.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static final collectionReference = _firestore.collection("points");

  String dropdownValue = '1';
  DateTime now = DateTime.now();
  String formattedDate = "";

  TextEditingController _textEditingController = TextEditingController();

  @override
  void initState() {
    formattedDate = DateFormat('yyyy-MM-dd').format(now);
    _textEditingController.text = formattedDate;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(



        child:
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Create Point", style: TextStyle(fontSize: 22)),
                  Icon(
                    Icons.access_alarm_rounded,
                    size: 45,
                  ),
                ],
              ),

          Divider(height: 22, thickness: 2, color: Colors.blue),
          Row(

            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('choose Point value  ----> '),
              DropdownButton<String>(
                value: dropdownValue,
                icon: const Icon(Icons.arrow_downward),
                iconSize: 16,
                elevation: 32,
                style: const TextStyle(color: Colors.deepPurple),
                underline: Container(
                  height: 2,
                  color: Colors.deepPurpleAccent,
                ),
                onChanged: (String? newValue) {
                  setState(() {
                    dropdownValue = newValue!;
                  });
                },
                items: <String>['1', '1/2']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('choose Date  ----> '),
              ElevatedButton(
                  onPressed: () {
                    _selectDate(context);
                  },
                  child: Icon(Icons.calendar_today_rounded)),
            ],
          ),
          TextField(
            readOnly: true,
            textAlign: TextAlign.center,
            controller: _textEditingController,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: () {
                    setState(() {
                      addData(collectionReference, formattedDate,
                          dropdownValue, context);
                    });
                  },
                  child: Icon(Icons.save_sharp)),
              SizedBox(width: 10),

              ElevatedButton(
                  onPressed: () {
                    Get.toNamed("splashpage");
                  }, child: Icon(Icons.arrow_back)),
              SizedBox(width: 10),

            ],
          ),


              Text("Current points list",
                style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold),),
              Text("Long press on a selected date below to delete\n or click once to change selected date"),
              SizedBox(height: 20,),

          Divider(height: 22, thickness: 2, color: Colors.blue),
          Center(
            child: SizedBox(
              width: 400,
                height: 400,
                child: PointViewList()),
          ),
        ],
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    ));
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? d = await showDatePicker(
      //we wait for the dialog to return
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2021),
      lastDate: DateTime.now(),
    );
    if (d != null) //if the user has selected a date
      setState(() {
        // we format the selected date and assign it to the state variable
        now = d;
        formattedDate = DateFormat('yyyy-MM-dd').format(now);
        _textEditingController.text = formattedDate.toString();
      });
  }
}

//db crud

addData(CollectionReference collection, String formattedDate,
    String dropdownValue, BuildContext context) async {
  Map<String, dynamic> demodata = {
    "pointdate": formattedDate,
    "pointvalue": dropdownValue
  };
  await collection.add(demodata).then((value) {
    final snackBar = SnackBar(content: const Text('Point Created'));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  });
}
