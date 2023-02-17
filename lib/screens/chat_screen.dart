import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../constants.dart';
final _auth=FirebaseAuth.instance;
late User loggedinUser;
final _firestore=FirebaseFirestore.instance;

class ChatScreen extends StatefulWidget {
  static const String id='chat_screen';
  const ChatScreen({super.key});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late String messageText;
  final messageTextContoller=TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentUser();
  }
  void getCurrentUser()async{
    try{
      if(_auth!=null){
        loggedinUser=_auth.currentUser!;
        print(loggedinUser.email);
      }
    }
    catch(e){
      log(e.toString());
    }

  }
    void MessageStream() async{
    await for(var snapshots in _firestore.collection('messages').snapshots()){
      for(var message in snapshots.docs){
        log((message.data()).toString());
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
              icon: const Icon(Icons.close),
              onPressed: () {
                MessageStream();
                _auth.signOut();
                Navigator.pop(context);
              }),
        ],
        title: const Text('⚡️Chat'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const MessagesStream(),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: messageTextContoller,
                      onChanged: (value) {
                        messageText=value;
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      messageTextContoller.clear();
                      _firestore.collection('messages').add({
                        'text':messageText,
                        'sender':loggedinUser.email
                      });
                      //Implement send functionality.
                    },
                    child: const Text(
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

class MessageBubble extends StatelessWidget {
  MessageBubble({super.key, required this.messagetext,required this.sender,required this.isMe});
  late final String messagetext;
  late final String sender;
  bool isMe;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: isMe?CrossAxisAlignment.end:CrossAxisAlignment.start,
        children: [
          Text(sender),
          Material(
            borderRadius:isMe?const BorderRadius.only(topLeft: Radius.circular(30),bottomRight: Radius.circular(30),bottomLeft: Radius.circular(30)):const BorderRadius.only(topRight: Radius.circular(30),bottomRight: Radius.circular(30),bottomLeft: Radius.circular(30)),
            elevation: 5,

            color: isMe?Colors.lightBlueAccent:Colors.white,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 20),
                child: Text(messagetext,
                style: const TextStyle(
                  fontSize: 15
                ),),
              ),),
        ],
      ),
    );

  }
}

class MessagesStream extends StatelessWidget {
  const MessagesStream({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection('messages').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {return const Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.lightBlue,
            ),
          );}
          final messages = snapshot.data?.docs.reversed;
          List<MessageBubble> messageBubbles = [];
          for (var message in messages!) {
            var data = message.data() as Map;
            final currentuser=loggedinUser.email;
            final messageText = data['text'];
            final messageSender= data['sender'];
            final messageBubble =MessageBubble(messagetext: messageText, sender: messageSender,isMe: currentuser==messageSender,);
            messageBubbles.add(messageBubble);

          }
          return Expanded(
            child: ListView(
              reverse: true,
              children: messageBubbles,
            ),
          );

        });
  }
}

