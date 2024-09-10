class Patient {
  int? id;
  String? firstName;
  String? lastName;
  int? age;
  String? _healthCondition;
  int? severity; 

  Patient.withId(int id,String? firstName, String? lastName, int? age, String? healthStatus, int? severity) {
    this.id= id;
    this.firstName = firstName;
    this.lastName = lastName;
    this.age = age;
    this.severity = severity;
 
  }

Patient(String? firstName, String? lastName, int? age, String? healthStatus, int? severity) {
    this.firstName = firstName;
    this.lastName = lastName;
    this.age = age;
    this.severity = severity;
 
  }
  Patient.withoutinfo(){
    
  }
  String get gethealthCondition {
    String messaj ="";
    if (severity != null) {
      if (severity! >= 8) {
        messaj = "Critical";
      } else if (severity! >= 5) {
        messaj= "Moderate";
      } else {
        messaj= "Stable";
      }
    }
    return messaj;
  }
}
