// ignore_for_file: prefer_const_constructors

import 'package:btk_flutter/models/Patient.dart';
import 'package:btk_flutter/screens/patient_add.dart';
import 'package:btk_flutter/screens/patient_edit.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: MyApp(),
    debugShowCheckedModeBanner: false,
  ));
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String messaj = "";
  Patient? selectedPatient;
  List<Patient> patients = [
    Patient.withId(1, "Anas", "Almaqtari", 30, "Stable", 3),
    Patient.withId(2, "Kerem", "Baris", 45, "Critical", 9),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Patient Tracker",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color.fromARGB(255, 42, 146, 160),
      ),
      body: buildBody(context),
    );
  }

  void mesajGoster(BuildContext context, String mesaj) {
    var alert = AlertDialog(
      title: Text("Operation result"),
      content: Text(mesaj),
    );
    showDialog(
      context: context,
      builder: (BuildContext context) => alert,
    );
  }

  Widget buildBody(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: patients.length,
            itemBuilder: (BuildContext context, int index) {
              bool isSelected = selectedPatient == patients[index];
              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedPatient = patients[index];
                  });
                },
                child: Container(
                    color: isSelected ? Colors.blue[100] : Colors.transparent,
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(
                            "https://avatars.githubusercontent.com/u/91754070?v=4"),
                      ),
                      title: Text(patients[index].firstName! +
                          " " +
                          patients[index].lastName!),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Age: " + patients[index].age!.toString()),
                          Text("Severity: " +
                              patients[index].severity!.toString()),
                          Row(
                            children: [
                              Text("Health Condition: "),
                              Text(
                                patients[index].gethealthCondition!,
                                style: TextStyle(
                                  color: getConditionColor(
                                      patients[index].gethealthCondition!),
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                      trailing:
                          buildStatusIcon(patients[index].gethealthCondition!),
                    )),
              );
            },
          ),
        ),
        Text(
          selectedPatient != null
              ? "Selected Patient: ${selectedPatient!.firstName} ${selectedPatient!.lastName} "
              : "No patient selected",
        ),
        Row(
          children: [
            SizedBox(width: 10),
            Flexible(
              fit: FlexFit.tight,
              flex: 1,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PatientAdd(patients)),
                  ).then((_) {
                    setState(() {});
                  });
                },
                child: Row(
                  children: [
                    Icon(Icons.add_circle_outline),
                    SizedBox(width: 5.0),
                    Text("New Patient"),
                  ],
                ),
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white),
              ),
            ),
            SizedBox(width: 10),
            Flexible(
              fit: FlexFit.tight,
              flex: 1,
              child: ElevatedButton(
                onPressed: () {
                  if (selectedPatient == null) {
                    showSelectedError();
                  } else {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                                PatientEdit(selectedPatient!))).then((_) {
                      setState(() {});
                    });
                  }
                },
                child: Row(
                  children: [
                    Icon(Icons.update),
                    SizedBox(width: 5.0),
                    Text("Edit Patient"),
                  ],
                ),
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white),
              ),
            ),
            SizedBox(width: 10),
            Flexible(
              fit: FlexFit.tight,
              flex: 1,
              child: ElevatedButton(
                onPressed: () {
                  if (selectedPatient == null) {
                    showSelectedError();
                  } else {
                    setState(() {
                      patients.remove(selectedPatient);
                    });
                    var messaj =
                        '${selectedPatient?.firstName} ${selectedPatient?.lastName} başarıyla silindi';
                    mesajGoster(context, messaj);
                  }
                },
                child: Row(
                  children: [
                    Icon(Icons.delete_outline_outlined),
                    SizedBox(width: 5.0),
                    Text("Delet Patient"),
                  ],
                ),
                style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white, backgroundColor: Colors.red),
              ),
            )
          ],
        )
      ],
    );
  }

  Color getConditionColor(String severityLevel) {
    if (severityLevel == "Critical") {
      return Colors.red;
    } else if (severityLevel == "Moderate") {
      return Colors.orange;
    } else if (severityLevel == "Stable") {
      return Colors.green;
    } else {
      return Colors.grey;
    }
  }

  TextStyle customTextStyle() {
    return TextStyle(
      color: Colors.blue[700],
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
      decoration: TextDecoration.underline,
      decorationColor: Colors.blue[200],
      decorationStyle: TextDecorationStyle.dashed,
      fontFamily: 'Roboto',
      shadows: [
        Shadow(
          offset: Offset(2.0, 2.0),
          blurRadius: 3.0,
          color: Colors.grey,
        ),
      ],
    );
  }

  Widget buildStatusIcon(String? severityLevel) {
    if (severityLevel == "Critical") {
      return Icon(
        Icons.warning,
        color: Colors.red,
      );
    } else if (severityLevel == "Moderate") {
      return Icon(
        Icons.error_outline,
        color: Colors.orange,
      );
    } else if (severityLevel == "Stable") {
      return Icon(
        Icons.check_circle,
        color: Colors.green,
      );
    } else {
      return Icon(
        Icons.help_outline,
        color: Colors.grey,
      );
    }
  }

  void showSelectedError() {
    var messaj = "You must select petient first!!";
    final snackBar = SnackBar(
    content: Row(
      children: [
        Icon(Icons.error, color: Colors.white), 
        SizedBox(width: 8), 
        Text(messaj),
      ],
    ),
    action: SnackBarAction(
      label: 'Close',
      onPressed: () {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
      },
    ),
    backgroundColor: Colors.red, 
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);

  }
}
