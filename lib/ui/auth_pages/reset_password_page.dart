import 'package:chat_app/Auth/ui/widgets/custom_button_widget.dart';
import 'package:chat_app/providers/auth_provider.dart';
import 'package:chat_app/ui/global_widgets/custom_textfield_widget.dart';
import 'package:chat_app/services/routes_helper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ResetPasswordPage extends StatelessWidget {
  static final routeName = 'resetPassword';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).accentColor,
      body: Consumer<AuthProvider>(
        builder: (context, authProvider, x) {
          return Container(
            alignment: Alignment.center,
            margin: EdgeInsets.symmetric(horizontal: 25, vertical: 25),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Reset Password !',
                    style: Theme.of(context).textTheme.headline2,
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Please enter your email.',
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                  SizedBox(height: 20),
                  CustomTextFieldWidget(authProvider.emailController, 'Email'),
                  SizedBox(height: 30),
                  CustomButtonWidget('RESET', () => authProvider.resetPassword),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
