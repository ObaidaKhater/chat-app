import 'package:chat_app/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomTextFieldMassageWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(builder: (context, provider, x) {
      return Container(
        margin: EdgeInsets.symmetric(horizontal: 10.0),
        child: TextField(
          controller: provider.massageController,
          style: Theme.of(context).textTheme.bodyText1,
          decoration: InputDecoration(
              border: InputBorder.none, hintText: 'Write your message…'),
          maxLines: null,
          keyboardType: TextInputType.multiline,
        ),
      );
    });
  }
}
