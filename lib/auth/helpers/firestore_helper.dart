import 'package:chat_app/auth/models/register_request.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FireStoreHelper {
  FireStoreHelper._();

  static FireStoreHelper fireStoreHelper = FireStoreHelper._();

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  addUserToFirestore(RegisterRequest registerRequest) async {
    await firestore
        .collection('Users')
        .doc(registerRequest.id)
        .set(registerRequest.toMap());
  }

  getUserFromFireStore(String idUser) async {
    var result = await firestore.collection('Users').doc(idUser).get();
    print(result);
  }
}
