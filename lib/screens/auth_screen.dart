import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quick_chat/widgets/auth/auth_form.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _auth = FirebaseAuth.instance;
  var _isLoading = false;

  void _submitAuthForm(
      String email,
      String username,
      String password,
      bool isLogin,

      ) async {
    UserCredential authResult;
    try {
      _isLoading = true;
      if (isLogin) {
        authResult = await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
      } else {
        authResult = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        await FirebaseFirestore.instance.collection('users').doc(
            authResult.user?.uid).set({
          'email': email,
          'password': username,
        });
      }
    }
    on PlatformException catch (err) {
      String? message = 'An error occured , please check your credentials';

      if (err.message != null) {
        message = err.message;
      }
      setState(() {
        _isLoading = false;
      });

    }
  }
    @override
    Widget build(BuildContext context) {
      return Scaffold(
        backgroundColor: Theme
            .of(context)
            .primaryColor,
        body: AuthForm(
          _submitAuthForm,
          _isLoading,
        ),
      );
    }
  }


