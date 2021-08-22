import 'package:chat_app/auth/providers/auth_provider.dart';
import 'package:chat_app/auth/ui/auth_main_page.dart';
import 'package:chat_app/chats/home_page.dart';
import 'package:chat_app/services/routes_helper.dart';
import 'package:chat_app/services/shared_preferences_helper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashPage extends StatelessWidget {
  static final routeName = 'splash';

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 3)).then((value) {
      if (SPHelper.spHelper.getCurrentUser() != null) {
        RouteHelper.routeHelper.pushReplacementNamed(HomePage.routeName);
      } else {
        RouteHelper.routeHelper.pushReplacementNamed(AuthMainPage.routeName);
      }
    });
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
