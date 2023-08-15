import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:letschat/HomeScreen.dart';
import 'package:letschat/login_screen.dart';
import 'package:letschat/loginscreen.dart';

class Authenticate extends StatelessWidget {
  Authenticate({Key? key}) : super(key: key);
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    if (_auth.currentUser != null) {
      return HomeScreen();
    } else
      return OldLoginScreen();
  }
}
