import 'dart:io';
import 'package:audioplayers/audioplayers.dart';
import 'package:chat_app/helpers/auth_helper.dart';
import 'package:chat_app/helpers/firestorage_helper.dart';
import 'package:chat_app/helpers/firestore_helper.dart';
import 'package:chat_app/models/chat_request.dart';
import 'package:chat_app/models/country_model.dart';
import 'package:chat_app/models/massage_model.dart';
import 'package:chat_app/models/register_request.dart';
import 'package:chat_app/models/user_model.dart';
import 'package:chat_app/ui/auth_pages/auth_main_page.dart';
import 'package:chat_app/ui/chat_page/chat_page.dart';
import 'package:chat_app/ui/main_page/main_page.dart';
import 'package:chat_app/services/custom_dialoug.dart';
import 'package:chat_app/services/routes_helper.dart';
import 'package:chat_app/services/shared_preferences_helper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:record_mp3/record_mp3.dart';

class AuthProvider extends ChangeNotifier {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController fNameController = TextEditingController();
  TextEditingController lNameController = TextEditingController();
  TabController tabController;
  UserModel user;
  List<CountryModel> countries;
  List<dynamic> cities;
  CountryModel countryValue;
  String cityValue;
  File imageFile;
  File updateImageFile;
  List<UserModel> users;
  List<UserModel> chatsUsersFromMe;
  UserModel anotherUser;
  TextEditingController massageController = TextEditingController();
  ScrollController scrollController = ScrollController();

  AuthProvider() {
    getAllCountries();
  }

  register() async {
    UserCredential userCredential = await AuthHelper.authHelper
        .signup(emailController.text, passwordController.text);
    // upload user image
    String imageUrl;
    if (imageFile != null) {
      imageUrl =
          await FireStorageHelper.fireStorageHelper.uploadImage(imageFile);
    }
    RegisterRequest registerRequest = RegisterRequest(
      id: userCredential.user.uid,
      email: emailController.text,
      password: passwordController.text,
      fName: fNameController.text,
      lName: lNameController.text,
      country: countryValue.name,
      city: cityValue,
      imageUrl: imageUrl,
    );
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
    bool isVerifiedEmail = AuthHelper.authHelper.checkEmailVerification();
    if (isVerifiedEmail) {
      RouteHelper.routeHelper.pushReplacementNamed(MainPage.routeName);
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
    RouteHelper.routeHelper.pushReplacementNamed(AuthMainPage.routeName);
  }

  resetPassword() {
    AuthHelper.authHelper.resetPassword(emailController.text);
    resetControllers();
  }

  resetControllers() {
    emailController.clear();
    passwordController.clear();
    fNameController.clear();
    lNameController.clear();
    imageFile = null;
  }

  checkIsLoginUser() {
    bool isLogin = AuthHelper.authHelper.checkIsLogin();
    if (isLogin)
      RouteHelper.routeHelper.pushReplacementNamed(MainPage.routeName);
    else
      RouteHelper.routeHelper.pushReplacementNamed(AuthMainPage.routeName);
  }

  getCurrentUser() async {
    String userId = AuthHelper.authHelper.getCurrentUserId();
    user = await FireStoreHelper.fireStoreHelper.getUserFromFireStore(userId);
    notifyListeners();
  }

  getAllCountries() async {
    countries =
        await FireStoreHelper.fireStoreHelper.getAllCountiesFromFireStore();
    selectCountry(countries.first);
  }

  selectCountry(CountryModel countryModel) {
    this.countryValue = countryModel;
    this.cities = countryModel.cities;
    selectCity(cities.first.toString());
    notifyListeners();
  }

  selectCity(dynamic city) {
    this.cityValue = city;
    notifyListeners();
  }

  selectImageFile() async {
    XFile xFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    imageFile = File(xFile.path);
    notifyListeners();
  }

  setDataToController() async {
    fNameController.text = user.fName;
    lNameController.text = user.lName;
  }

  changeFileImage() async {
    XFile xFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    updateImageFile = File(xFile.path);
    notifyListeners();
  }

  updateUser() async {
    String imageUrl;
    if (updateImageFile != null) {
      imageUrl = await FireStorageHelper.fireStorageHelper
          .uploadImage(updateImageFile);
    }
    UserModel userModel = (updateImageFile == null)
        ? UserModel(
            id: user.id,
            email: user.email,
            fName: fNameController.text.trim(),
            lName: lNameController.text.trim(),
            country: countryValue.name,
            city: cityValue,
            imageUrl: user.imageUrl)
        : UserModel(
            id: user.id,
            email: user.email,
            fName: fNameController.text.trim(),
            lName: lNameController.text.trim(),
            country: countryValue.name,
            city: cityValue,
            imageUrl: imageUrl);
    await FireStoreHelper.fireStoreHelper.updateUserFromFireStore(userModel);
    getCurrentUser();
    RouteHelper.routeHelper.back();
  }

  getAllUser() async {
    users = await FireStoreHelper.fireStoreHelper.getAllUsersFromFireStore();
    users.removeWhere((element) => element.id == user.id);
    notifyListeners();
  }

  buildChatFromTwoUsers(String anotherUserId) async {
    ChatRequest chatRequest =
        ChatRequest(myId: user.id, anotherUserId: anotherUserId);
    await FireStoreHelper.fireStoreHelper
        .addNewChatFromTwoUserInFireStore(chatRequest);
  }

  getAllChatsUsersFromMe() async {
    chatsUsersFromMe = await FireStoreHelper.fireStoreHelper
        .getUsersChatFromMeFromFireStore(user.id);
    notifyListeners();
  }

  goToChatPage(UserModel userModel) {
    anotherUser = userModel;
    RouteHelper.routeHelper.pushName(ChatPage.routeName);
  }

  getAllMassagesFromTowUser() {
    ChatRequest chatRequest =
        ChatRequest(myId: user.id, anotherUserId: anotherUser.id);
    return FireStoreHelper.fireStoreHelper
        .getAllMassagesFromTowUserFromFireStore(chatRequest);
  }

  sendMassage() async {
    if (massageController.text.trim().isNotEmpty) {
      ChatRequest chatRequest = ChatRequest(
        myId: user.id,
        anotherUserId: anotherUser.id,
      );
      MassageModel massageModel = MassageModel(
        content: massageController.text.trim(),
        dateTime: Timestamp.now(),
        userSendId: user.id,
        typeMassage: TypeMassage.Text,
      );
      await FireStoreHelper.fireStoreHelper
          .addMassageToFireStore(chatRequest, massageModel);

      massageController.clear();
    }
  }

  sendImageToChat() async {
    XFile xFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    File imageFile = File(xFile.path);
    String imageUrl = await FireStorageHelper.fireStorageHelper
        .uploadImage(imageFile, 'chats');
    MassageModel massageModel = MassageModel(
      typeMassage: TypeMassage.Image,
      dateTime: Timestamp.now(),
      userSendId: user.id,
      content: imageUrl,
    );
    ChatRequest chatRequest = ChatRequest(
      myId: user.id,
      anotherUserId: anotherUser.id,
    );
    await FireStoreHelper.fireStoreHelper
        .addMassageToFireStore(chatRequest, massageModel);
    massageController.clear();
  }
}
