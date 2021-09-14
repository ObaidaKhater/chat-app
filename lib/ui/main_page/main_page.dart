import 'package:chat_app/providers/bottom_bar_provider.dart';
import 'package:chat_app/ui/chats_page.dart';
import 'package:chat_app/ui/main_page/widgets/custom_icon_bottom_bar.dart';
import 'package:chat_app/ui/profile_page/profile_page.dart';
import 'package:chat_app/ui/users_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainPage extends StatefulWidget {
  static final routeName = 'main';

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    Provider.of<BottomBarProvider>(context, listen: false).tabController =
        TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<BottomBarProvider>(builder: (context, provider, x) {
      return Scaffold(
        bottomNavigationBar: Container(
          height: 80.0,
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(
                color: Color(0xFFCECECE).withOpacity(0.3),
              ),
            ),
          ),
          child: BottomNavigationBar(
            elevation: 0,
            currentIndex: provider.currentIndex,
            selectedItemColor: Colors.teal,
            backgroundColor: Theme.of(context).backgroundColor,
            onTap: (newIndex) => provider.changeCurrentIndex(newIndex),
            items: [
              BottomNavigationBarItem(
                label: '',
                backgroundColor: Colors.red,
                icon: CustomIconBottomBar(
                  imagePath: 'assets/icons/profile.png',
                  size: 22.0,
                  index: 0,
                ),
              ),
              BottomNavigationBarItem(
                label: '',
                icon: CustomIconBottomBar(
                  imagePath: 'assets/icons/users.png',
                  size: 22.0,
                  index: 1,
                ),
              ),
              BottomNavigationBarItem(
                label: '',
                backgroundColor: Colors.red,
                icon: CustomIconBottomBar(
                  imagePath: 'assets/icons/chat.png',
                  size: 22.0,
                  index: 2,
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(controller: provider.tabController, children: [
          ProfilePage(),
          UsersPage(),
          ChatsPage(),
        ]),
      );
    });
  }
}
