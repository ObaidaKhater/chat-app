import 'package:chat_app/services/routes_helper.dart';
import 'package:flutter/material.dart';

class CustomDialog {
  CustomDialog._();

  static CustomDialog customDialog = CustomDialog._();

  showCustomDialog(String message, [Function function]) {
    showDialog(
        context: RouteHelper.routeHelper.navKey.currentContext,
        builder: (context) {
          return AlertDialog(
            content: Text(
              message,
              style: Theme.of(context).textTheme.bodyText1,
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    if (function == null) {
                      RouteHelper.routeHelper.back();
                    } else {
                      function();
                      print('1111111111111111111111111111');
                      RouteHelper.routeHelper.back();
                    }
                  },
                  child: Text('Ok'))
            ],
          );
        });
  }
}
