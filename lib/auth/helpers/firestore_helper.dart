import 'package:chat_app/auth/models/register_request.dart';
import 'package:chat_app/auth/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FireStoreHelper {
  FireStoreHelper._();

  static FireStoreHelper fireStoreHelper = FireStoreHelper._();

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  addUserToFirestore(RegisterRequest registerRequest) async {
    try {
      await firestore
          .collection('Users')
          .doc(registerRequest.id)
          .set(registerRequest.toMap());
    } catch (e) {}
  }

  Future<UserModel> getUserFromFireStore(String idUser) async {
    DocumentSnapshot documentSnapshot =
        await firestore.collection('Users').doc(idUser).get();
    UserModel userModel = UserModel.fromMap(documentSnapshot.data());
    return userModel;
  }

  Future<List<UserModel>> getAllUsersFromFireStore() async {
    QuerySnapshot querySnapshot = await firestore.collection('Users').get();
    return querySnapshot.docs
        .map((element) => UserModel.fromMap(element.data()))
        .toList();
  }
}
