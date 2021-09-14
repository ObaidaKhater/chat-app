import 'package:chat_app/services/routes_helper.dart';
import 'package:flutter/material.dart';

class CustomAppBarWidget extends StatelessWidget
    implements PreferredSizeWidget {
  String imageUrl;
  String title;
  Function function;

  CustomAppBarWidget(
      {@required this.imageUrl, @required this.title, @required this.function});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      toolbarHeight: MediaQuery.of(context).size.height/7,
      elevation: 0,
      backgroundColor: Theme.of(context).backgroundColor,
      leading: IconButton(
        onPressed: () => RouteHelper.routeHelper.back(),
        icon: Icon(Icons.arrow_back,color: Theme.of(context).buttonColor,),
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(this.imageUrl),
            radius: 20,
          ),
          Text(
            this.title,
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ],
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(
      MediaQuery.of(RouteHelper.routeHelper.navKey.currentContext).size.height /
          7);
}
