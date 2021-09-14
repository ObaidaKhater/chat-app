import 'dart:io';
import 'package:audioplayers/audioplayers.dart';
import 'package:http/http.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:record_mp3/record_mp3.dart';
import 'package:chat_app/helpers/firestorage_helper.dart';
import 'package:chat_app/helpers/firestore_helper.dart';
import 'package:chat_app/models/chat_request.dart';
import 'package:chat_app/models/massage_model.dart';
import 'package:chat_app/providers/auth_provider.dart';
import 'package:chat_app/services/routes_helper.dart';
import 'package:provider/provider.dart';

class ChatProvider extends ChangeNotifier {
  bool isRecording = false;
  String recordFilePath = '';
  int i = 0;
  AudioPlayer audioPlayer = AudioPlayer();


  changeRecordingValue(bool newValue) {
    isRecording = newValue;
    notifyListeners();
  }

  Future<bool> checkPermission() async {
    if (!await Permission.microphone.isGranted) {
      PermissionStatus status = await Permission.microphone.request();
      if (status != PermissionStatus.granted) {
        return false;
      }
    }
    return true;
  }

  Future<String> getFilePath() async {
    Directory storageDirectory = await getApplicationDocumentsDirectory();
    String sdPath = storageDirectory.path + "/record";
    var d = Directory(sdPath);
    if (!d.existsSync()) {
      d.createSync(recursive: true);
    }
    return sdPath + "/test_${i++}.mp3";
  }

  void startRecord() async {
    bool hasPermission = await checkPermission();
    if (hasPermission) {
      recordFilePath = await getFilePath();
      RecordMp3.instance.start(recordFilePath, (type) {
        notifyListeners();
      });
    } else {
      notifyListeners();
    }
  }

  void stopRecord() async {
    bool s = RecordMp3.instance.stop();
    if (s) {
      // setState(() {
      //   isSending = true;
      // });
      await sendAudioMsg();

      // setState(() {
      //   isPlayingMsg = false;
      // });
    }
  }

  sendAudioMsg() async {
    // upload audio file
    File file = File(recordFilePath);
    String audioUrl =
        await FireStorageHelper.fireStorageHelper.uploadAudio(file);
    if (audioUrl.isNotEmpty) {
      MassageModel massage = MassageModel(
        userSendId: Provider.of<AuthProvider>(
                RouteHelper.routeHelper.navKey.currentContext,
                listen: false)
            .user
            .id,
        dateTime: Timestamp.now(),
        content: audioUrl,
        typeMassage: TypeMassage.Audio,
      );
      ChatRequest chatRequest = ChatRequest(
          myId: Provider.of<AuthProvider>(
                  RouteHelper.routeHelper.navKey.currentContext,
                  listen: false)
              .user
              .id,
          anotherUserId: Provider.of<AuthProvider>(
                  RouteHelper.routeHelper.navKey.currentContext,
                  listen: false)
              .anotherUser
              .id);
      await FireStoreHelper.fireStoreHelper
          .addMassageToFireStore(chatRequest, massage);
    } else {
      print("Hello");
    }
  }

  playAudio(String url) async {
    File file = await loadFile(url);
    recordFilePath = file.path;
    if (recordFilePath != null && File(recordFilePath).existsSync()) {
      await audioPlayer.play(
        recordFilePath,
        isLocal: true,
      );
    }
  }

  Future<File> loadFile(String url) async {
    final bytes = await readBytes(Uri.parse(url));
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/audio.mp3');
    File finalFile = await file.writeAsBytes(bytes);
    return finalFile;
  }
}
