import 'package:audioplayers/audioplayers.dart';
import 'package:chat_app/models/massage_model.dart';
import 'package:chat_app/providers/auth_provider.dart';
import 'package:chat_app/providers/chat_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DrawContentMassageWidget extends StatelessWidget {
  MassageModel massage;

  DrawContentMassageWidget({@required this.massage});

  @override
  Widget build(BuildContext context) {
    switch (this.massage.typeMassage) {
      case TypeMassage.Text:
        return Text(
          this.massage.content,
          style: (massage.userSendId ==
                  Provider.of<AuthProvider>(context, listen: false).user.id)
              ? Theme.of(context).textTheme.headline4
              : Theme.of(context).textTheme.headline5,
        );
      case TypeMassage.Image:
        return Image.network(
          this.massage.content,
        );
      case TypeMassage.Audio:
        return Consumer2<AuthProvider, ChatProvider>(
            builder: (context, authProvider, chatProvider, x) {
          return Row(children: [
            Expanded(
                flex: 1,
                child: GestureDetector(
                  onTap: () => chatProvider.playAudio(massage.content),
                  child: StreamBuilder<PlayerState>(
                      stream: chatProvider.audioPlayer.onPlayerStateChanged,
                      builder: (context, snapshot) {
                        return Icon(
                          (snapshot.data == null ||snapshot.data == PlayerState.COMPLETED)
                              ? Icons.play_circle
                              : Icons.pause_circle,
                          size: 25.0,
                          color: (massage.userSendId == authProvider.user.id)
                              ? Theme.of(context).backgroundColor
                              : Theme.of(context).buttonColor,
                        );
                      }),
                )),
            Expanded(
                flex: 4,
                child: Text(
                  'Audio',
                  style: (massage.userSendId == authProvider.user.id)
                      ? Theme.of(context).textTheme.headline4
                      : Theme.of(context).textTheme.headline5,
                )),
          ]);
        });
    }
    return Container();
  }
}
