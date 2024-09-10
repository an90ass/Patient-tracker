import 'package:btk_flutter/models/Patient.dart';
import 'package:btk_flutter/validation/patient_validator.dart';
import 'package:flutter/material.dart';

class PatientAdd extends StatefulWidget {
  late List<Patient> patients;
  PatientAdd(List<Patient>patients) {
    this.patients=patients;

  }
  @override
  State<StatefulWidget> createState() {
    return _PatientAddState(patients);
  }
}

class _PatientAddState extends State with PatientValidationMixin {
  late List<Patient> patients;
  _PatientAddState(List<Patient>patients) {
    this.patients=patients;

  }
  var patient = Patient.withoutinfo();
  var formKey = GlobalKey<FormState>();
  @override
   int severity = 1;

  void _incrementSeverity() {
    setState(() {
      if (severity < 10) {
        severity++;
      }
    });
  }

  void _decrementSeverity() {
    setState(() {
      if (severity > 1) {
        severity--;
      }
    });
  }
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Add new Patient", style: TextStyle(color: Colors.white)),
          backgroundColor: const Color.fromARGB(255, 42, 146, 160),
        ),
        body: Container(
            margin: EdgeInsets.all(20.0),
            child: Form(
              key:formKey,
              child: Column(
                children: [
                  buildFirstNameField(),
                  buildLastNameField(),
                  buildAgeField(),
                  buildSeverityStepper(),
                  SizedBox(height: 30.0,),
                  buildSaveButton()
                ],
              ),
            )));
  }

  Widget buildFirstNameField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: "First Name",
        hintText: "Example: Anas",
      ),
      onSaved: (String? value) {
        patient.firstName = value;
      },
      validator: validateFirstName,
    );
  }

  Widget buildLastNameField() {
    return TextFormField(
        decoration: InputDecoration(
            labelText: "Last Name", hintText: "Example: AL-Maqtari"),
        onSaved: (String? value) {
          patient.lastName = value;
        },
        validator: validateLastName);
  }

  Widget buildAgeField() {
    return TextFormField(
        decoration: InputDecoration(labelText: "Age", hintText: "Example: 25"),
        keyboardType: TextInputType.number,
        onSaved: (String? value) {
          patient.age =
              value != null && value.isNotEmpty ? int.tryParse(value) : null;
        },
        validator: validateAge);
  }

 Widget buildSeverityStepper() {
  return TextFormField(
        decoration: InputDecoration(labelText: "Severity", hintText: "1-10"),
        keyboardType: TextInputType.number,
        onSaved: (String? value) {
          patient.severity =
              value != null && value.isNotEmpty ? int.tryParse(value) : null;
        },
        validator: validateSeverity);
 }
 
  Widget buildSaveButton() {
    return ElevatedButton(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
        Text("Save",style: TextStyle(color: Colors.white),),
        SizedBox(width: 5.0,),
        Icon(Icons.save,color: Colors.white,)       
      ]
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.green
      ),
      onPressed: (){
        if(formKey.currentState!.validate()){
          formKey.currentState!.save();
          patients.add(patient);
          showInfo(context);
        }
        else{
          showErroSnak(context);

        }
      },
    );
  }
  
void showInfo(BuildContext context) {
  var messaj = '${patient.firstName!} ${patient.lastName!}';
  final snackBar = SnackBar(
    content: Text("Successfully saved: $messaj"),
    backgroundColor: const Color.fromARGB(255, 61, 128, 64), 
    duration: Duration(seconds: 3),

  
  );

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
   Navigator.pop(context);
}

  void showErroSnak(BuildContext context) {
    var messaj ="Pleas enter correct information!!";
    final snackBar = SnackBar(
      content: Text(messaj),
      backgroundColor: const Color.fromARGB(255, 192, 68, 59), 
    duration: Duration(seconds: 3),

    );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);

  }

}
