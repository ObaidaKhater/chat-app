import 'package:flutter/material.dart';

class CustomButtonWidget extends StatelessWidget {
  Function onTap;
  String label;

  CustomButtonWidget(this.label, this.onTap);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 50,
      child: ElevatedButton(
        onPressed: this.onTap(),
        child: Text(this.label,style: Theme.of(context).textTheme.button,),
      ),
    );
  }
}
