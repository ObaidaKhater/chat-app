import 'package:flutter/cupertino.dart';

class ChatRequest {
  String myId;
  String anotherUserId;

  ChatRequest({@required this.myId, @required this.anotherUserId});

  ChatRequest.fromMap(Map<String, dynamic> map) {
    this.myId = map['users'][0];
    this.anotherUserId = map['users'][1];
  }

  toMap() {
    return {
      'users': [this.myId, this.anotherUserId]
    };
  }
}
