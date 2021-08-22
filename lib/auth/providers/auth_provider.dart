import 'package:chat_app/Auth/helpers/auth_helper.dart';
import 'package:chat_app/auth/helpers/firestore_helper.dart';
import 'package:chat_app/auth/models/register_request.dart';
import 'package:chat_app/chats/home_page.dart';
import 'package:chat_app/services/custom_dialoug.dart';
import 'package:chat_app/services/routes_helper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController fNameController = TextEditingController();
  TextEditingController lNameController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TabController tabController;

  register() async {
    UserCredential userCredential = await AuthHelper.authHelper.signup(emailController.text, passwordController.text);
    RegisterRequest registerRequest = RegisterRequest(
        id: userCredential.user.uid,
        email: emailController.text,
        fName: fNameController.text,
        lName: lNameController.text,
        city: cityController.text);
    await FireStoreHelper.fireStoreHelper.saveUser(registerRequest);
    await
    AuthHelper.authHelper.verifyEmail();
    await AuthHelper.authHelper.sigOut();
    tabController.animateTo(0);
    resetControllers();
  }

  signIn() async {
    await AuthHelper.authHelper.signIn(
        emailController.text, passwordController.text);
    bool isVerifiedEmail = AuthHelper.authHelper.checkEmailVerification();
    if (isVerifiedEmail) {
      RouteHelper.routeHelper.pushReplacementNamed(HomePage.routeName);
    } else {
      CustomDialog.customDialog.showCustomDialog(
          'You have to verify your email, press ok to send another email.',
          sendVerificationEmail);
    }
    resetControllers();
  }

  sendVerificationEmail() async {
    AuthHelper.authHelper.verifyEmail();
  }

  signOut() {
    AuthHelper.authHelper.sigOut();
  }

  resetPassword() {
    AuthHelper.authHelper.resetPassword(emailController.text);
    resetControllers();
  }

  resetControllers() {
    emailController.clear();
    passwordController.clear();
  }
}
