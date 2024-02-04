import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat/constants.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  static const String id = "chat_screen";

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _auth = FirebaseAuth.instance;
  User? LoggedIn;
  final _fireStore = FirebaseFirestore.instance;
  String? messageText;
  final textfieldcontroller = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async {
    try {
      LoggedIn = _auth.currentUser;
    } catch (e) {
      print(e);
    }
  }

  void messageStream() async {
    await for (var snapshot in _fireStore.collection("messages").snapshots()) {
      for (var message in snapshot.docs) {
        print(message.data());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                // _auth.signOut();
                // Navigator.pop(context);
                messageStream();
              }),
        ],
        title: Text('⚡️Chat'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Stream(fireStore: _fireStore),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: textfieldcontroller,
                      onChanged: (value) {
                        messageText = value;
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      textfieldcontroller.clear();
                      _fireStore.collection("message").add(
                          {'text': messageText, 'user': LoggedIn?.email ?? ""});
                    },
                    child: Text(
                      'Send',
                      style: kSendButtonTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Stream extends StatelessWidget {
  const Stream({
    super.key,
    required FirebaseFirestore fireStore,
  }) : _fireStore = fireStore;

  final FirebaseFirestore _fireStore;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: _fireStore.collection('messages').snapshots(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            final message = snapshot.data.docs;
            List<RoundBubble> messageWidgets = [];
            for (var messages in message) {
              final messageText = messages.data()['text'];
              final messageSender = messages.data()['user'];
              final messageWidget = RoundBubble(
                  messagetext: messageText, messagesender: messageSender);
              messageWidgets.add(messageWidget);
            }
            return Expanded(
              child: ListView(children: messageWidgets),
            );
          }
          return CircularProgressIndicator(
            color: Colors.lightBlueAccent,
          );
        });
  }
}

class RoundBubble extends StatelessWidget {
  final String? messagetext;
  final String? messagesender;

  RoundBubble({this.messagetext, this.messagesender}) {}

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child:
          Column(crossAxisAlignment: CrossAxisAlignment.end, children: <Widget>[
        Text(
          '$messagesender',
          style: TextStyle(fontSize: 12.0, color: Colors.black54),
        ),
        Material(
          borderRadius: BorderRadius.circular(30.0),
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Text(
              "$messagetext",
              style: TextStyle(color: Colors.white, fontSize: 15.0),
            ),
          ),
          elevation: 10.0,
          color: Colors.blue,
        ),
      ]),
    );
  }
}
