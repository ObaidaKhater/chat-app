import 'package:chat_app/auth/providers/auth_provider.dart';
import 'package:chat_app/chats/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  static final routeName = 'home';

  Widget build(BuildContext context) {
    return Consumer2<UserProvider, AuthProvider>(
        builder: (context, userProvider, authProvider, x) {
      return Scaffold(
        floatingActionButton: FloatingActionButton(onPressed: () => authProvider.signOut),
        appBar: AppBar(
          backgroundColor: Colors.grey,
          title: Text(
            'Home',
            style: Theme.of(context).textTheme.headline1,
          ),
          centerTitle: true,
        ),
        body: (userProvider.users != null)
            ? ListView.builder(
                itemCount: userProvider.users.length,
                itemBuilder: (context, index) => ListTile(
                  leading: CircleAvatar(
                    child: Text((index + 1).toString()),
                    backgroundColor: Colors.blue,
                  ),
                  title: Text(
                    userProvider.users[index].fName +
                        '\t' +
                        userProvider.users[index].lName,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  subtitle: Text(
                    userProvider.users[index].email,
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                ),
              )
            : Center(child: CircularProgressIndicator()),
      );
    });
  }
}
