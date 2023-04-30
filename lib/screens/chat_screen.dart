import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quick_chat/chat/new_messages.dart';

import '../chat/messages.dart';


class ChatScreen extends StatelessWidget {

  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QuickChat'),
        actions: [
          DropdownButton(
              icon: Icon(
                Icons.more_vert,
                color: Theme.of(context).primaryIconTheme.color,
              ),
              items: [
            DropdownMenuItem(value: 'logout',child: Container(child: Row(
              children:  <Widget>[
                Icon(Icons.exit_to_app),
                SizedBox(width: 8,),
                Text('Logout'),
              ],
            ),
            ),
            ),
          ], onChanged: (itemIdentifier) {
            if(itemIdentifier == 'logout'){
              FirebaseAuth.instance.signOut();
            }
          })
        ],
      ),


      body: Container(
        child: Column(
          children: <Widget>[
            Expanded(
              child: Messages(),
            ),
            NewMessage(),
          ],
        ),
      ),

    );
  }
}


