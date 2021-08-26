import 'package:chat_app/auth/providers/auth_provider.dart';
import 'package:chat_app/auth/ui/auth_main_page.dart';
import 'package:chat_app/chats/home_page.dart';
import 'package:chat_app/services/routes_helper.dart';
import 'package:chat_app/services/shared_preferences_helper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 2)).then((value) {
     Provider.of<AuthProvider>(context,listen: false).checkIsLoginUser();
    });
    return Scaffold(
      body: Center(
        child: Text('Splash Screen',style: Theme.of(context).textTheme.subtitle1,),
      ),
    );
  }
}
