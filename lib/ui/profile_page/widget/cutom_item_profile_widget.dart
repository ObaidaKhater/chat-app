import 'package:flutter/material.dart';
class CustomItemProfileWidget extends StatelessWidget {
  String label;
  String value;
  IconData iconData;

  CustomItemProfileWidget(
      {@required this.label, @required this.value, @required this.iconData});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          this.label,
          style: Theme.of(context).textTheme.subtitle2,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              this.iconData,
              color: Theme.of(context).primaryColor,
            ),
            SizedBox(width: 10),
            Text(
              this.value,
              style: Theme.of(context).textTheme.headline1,
            ),
          ],
        )
      ],
    );
  }
}
