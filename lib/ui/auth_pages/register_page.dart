import 'package:chat_app/Auth/ui/widgets/custom_button_widget.dart';
import 'package:chat_app/providers/auth_provider.dart';
import 'package:chat_app/ui/auth_pages/widgets/coutom_box_image_widget.dart';
import 'package:chat_app/ui/global_widgets/custom_dropdown_cities_widget.dart';
import 'package:chat_app/ui/global_widgets/custom_dropdown_countries_widget.dart';
import 'package:chat_app/ui/global_widgets/custom_textfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Welcome !',
                  style: Theme.of(context).textTheme.headline2,
                ),
                SizedBox(height: 5),
                Text(
                  'Please enter your data account.',
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                SizedBox(height: 20),
                CustomBoxImageWidget(),
                SizedBox(height: 10),
                CustomTextFieldWidget(authProvider.emailController, 'Email'),
                SizedBox(height: 10),
                CustomTextFieldWidget(
                    authProvider.passwordController, 'Password'),
                SizedBox(height: 10),
                CustomTextFieldWidget(
                    authProvider.fNameController, 'First Name'),
                SizedBox(height: 10),
                CustomTextFieldWidget(
                    authProvider.lNameController, 'Last Name'),
                SizedBox(height: 10),
                CustomDropdownCountriesWidget(),
                SizedBox(height: 10),
                CustomDropdownCitiesWidget(),
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
