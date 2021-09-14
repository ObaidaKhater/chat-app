import 'package:flutter/cupertino.dart';

class RegisterRequest {
  String id;
  String fName;
  String lName;
  String email;
  String password;
  String country;
  String city;
  String imageUrl;

  RegisterRequest({
    @required this.id,
    @required this.email,
    @required this.password,
    @required this.fName,
    @required this.lName,
    @required this.country,
    @required this.city,
    @required this.imageUrl,
  });

  toMap() {
    return {
      'id': this.id,
      'email': this.email,
      'fName': this.fName,
      'lName': this.lName,
      'city': this.city,
      'country': this.country,
      'imageUrl': this.imageUrl,
    };
  }
}
