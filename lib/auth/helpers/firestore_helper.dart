import 'package:chat_app/auth/models/register_request.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FireStoreHelper {
  FireStoreHelper._();

  static FireStoreHelper fireStoreHelper = FireStoreHelper._();

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  saveUser(RegisterRequest registerRequest) async {
    await firestore.collection('Users').add(registerRequest.toMap());
  }
}
