import 'package:chat_app/providers/bottom_bar_provider.dart';
import 'package:chat_app/services/routes_helper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomIconBottomBar extends StatelessWidget {
  CustomIconBottomBar({
    @required this.imagePath,
    @required this.size,
    @required this.index,
  });

  final String imagePath;
  final double size;
  final int index;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: this.size,
      height: this.size,
      child: Image.asset(
        this.imagePath,
        color: (Provider.of<BottomBarProvider>(context,listen: false).currentIndex == index)
            ? Theme.of(context).primaryColor
            : Color(0xFFCCCCCC),
      ),
    );
  }
}
