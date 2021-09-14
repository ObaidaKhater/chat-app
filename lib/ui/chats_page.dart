import 'package:chat_app/providers/auth_provider.dart';
import 'package:chat_app/ui/global_widgets/custom_listTile_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatsPage extends StatefulWidget {
  static final String routeName = 'chats';

  @override
  _ChatsPageState createState() => _ChatsPageState();
}

class _ChatsPageState extends State<ChatsPage> {
  @override
  void initState() {
    super.initState();
    Provider.of<AuthProvider>(context, listen: false).getAllChatsUsersFromMe();
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
            'Messages',
            style: Theme.of(context).textTheme.headline3,
          ),
        ),
        body: (provider.chatsUsersFromMe != null)
            ? ListView.builder(
                itemCount: provider.chatsUsersFromMe.length,
                itemBuilder: (context, index) => CustomListTileWidget(
                  title: provider.chatsUsersFromMe[index].fName +
                      ' ' +
                      provider.chatsUsersFromMe[index].lName,
                  subtitle: provider.chatsUsersFromMe[index].email,
                  imageUrl: provider.chatsUsersFromMe[index].imageUrl,
                  onTap: () =>
                      provider.goToChatPage(provider.chatsUsersFromMe[index]),
                ),
              )
            : Center(child: CircularProgressIndicator()),
      );
    });
  }
}
