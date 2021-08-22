import 'package:flutter/cupertino.dart';

class RegisterRequest {
  String id;
  String fName;
  String lName;
  String email;
  String password;
  String city;

  RegisterRequest({
    @required this.id,
    @required this.email,
    @required this.fName,
    @required this.lName,
    @required this.city,
  });

  toMap() {
    return {
      'id': this.id,
      'email': this.email,
      'fName': this.fName,
      'lName': this.lName,
      'city': this.city,
    };
  }
}
