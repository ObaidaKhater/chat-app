import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: FirebaseConfiguration()));
}

class FirebaseConfiguration extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<FirebaseApp>(
        future: Firebase.initializeApp(),
        builder: (context, AsyncSnapshot<FirebaseApp> dataSnapshot) {
          if (dataSnapshot.hasError) {
            return Scaffold(
              backgroundColor: Colors.red,
              body: Center(child: Text((dataSnapshot.error.toString()))),
            );
          }
          if (dataSnapshot.connectionState == ConnectionState.done) {
            return Scaffold(
              body: Center(child: Text(('Done'))),
            );
          }
          return Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        });
  }
}
