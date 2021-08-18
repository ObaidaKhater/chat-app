import 'package:chat_app/Auth/providers/auth_provider.dart';
import 'package:chat_app/Auth/ui/widgets/custom_button_widget.dart';
import 'package:chat_app/Auth/ui/widgets/custom_textfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatelessWidget {
  static final routeName = 'register';
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, authProvider, x) {
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 25, vertical: 25),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome !',
                  style: Theme.of(context).textTheme.headline2,
                ),
                SizedBox(height: 5),
                Text(
                  'Please enter your email and password.',
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                SizedBox(height: 20),
                CustomTextFieldWidget(authProvider.emailController, 'Email'),
                SizedBox(height: 10),
                CustomTextFieldWidget(authProvider.passwordController, 'Password'),
                SizedBox(height: 30),
                CustomButtonWidget('SIGN UP', () => authProvider.register),
              ],
            ),
          ),
        );
      },
    );
  }
}
