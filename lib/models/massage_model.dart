import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

enum TypeMassage { Text, Image, Audio }

class MassageModel {
  String content;
  Timestamp dateTime;
  String userSendId;
  TypeMassage typeMassage;

  MassageModel({
    @required this.content,
    @required this.dateTime,
    @required this.userSendId,
    @required this.typeMassage,
  });

  MassageModel.fromMap(Map<String, dynamic> map) {
    this.content = map['content'];
    this.dateTime = map['dataTime'];
    this.userSendId = map['userSendId'];
    this.typeMassage = getTypeMassage(map['typeMassage']);
  }

  toMap() {
    return {
      'content': this.content,
      'dataTime': this.dateTime,
      'userSendId': this.userSendId,
      'typeMassage': setTypeMassage(),
    };
  }

  String setTypeMassage() {
    switch (this.typeMassage) {
      case TypeMassage.Text:
        return 'Text';
      case TypeMassage.Audio:
        return 'Audio';
      case TypeMassage.Image:
        return 'Image';
    }
  }

  TypeMassage getTypeMassage(String type) {
    switch (type) {
      case 'Text':
        return TypeMassage.Text;
      case 'Audio':
        return TypeMassage.Audio;
      case 'Image':
        return TypeMassage.Image;
    }
  }
}
