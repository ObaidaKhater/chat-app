import 'package:flutter/material.dart';

class CustomListTileWidget extends StatelessWidget {
  String imageUrl;
  String title;
  String subtitle;
  Function onTap;

  CustomListTileWidget({
    @required this.imageUrl,
    @required this.title,
    @required this.subtitle,
    @required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
      child: ListTile(
        onTap: this.onTap,
        leading: CircleAvatar(
          radius: 30.0,
          backgroundImage: NetworkImage(this.imageUrl),
          backgroundColor: Colors.blue,
        ),
        title: Text(
          this.title,
          style: Theme.of(context).textTheme.bodyText1,
        ),
        subtitle: Text(
          this.subtitle,
          style: Theme.of(context).textTheme.subtitle2,
        ),
      ),
    );
  }
}
