import 'package:chat_app/Auth/providers/auth_provider.dart';
import 'package:chat_app/Auth/ui/register_page.dart';
import 'package:chat_app/Auth/ui/reset_password_page.dart';
import 'package:chat_app/Auth/ui/sign_in_page.dart';
import 'package:chat_app/assigments/provider.dart';
import 'package:chat_app/auth/ui/auth_main_page.dart';
import 'package:chat_app/chats/home_page.dart';
import 'package:chat_app/chats/providers/user_provider.dart';
import 'package:chat_app/chats/splash_page.dart';
import 'package:chat_app/services/routes_helper.dart';
import 'package:chat_app/services/shared_preferences_helper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'assigments/ui.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SPHelper.spHelper.initSharedPreferences();
  runApp(MultiProvider(
    child: MaterialApp(
      navigatorKey: RouteHelper.routeHelper.navKey,
      routes: {
        AuthMainPage.routeName: (context) => AuthMainPage(),
        RegisterPage.routeName: (context) => RegisterPage(),
        SignInPage.routeName: (context) => SignInPage(),
        ResetPasswordPage.routeName: (context) => ResetPasswordPage(),
        HomePage.routeName: (context) => HomePage(),
      },
      home: FirebaseConfiguration(),
      theme: ThemeData.light().copyWith(
        primaryColor: Colors.white,
        accentColor: Colors.white,
        textTheme: TextTheme(
          headline1: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
          headline2: TextStyle(
            color: Colors.black,
            fontSize: 40,
            fontWeight: FontWeight.bold,
          ),
          button: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
          bodyText1: TextStyle(
            color: Colors.black,
            fontSize: 16,
          ),
          subtitle1: TextStyle(
            color: Colors.grey,
            fontSize: 18,
          ),
        ),
      ),
    ),
    providers: [
      ChangeNotifierProvider<AuthProvider>(create: (context) => AuthProvider()),
      ChangeNotifierProvider<UserProvider>(create: (context) => UserProvider()),
      ChangeNotifierProvider<CountryProvider>(create: (context) => CountryProvider()),
    ],
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
            // return SplashPage();
            return  CountryPage();
          }
          return Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        });
  }
}
