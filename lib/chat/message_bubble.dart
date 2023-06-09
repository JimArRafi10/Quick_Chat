import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';



class MessageBubble extends StatelessWidget {

  MessageBubble(
    this.message, this.isMe, this.username,
  {required this.key}
  );
  final String message;
  final bool isMe;
  final Key key;
  final String username;

  //const MessageBubble({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: <Widget> [
        Container(
          decoration: BoxDecoration(
            color: isMe ? Colors.grey[300] : Theme.of(context).accentColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
              bottomLeft: !isMe ? Radius.circular(0) : Radius.circular(12),
              bottomRight: isMe ? Radius.circular(0) : Radius.circular(12),
            ),
          ),
          width: 140,
          padding: EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 16,
          ),
          margin: EdgeInsets.symmetric(
            vertical: 4,
            horizontal: 8,
          ),
          child: Column(
            crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
         children: <Widget>[
           Text(
                username,
                 style: TextStyle(
               fontWeight: FontWeight.bold,
                   color: isMe ?
                   Colors.black : Theme.of(context).canvasColor,
         ),
       ),
          Text(
            message,
            style: TextStyle(
              color: isMe ?
              Colors.black : Theme.of(context).canvasColor,
       ),
            textAlign: isMe ? TextAlign.end : TextAlign.start,
        ),
    ],
    ),
    ),
    ],
    );
  }

  }

