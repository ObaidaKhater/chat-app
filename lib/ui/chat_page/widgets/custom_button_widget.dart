import 'package:chat_app/providers/auth_provider.dart';
import 'package:flutter/material.dart';

class CustomButtonWidget extends StatelessWidget {
  Function onTap;
  IconData icon;

  CustomButtonWidget({@required this.onTap,@required this.icon});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: this.onTap,
      child: Container(
        width: 35.0,
        height: 35.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            colors: [
              Theme.of(context).primaryColor,
              Theme.of(context).primaryColor.withOpacity(0.5),
            ],
          ),
        ),
        alignment: Alignment.center,
        child: Icon(
          this.icon,
          color: Colors.white,
          size: 20.0,
        ),
      ),
    );
  }
}
