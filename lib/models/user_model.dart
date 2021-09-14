import 'package:flutter/material.dart';

class UserModel {
  String id;
  String fName;
  String lName;
  String email;
  String country;
  String city;
  String imageUrl;

  UserModel({
    @required this.id,
    @required this.email,
    @required this.fName,
    @required this.lName,
    @required this.country,
    @required this.city,
    @required this.imageUrl,
  });

  UserModel.fromMap(Map map) {
    this.id = map['id'];
    this.email = map['email'];
    this.fName = map['fName'];
    this.lName = map['lName'];
    this.city = map['city'];
    this.country = map['country'];
    this.imageUrl = map['imageUrl'];
  }

  toMap() {
    return {
      'fName': this.fName,
      'lName': this.lName,
      'city': this.city,
      'country': this.country,
      'imageUrl': this.imageUrl,
    };
  }
}
