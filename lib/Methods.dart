import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:letschat/loginscreen.dart';

Future<User?> createAccount(String name, String email, String password) async {
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  try {
    User? user = (await _auth.createUserWithEmailAndPassword(
            email: email, password: password))
        .user;
    if (user != null) {
      print("Account created successfully");
      user.updateDisplayName(name);
      await _firestore.collection('users').doc(_auth.currentUser!.uid).set({
        "name": name,
        "email": email,
        "status": "unavailable",
      });
      return user;
    } else {
      print("account creation failed");
    }
  } catch (e) {
    print(e);
  }
}

Future<User?> LogIn(String email, String password) async {
  FirebaseAuth _auth = FirebaseAuth.instance;
  try {
    User? user = (await _auth.signInWithEmailAndPassword(
            email: email, password: password))
        .user;
    if (user != null) {
      print("LogIn successfully");
      return user;
    } else {
      print("Login  failed");
    }
  } catch (e) {
    print(e);
    return null;
  }
}

Future LogOut(BuildContext context) async {
  FirebaseAuth _auth = FirebaseAuth.instance;
  try {
    await _auth.signOut().then((value) {
      Navigator.push(
          context, MaterialPageRoute(builder: (_) => OldLoginScreen()));
    });
  } catch (e) {
    print(e);
  }
}
