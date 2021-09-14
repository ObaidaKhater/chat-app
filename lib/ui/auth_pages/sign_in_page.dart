import 'package:chat_app/providers/auth_provider.dart';
import 'package:chat_app/ui/auth_pages/reset_password_page.dart';
import 'package:chat_app/ui/auth_pages/widgets/custom_button_widget.dart';
import 'package:chat_app/ui/global_widgets/custom_textfield_widget.dart';
import 'package:chat_app/services/routes_helper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignInPage extends StatelessWidget {
  static final routeName = 'login';

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
                  'Welcome back !',
                  style: Theme.of(context).textTheme.headline2,
                ),
                SizedBox(height: 5),
                Text(
                  'Please login to your account.',
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                SizedBox(height: 20),
                CustomTextFieldWidget(authProvider.emailController, 'Email'),
                SizedBox(height: 10),
                CustomTextFieldWidget(
                    authProvider.passwordController, 'Password'),
                SizedBox(height: 30),
                CustomButtonWidget('LOGIN', () => authProvider.signIn),
                SizedBox(height: 5),
                TextButton(
                    onPressed: () => RouteHelper.routeHelper
                        .pushName(ResetPasswordPage.routeName),
                    child: Text('Forgot Password?'))
              ],
            ),
          ),
        );
      },
    );
  }
}
