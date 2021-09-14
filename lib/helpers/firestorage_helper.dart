import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class FireStorageHelper {
  FireStorageHelper._();

  static FireStorageHelper fireStorageHelper = FireStorageHelper._();

  FirebaseStorage firebaseStorage = FirebaseStorage.instance;

  Future<String> uploadImage(File file,[folderName = 'profiles']) async {
    // 1. make a reference for this file in firebase storage
    String filePath = file.path;
    String fileName = filePath.split('/').last;
    String path = 'images/$folderName/$fileName';
    Reference reference = firebaseStorage.ref(path);
    // 2. upload the file in defined reference
    await reference.putFile(file);
    // 3. return the url file
    String imageUrl = await reference.getDownloadURL();
    return imageUrl;
  }

  Future<String>uploadAudio(File file) async{
    // 1. make a reference for this file in firebase storage
    String path = 'audios/chats/${DateTime.now().millisecondsSinceEpoch.toString()}.jpg';
    Reference reference = firebaseStorage.ref(path);
    // 2. upload the file in defined reference
    await reference.putFile(file);
    // 3. return the url file
    String audioUrl = await reference.getDownloadURL();
    return audioUrl;
  }


}
