import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class NewMessage extends StatefulWidget {
  const NewMessage({Key? key}) : super(key: key);

  @override
  State<NewMessage> createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  final _controller = new TextEditingController();
  var _enterMessage='';

  void _sendMessage() async {
    FocusScope.of(context).unfocus();
    final user = await  FirebaseAuth.instance.currentUser!;
    final userData = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
    FirebaseFirestore.instance.collection('chat').add({
      'text': _enterMessage,
      'createdAt': Timestamp.now(),
      'userId': user.uid,
      'username' : userData['username']

    });
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 8),
      padding: EdgeInsets.all(8),
      child: Row(
        children: <Widget>[
          Expanded(child: TextField(
            controller: _controller,
        decoration: InputDecoration(labelText: 'Send a message...'),
        onChanged:(value){
          setState(() {
            _enterMessage = value;
          });
    } ,),
      ),
       IconButton(onPressed: _enterMessage.trim().isEmpty?null: _sendMessage, icon: Icon(Icons.send),
    color: Theme.of(context).primaryColor,)
        ],
      ),

    );
  }
}
