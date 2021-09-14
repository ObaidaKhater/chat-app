import 'package:chat_app/providers/auth_provider.dart';
import 'package:chat_app/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomBoxImageWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder:  (context,provider,x){
        return  GestureDetector(
          onTap: () => provider.selectImageFile(),
          child: (provider.imageFile == null)
              ? CircleAvatar(
            radius: 100,
            backgroundColor: Colors.grey,
          )
              : CircleAvatar(
            radius: 100,
            backgroundColor: Colors.grey,
            backgroundImage: FileImage(provider.imageFile),
          ),
        );
      },
    );
  }
}
