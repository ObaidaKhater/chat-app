import 'package:chat_app/providers/auth_provider.dart';
import 'package:chat_app/ui/profile_page/widget/cutom_item_profile_widget.dart';
import 'package:chat_app/ui/update_profile_page.dart';
import 'package:chat_app/services/routes_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  static final String routeName = 'profile';

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    Provider.of<AuthProvider>(context, listen: false).getCurrentUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).accentColor,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Theme.of(context).backgroundColor,
        title: Text(
          'Profile',
          style: Theme.of(context).textTheme.headline3,
        ),
        actions: [
          IconButton(
            onPressed: () {
              Provider.of<AuthProvider>(context, listen: false)
                  .setDataToController();
              RouteHelper.routeHelper.pushName(UpdateProfilePage.routeName);
            },
            icon: Icon(
              Icons.mode_edit_outline_rounded,
              color: Theme.of(context).primaryColor,
            ),
          ),
          IconButton(
            onPressed: () =>
                Provider.of<AuthProvider>(context, listen: false).signOut(),
            icon: Icon(
              Icons.logout_outlined,
              color: Theme.of(context).primaryColor,
            ),
          )
        ],
      ),
      body: Consumer<AuthProvider>(
        builder: (context, provider, x) {
          return (provider.user == null)
              ? Center(child: CircularProgressIndicator())
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 15),
                    // Draw Circle Image
                    Expanded(
                      flex: 2,
                      child: CircleAvatar(
                        radius: 90,
                        backgroundImage: NetworkImage(provider.user.imageUrl),
                      ),
                    ),
                    // Draw Name User
                    Expanded(
                      flex: 1,
                      child: Text(
                        provider.user.fName + ' ' + provider.user.lName,
                        style: Theme.of(context).textTheme.headline2,
                      ),
                    ),
                    // Draw Full Data To User
                    Expanded(
                      flex: 3,
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            CustomItemProfileWidget(
                                label: 'EMAIL',
                                value: provider.user.email,
                                iconData: Icons.email),
                            CustomItemProfileWidget(
                                label: 'COUNTRY',
                                value: provider.user.country,
                                iconData: Icons.location_on),
                            CustomItemProfileWidget(
                                label: 'CITY',
                                value: provider.user.city,
                                iconData: Icons.location_city_rounded),
                          ],
                        ),
                      ),
                    ),
                    Spacer()
                  ],
                );
        },
      ),
    );
  }
}
