import 'package:chat_app/providers/auth_provider.dart';
import 'package:chat_app/ui/global_widgets/custom_listTile_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UsersPage extends StatefulWidget {
  static final String routeName = 'users';

  @override
  _UsersPageState createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  @override
  void initState() {
    super.initState();
    Provider.of<AuthProvider>(context,listen: false).getAllUser();
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(builder: (context, provider, x) {
      return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          backgroundColor: Theme.of(context).backgroundColor,
          title: Text(
            'Users',
            style: Theme.of(context).textTheme.headline3,
          ),
        ),
        body: (provider.users != null)
            ? ListView.builder(
                itemCount: provider.users.length,
                itemBuilder: (context, index) => CustomListTileWidget(
                  title: provider.users[index].fName +
                      ' ' +
                      provider.users[index].lName,
                  subtitle: provider.users[index].email,
                  imageUrl: provider.users[index].imageUrl,
                  onTap: ()async=>await provider.buildChatFromTwoUsers(provider.users[index].id),
                ),
              )
            : Center(child: CircularProgressIndicator()),
      );
    });
  }
}
