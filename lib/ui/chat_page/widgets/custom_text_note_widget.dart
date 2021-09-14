import 'package:flutter/material.dart';

class CustomTextNoteWidget extends StatelessWidget {
  String text;

  CustomTextNoteWidget({@required this.text});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
       this.text,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.subtitle1,
      ),
    );
  }
}
