
import 'package:chat_app/auth/helpers/auth_helper.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  static final routeName = 'home';

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        centerTitle: true,
      ),
      body: Center(
        child: TextButton(child: Text('sign out'),onPressed: (){
          AuthHelper.authHelper.sigOut();
        },),
      ),
    );
  }
}
