import 'package:chat_app/models/massage_model.dart';
import 'package:chat_app/providers/auth_provider.dart';
import 'package:chat_app/services/routes_helper.dart';
import 'package:chat_app/ui/chat_page/widgets/custom_text_note_widget.dart';
import 'package:chat_app/ui/chat_page/widgets/draw_content_massage_widget.dart';
import 'package:chat_app/ui/global_widgets/custom_loading_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/bubble_type.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_5.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class CustomStreamMassagesWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(builder: (context, provider, x) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
        child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: provider.getAllMassagesFromTowUser(),
          builder: (context, AsyncSnapshot<dynamic> snapShot) {
            switch (snapShot.connectionState) {
              case ConnectionState.active:
              case ConnectionState.done:
                if (!snapShot.hasError && snapShot.hasData) {
                  QuerySnapshot<Map<String, dynamic>> data = snapShot.data;
                  List<MassageModel> massages = data.docs
                      .map((e) => MassageModel.fromMap(e.data()))
                      .toList();
                  if (massages.length == 0) {
                    return CustomTextNoteWidget(
                      text: '👋\n\nWelcome New Chat !\nSend Hi To Friend',
                    );
                  }
                  return ListView.builder(
                    reverse: true,
                    itemCount: massages.length,
                    itemBuilder: (context, index) {
                      if (massages[index].userSendId == provider.user.id) {
                        return Container(
                          margin: EdgeInsets.symmetric(vertical: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              ChatBubble(
                                elevation: 1,
                                alignment: Alignment.centerRight,
                                shadowColor: Theme.of(context).primaryColor,
                                backGroundColor: Theme.of(context).primaryColor,
                                clipper: ChatBubbleClipper5(
                                    type: BubbleType.sendBubble),
                                child: DrawContentMassageWidget(
                                  massage: massages[index],
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                DateFormat('MMM d, h:mm')
                                    .format(massages[index].dateTime.toDate()),
                                style: Theme.of(context).textTheme.subtitle2,
                              ),
                            ],
                          ),
                        );
                      } else {
                        return Container(
                          margin: EdgeInsets.symmetric(vertical: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ChatBubble(
                                elevation: 1,
                                backGroundColor:
                                    Theme.of(context).unselectedWidgetColor,
                                shadowColor:
                                    Theme.of(context).unselectedWidgetColor,
                                alignment: Alignment.centerLeft,
                                clipper: ChatBubbleClipper5(
                                    type: BubbleType.receiverBubble),
                                child: DrawContentMassageWidget(
                                  massage: massages[index],
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                DateFormat('MMM d, h:mm')
                                    .format(massages[index].dateTime.toDate()),
                                style: Theme.of(context).textTheme.subtitle2,
                              ),
                            ],
                          ),
                        );
                      }
                    },
                  );
                } else {
                  return CustomTextNoteWidget(text: '⚠\n\nError In Data !');
                }
                break;
              case ConnectionState.waiting:
              case ConnectionState.none:
                return CustomLoadingWidget();
                break;
              default:
                return CustomLoadingWidget();
            }
          },
        ),
      );
    });
  }
}
