
import 'package:chat_app/providers/auth_provider.dart';
import 'package:chat_app/ui/auth_pages/register_page.dart';
import 'package:chat_app/ui/auth_pages/sign_in_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthMainPage extends StatefulWidget {
  static final routeName = 'authMain';
  @override
  _AuthMainPageState createState() => _AuthMainPageState();
}

class _AuthMainPageState extends State<AuthMainPage>
    with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    Provider.of<AuthProvider>(context, listen: false).tabController =
        TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).backgroundColor,
        title: Image.asset('assets/images/logo.png',width: 160,),
        toolbarHeight: MediaQuery.of(context).size.height * 0.35,
        centerTitle: true,
        bottom: TabBar(
            controller: Provider.of<AuthProvider>(context).tabController,
            tabs: [
              Tab(
                child:
                    Text('Login', style: Theme.of(context).textTheme.headline1),
              ),
              Tab(
                child: Text('Signup',
                    style: Theme.of(context).textTheme.headline1),
              ),
            ]),
      ),
      body: TabBarView(
        controller: Provider.of<AuthProvider>(context).tabController,
        children: [
          SignInPage(),
          RegisterPage(),
        ],
      ),
    );
  }
}
