import 'package:flutter/material.dart';

class UserModel {
  String id;
  String fName;
  String lName;
  String email;
  String city;

  UserModel({
    @required this.id,
    @required this.email,
    @required this.fName,
    @required this.lName,
    @required this.city,
  });

  UserModel.fromMap(Map map) {
    this.id = map['id'];
    this.email = map['email'];
    this.fName = map['fName'];
    this.lName = map['lName'];
    this.city = map['city'];
  }

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
