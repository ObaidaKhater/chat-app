import 'package:flutter/material.dart';

class CustomTextFieldWidget extends StatelessWidget {
  TextEditingController textEditingController;
  String labelText;

  CustomTextFieldWidget(this.textEditingController, this.labelText);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: this.textEditingController,
      style: Theme.of(context).textTheme.bodyText1,
      decoration: InputDecoration(labelText: this.labelText),
    );
  }
}
