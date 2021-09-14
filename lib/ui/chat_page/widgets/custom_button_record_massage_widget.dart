import 'package:chat_app/providers/chat_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomButtonRecordMassageWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ChatProvider>(
      builder: (context, provider, x) {
        return GestureDetector(
          onLongPress: (){
            provider.changeRecordingValue(true);
            provider.startRecord();
          },
          onLongPressEnd: (details){
            provider.changeRecordingValue(false);
            provider.stopRecord();
          },
          child: Container(
            width: 35.0,
            height: 35.0,
            child: Icon(
              Icons.mic_outlined,
              size: 20.0,
              color: Theme.of(context).backgroundColor,
            ),
            decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Theme.of(context).primaryColor,
                    Theme.of(context).primaryColor.withOpacity(0.5),
                  ],
                ),
                shape: BoxShape.circle,
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    spreadRadius: 4,
                    color: (provider.isRecording) ? Colors.black12 : Colors.white,
                  ),
                ]),
          ),
        );
      },
    );
  }
}
