mixin PatientValidationMixin {
  String? validateFirstName(String? firstName) {
    if (firstName == null || firstName.length < 2) {
      return "Name must be at least two characters";
    }
    return null;
  }
    String? validateLastName(String? lastName) {
    if (lastName == null || lastName.length < 2) {
      return "LastName must be at least two characters";
    }
    return null;
  }
  String? validateAge(String? value) {
  if (value == null || value.isEmpty) {
    return "Age cannot be null";
  }
  
  int? age = int.tryParse(value);
  if (age == null || age>150) {
    return "Please enter a valid number";
  }

  if (age < 0) {
    return "Age cannot be negative";
  }

  return null; 
}
String? validateSeverity(String? value) {
  if (value == null || value.isEmpty) {
    return "Age cannot be null";
  }
  
  int? severity = int.tryParse(value);
  if (severity == null || severity>10) {
    return "Please enter a valid number between 1-10";
  }

  if (severity < 0) {
    return "Severity cannot be negative";
  }

  return null; 
}
}
