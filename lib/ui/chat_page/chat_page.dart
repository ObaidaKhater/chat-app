import 'package:chat_app/providers/auth_provider.dart';
import 'package:chat_app/services/routes_helper.dart';
import 'package:chat_app/ui/chat_page/widgets/custom_app_bar_widget.dart';
import 'package:chat_app/ui/chat_page/widgets/custom_button_record_massage_widget.dart';
import 'package:chat_app/ui/chat_page/widgets/custom_button_widget.dart';
import 'package:chat_app/ui/chat_page/widgets/custom_stream_massages_widget.dart';
import 'package:chat_app/ui/chat_page/widgets/cutom_textField_massage_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatPage extends StatelessWidget {
  static final String routeName = 'chat';

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
        builder: (context, authProvider, x) {
      return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: CustomAppBarWidget(
          imageUrl: authProvider.anotherUser.imageUrl,
          title: authProvider.anotherUser.fName +
              ' ' +
              authProvider.anotherUser.lName,
          function: () => RouteHelper.routeHelper.back(),
        ),
        body: Column(
          children: [
            Expanded(
              child: CustomStreamMassagesWidget(),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              child: Row(
                children: [
                  CustomButtonWidget(
                    icon: Icons.photo_outlined,
                    onTap: () => authProvider.sendImageToChat(),
                  ),
                  SizedBox(width: 5.0),
                  CustomButtonRecordMassageWidget(),
                  Expanded(
                    child: CustomTextFieldMassageWidget(),
                  ),
                  CustomButtonWidget(
                    icon: Icons.send_rounded,
                    onTap: () => authProvider.sendMassage(),
                  ),
                ],
              ),
            )
          ],
        ),
      );
    });
  }
}
