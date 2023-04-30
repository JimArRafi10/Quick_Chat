import 'package:flutter/material.dart';
import 'package:quick_chat/screens/auth_screen.dart';
import 'package:quick_chat/screens/chat_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quick Chat',
      theme: ThemeData(

        primarySwatch: Colors.blue,
        backgroundColor: Colors.blueAccent,
        accentColor: Colors.lightBlue,
        accentColorBrightness: Brightness.dark,
        buttonTheme: ButtonTheme.of(context).copyWith(
          buttonColor: Colors.indigoAccent,
      textTheme: ButtonTextTheme.primary,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20),),
      ),
      ),
      home: StreamBuilder(stream:
        FirebaseAuth.instance.authStateChanges(),builder: ( context, userSnapshot){
         if(userSnapshot.hasData) {
           return ChatScreen();
         }
         return AuthScreen();
      }),
    );
  }
}


