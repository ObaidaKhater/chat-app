import 'package:chat_app/auth/helpers/auth_helper.dart';
import 'package:chat_app/auth/helpers/firestore_helper.dart';
import 'package:chat_app/auth/models/register_request.dart';
import 'package:chat_app/auth/models/user_model.dart';
import 'package:chat_app/auth/ui/auth_main_page.dart';
import 'package:chat_app/chats/home_page.dart';
import 'package:chat_app/services/routes_helper.dart';
import 'package:chat_app/services/shared_preferences_helper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController fNameController = TextEditingController();
  TextEditingController lNameController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TabController tabController;
  UserModel user;

  register() async {
    UserCredential userCredential = await AuthHelper.authHelper
        .signup(emailController.text, passwordController.text);
    RegisterRequest registerRequest = RegisterRequest(
        id: userCredential.user.uid,
        email: emailController.text,
        password: passwordController.text,
        fName: fNameController.text,
        lName: lNameController.text,
        city: cityController.text);
    await FireStoreHelper.fireStoreHelper.addUserToFirestore(registerRequest);
    await AuthHelper.authHelper.verifyEmail();
    await AuthHelper.authHelper.sigOut();
    tabController.animateTo(0);
    resetControllers();
  }

  signIn() async {
    UserCredential userCredential = await AuthHelper.authHelper
        .signIn(emailController.text, passwordController.text);
    UserModel userModel = await FireStoreHelper.fireStoreHelper
        .getUserFromFireStore(userCredential.user.uid);
    SPHelper.spHelper.saveCurrentUser(userModel);
    // bool isVerifiedEmail = AuthHelper.authHelper.checkEmailVerification();
    // if (isVerifiedEmail) {
    RouteHelper.routeHelper.pushReplacementNamed(HomePage.routeName);
    // } else {
    //   CustomDialog.customDialog.showCustomDialog(
    //       'You have to verify your email, press ok to send another email.',
    //       sendVerificationEmail);
    // }
    resetControllers();
  }

  sendVerificationEmail() async {
    AuthHelper.authHelper.verifyEmail();
  }

  signOut() {
    AuthHelper.authHelper.sigOut();
    SPHelper.spHelper.removeCurrentUser();
  }

  resetPassword() {
    AuthHelper.authHelper.resetPassword(emailController.text);
    resetControllers();
  }

  resetControllers() {
    emailController.clear();
    passwordController.clear();
  }

  checkIsLoginUser() {
    bool isLogin = AuthHelper.authHelper.checkIsLogin();
    if (isLogin)
      RouteHelper.routeHelper.pushReplacementNamed(HomePage.routeName);
    else
      RouteHelper.routeHelper.pushReplacementNamed(AuthMainPage.routeName);
  }

  getCurrentUser() async {
    String userId = AuthHelper.authHelper.getCurrentUserId();
    user = await FireStoreHelper.fireStoreHelper.getUserFromFireStore(userId);
    notifyListeners();
  }
}
