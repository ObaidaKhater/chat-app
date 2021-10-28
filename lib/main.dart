
import 'package:chat_app/providers/auth_provider.dart';
import 'package:chat_app/providers/chat_provider.dart';
import 'package:chat_app/ui/auth_pages/auth_main_page.dart';
import 'package:chat_app/ui/auth_pages/register_page.dart';
import 'package:chat_app/ui/auth_pages/reset_password_page.dart';
import 'package:chat_app/ui/auth_pages/sign_in_page.dart';
import 'package:chat_app/ui/chat_page/chat_page.dart';
import 'package:chat_app/ui/chats_page.dart';
import 'package:chat_app/ui/main_page/main_page.dart';
import 'package:chat_app/ui/profile_page/profile_page.dart';
import 'package:chat_app/ui/splash_screen.dart';
import 'package:chat_app/ui/update_profile_page.dart';
import 'package:chat_app/ui/users_page.dart';
import 'package:chat_app/providers/bottom_bar_provider.dart';
import 'package:chat_app/services/routes_helper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<AuthProvider>(create: (context) => AuthProvider()),
      ChangeNotifierProvider<BottomBarProvider>(create: (context) => BottomBarProvider()),
      ChangeNotifierProvider<ChatProvider>(create: (context) => ChatProvider()),
    ],
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: RouteHelper.routeHelper.navKey,
      routes: {
        AuthMainPage.routeName: (context) => AuthMainPage(),
        RegisterPage.routeName: (context) => RegisterPage(),
        SignInPage.routeName: (context) => SignInPage(),
        ResetPasswordPage.routeName: (context) => ResetPasswordPage(),
        MainPage.routeName: (context) => MainPage(),
        ProfilePage.routeName: (context) => ProfilePage(),
        UsersPage.routeName: (context) => UsersPage(),
        ChatsPage.routeName: (context) => ChatsPage(),
        ChatPage.routeName: (context) => ChatPage(),
        UpdateProfilePage.routeName: (context) => UpdateProfilePage(),
      },
      home: FirebaseConfiguration(),
      theme: ThemeData.light().copyWith(
        backgroundColor: Colors.white,
        primaryColor: Color(0xFF007EF4),
        unselectedWidgetColor: Color(0xFFE6E6E6),
        accentColor: Colors.white,
        buttonColor: Color(0xFF4C5264),
        textTheme: TextTheme(
            headline1: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.w600,
                fontFamily: 'SfUi',),
            headline2: TextStyle(
              color: Colors.black,
              fontSize: 40,
              fontWeight: FontWeight.bold,
              fontFamily: 'SfUi',
            ),
            button: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
              fontFamily: 'SfUi',
            ),
            bodyText1: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontFamily: 'SfUi',
              fontWeight: FontWeight.w600,
            ),
            subtitle1: TextStyle(
              color: Color(0xFFA7A8AB),
              fontSize: 18,
              fontFamily: 'SfUi',
            ),
            subtitle2: TextStyle(
              color: Color(0xFFA7A8AB),
              fontFamily: 'SfUi',
              fontSize: 14,
            ),
            headline3: TextStyle(
                color: Color(0xFF233561),
                fontSize: 20.0,
                fontWeight: FontWeight.w600,
                fontFamily: 'SfUi'),
        headline4:TextStyle(
          color: Colors.white,
          fontSize: 15,
          fontFamily: 'SfUi',
        ),
          headline5:TextStyle(
            color: Color(0xFF4C5264),
            fontSize: 15,
            fontFamily: 'SfUi',
          ),),
      ),
    ),
  ));
}

class FirebaseConfiguration extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<FirebaseApp>(
        future: Firebase.initializeApp(),
        builder: (context, AsyncSnapshot<FirebaseApp> dataSnapshot) {
          if (dataSnapshot.hasError) {
            return Scaffold(
              backgroundColor: Colors.red,
              body: Center(child: Text((dataSnapshot.error.toString()))),
            );
          }
          if (dataSnapshot.connectionState == ConnectionState.done) {
            return SplashPage();
          }
          return Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        });
  }
}
