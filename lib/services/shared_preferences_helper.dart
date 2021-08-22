import 'dart:convert';

import 'package:chat_app/auth/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SPHelper {
  SPHelper._();

  static SPHelper spHelper = SPHelper._();
  SharedPreferences sharedPreferences;
  final String currentUserKey = 'currentUser';

  initSharedPreferences() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  saveCurrentUser(UserModel userModel) {
    sharedPreferences.setString(currentUserKey, json.encode(userModel.toMap()));
  }

  UserModel getCurrentUser() {
    String result = sharedPreferences.getString(currentUserKey);
    if (result == null) return null;
    Map resultMap = json.decode(result);
    UserModel userModel = UserModel.fromMap(resultMap);
    return userModel;
  }

  removeCurrentUser()async {
    await sharedPreferences.remove(currentUserKey);
  }
}
