// ignore_for_file: must_be_immutable

import 'package:btk_flutter/models/Patient.dart';
import 'package:btk_flutter/validation/patient_validator.dart';
import 'package:flutter/material.dart';

class PatientEdit extends StatefulWidget {
  late Patient selectedPatient;
  PatientEdit(Patient selectedPatient) {
    this.selectedPatient = selectedPatient;
  }
  @override
  State<StatefulWidget> createState() {
    return _PatientEditState(selectedPatient);
  }
}

class _PatientEditState extends State with PatientValidationMixin {
  late Patient selectedPatient;
  _PatientEditState(Patient selectedPatient) {
    this.selectedPatient = selectedPatient;
  }
  int _severityValue = 1;
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Edit Patient", style: TextStyle(color: Colors.white)),
          backgroundColor: const Color.fromARGB(255, 42, 146, 160),
        ),
        body: Container(
            margin: EdgeInsets.all(20.0),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  buildFirstNameField(),
                  buildLastNameField(),
                  buildAgeField(),
                  buildSeverityStepper(),
                  SizedBox(
                    height: 30.0,
                  ),
                  buildSaveButton()
                ],
              ),
            )));
  }

  Widget buildFirstNameField() {
    return TextFormField(
            initialValue: selectedPatient.firstName,

      decoration: InputDecoration(
        labelText: "First Name",
        hintText: "Example: Anas",
      ),
      onSaved: (String? value) {
        selectedPatient.firstName = value;
      },
      validator: validateFirstName,
    );
  }

  Widget buildLastNameField() {
    return TextFormField(
      initialValue: selectedPatient.lastName,
        decoration: InputDecoration(
            labelText: "Last Name", hintText: "Example: AL-Maqtari"),
        onSaved: (String? value) {
          selectedPatient.lastName = value;
        },
        validator: validateLastName);
  }

  Widget buildAgeField() {
    return TextFormField(
        initialValue: selectedPatient.age.toString(),
        decoration: InputDecoration(labelText: "Age", hintText: "Example: 25"),
        keyboardType: TextInputType.number,
        onSaved: (String? value) {
          selectedPatient.age =
              value != null && value.isNotEmpty ? int.tryParse(value) : null;
        },
        validator: validateAge);
  }

  Widget buildSeverityStepper() {
    return TextFormField(
        initialValue: selectedPatient.severity.toString(),
        decoration: InputDecoration(labelText: "Severity", hintText: "1-10"),
        keyboardType: TextInputType.number,
        onSaved: (String? value) {
          selectedPatient.severity =
              value != null && value.isNotEmpty ? int.tryParse(value) : null;
        },
        validator: validateSeverity);
  }

  Widget buildSaveButton() {
    return ElevatedButton(
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text(
          "Save",
          style: TextStyle(color: Colors.white),
        ),
        SizedBox(
          width: 5.0,
        ),
        Icon(
          Icons.save,
          color: Colors.white,
        )
      ]),
      style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
      onPressed: () {
        if (formKey.currentState!.validate()) {
          formKey.currentState!.save();
          showInfo(context);
        } else {
          showErroSnak(context);
        }
      },
    );
  }

  void showInfo(BuildContext context) {
    var messaj = '${selectedPatient.firstName!} ${selectedPatient.lastName!}';
    final snackBar = SnackBar(
      content: Text("Successfully edited: $messaj"),
      backgroundColor: const Color.fromARGB(255, 61, 128, 64),
      duration: Duration(seconds: 3),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    Navigator.pop(context);
  }

  void showErroSnak(BuildContext context) {
    var messaj = "Pleas enter correct information!!";
    final snackBar = SnackBar(
      content: Text(messaj),
      backgroundColor: const Color.fromARGB(255, 192, 68, 59),
      duration: Duration(seconds: 3),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
