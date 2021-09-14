import 'package:chat_app/providers/auth_provider.dart';
import 'package:chat_app/ui/global_widgets/custom_dropdown_cities_widget.dart';
import 'package:chat_app/ui/global_widgets/custom_dropdown_countries_widget.dart';
import 'package:chat_app/ui/global_widgets/custom_textfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UpdateProfilePage extends StatelessWidget {
  static final String routeName = 'updateProfile';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).accentColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).backgroundColor,
        centerTitle: true,
        title: Text(
          'Edit Profile',
          style: Theme.of(context).textTheme.headline3,
        ),
        actions: [
          IconButton(
            onPressed: () => Provider.of<AuthProvider>(context,listen:false).updateUser(),
            icon: Icon(
              Icons.check,
              color: Theme.of(context).primaryColor,
            ),
          ),
        ],
      ),
      body: Consumer<AuthProvider>(
        builder: (context, provider, x) {
          return Container(
            margin: EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 15),
                  // Draw Image Circle
                  GestureDetector(
                    onTap: () => provider.changeFileImage(),
                    child: Container(
                      child: (provider.updateImageFile == null)
                          ? CircleAvatar(
                              radius: 90,
                              backgroundImage: NetworkImage(
                                provider.user.imageUrl,
                              ),
                            )
                          : CircleAvatar(
                              radius: 90,
                              backgroundImage: FileImage(
                                provider.updateImageFile,
                              ),
                            ),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  CustomTextFieldWidget(
                    provider.fNameController,
                    'First Name',
                  ),
                  SizedBox(height: 20.0),
                  CustomTextFieldWidget(
                    provider.lNameController,
                    'Last Name',
                  ),
                  SizedBox(height: 20.0),
                  CustomDropdownCountriesWidget(),
                  SizedBox(height: 20.0),
                  CustomDropdownCitiesWidget(),
                  SizedBox(height: 20.0),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
