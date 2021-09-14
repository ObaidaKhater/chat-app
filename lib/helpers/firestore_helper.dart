import 'package:chat_app/helpers/functions_helper.dart';
import 'package:chat_app/models/chat_request.dart';
import 'package:chat_app/models/country_model.dart';
import 'package:chat_app/models/massage_model.dart';
import 'package:chat_app/models/register_request.dart';
import 'package:chat_app/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

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

  Future<List<CountryModel>> getAllCountiesFromFireStore() async {
    try {
      QuerySnapshot querySnapshot = await FireStoreHelper
          .fireStoreHelper.firestore
          .collection('Countries')
          .get();
      return querySnapshot.docs
          .map((element) => CountryModel.fromMap(element.data()))
          .toList();
    } catch (e) {
      // print (e);
      return null;
    }
  }

  updateUserFromFireStore(UserModel userModel) async {
    try {
      await FireStoreHelper.fireStoreHelper.firestore
          .collection('Users')
          .doc(userModel.id)
          .update(userModel.toMap());
    } catch (e) {
      // print (e);
    }
  }

  addNewChatFromTwoUserInFireStore(ChatRequest chatRequest) async {
    try {
      String convId = FunctionsHelper.functionsHelper
          .getConversationID(chatRequest.myId, chatRequest.anotherUserId);
      await firestore.collection('Chats').doc(convId).set(chatRequest.toMap());
    } catch (e) {}
  }

  Future<List<UserModel>> getUsersChatFromMeFromFireStore(String myId) async {
    try {
      List<UserModel> users = [];
      QuerySnapshot querySnapshot = await firestore
          .collection('Chats')
          .where('users', arrayContains: myId)
          .get();
      for (var item in querySnapshot.docs) {
        ChatRequest chatRequest = ChatRequest.fromMap(item.data());
        UserModel userModel;
        (myId == chatRequest.myId)
            ? userModel = await getUserFromFireStore(chatRequest.anotherUserId)
            : userModel = await getUserFromFireStore(chatRequest.myId);
        users.add(userModel);
      }
      return users;
    } catch (e) {
      return [];
    }
  }

  Stream<QuerySnapshot<Map<String, dynamic>>>
      getAllMassagesFromTowUserFromFireStore(ChatRequest chatRequest) {
    String convId = FunctionsHelper.functionsHelper
        .getConversationID(chatRequest.myId, chatRequest.anotherUserId);
    return firestore
        .collection('Chats')
        .doc(convId)
        .collection('Massages')
        .orderBy('dataTime', descending: true)
        .snapshots();
  }

  addMassageToFireStore(
      ChatRequest chatRequest, MassageModel massageModel) async {
    try {
      String convId = FunctionsHelper.functionsHelper
          .getConversationID(chatRequest.myId, chatRequest.anotherUserId);
      await firestore
          .collection('Chats')
          .doc(convId)
          .collection('Massages')
          .add(massageModel.toMap());
    } catch (e) {}
  }
}
