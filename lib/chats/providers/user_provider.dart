import 'package:chat_app/auth/helpers/firestore_helper.dart';
import 'package:chat_app/auth/models/user_model.dart';
import 'package:flutter/material.dart';
class UserProvider extends ChangeNotifier {
  List<UserModel> users;

  UserProvider() {
    getAllUsers();
  }

  getAllUsers() async {
    users = await FireStoreHelper.fireStoreHelper.getAllUsersFromFireStore();
    notifyListeners();
  }
}
