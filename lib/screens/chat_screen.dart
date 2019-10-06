import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat/screens/welcome_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final _firestore = Firestore.instance;

class ChatScreen extends StatefulWidget {
  static const String id = 'chat_screen';
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final messageTextEditingController   = TextEditingController();
  final _auth = FirebaseAuth.instance;
  FirebaseUser loggedInUser;
  String messageText;
  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }
  void getCurrentUser() async {
    try{
    final user = await _auth.currentUser();
    if(user != null){
      loggedInUser = user;
      print(loggedInUser.email);
    }}
    catch(e){
      print(e);
    }
  }
//


  void messagesStream()async{
    await for(var snapshots in _firestore.collection('messages').snapshots()){
        for(var messages in snapshots.documents){
          print(messages.data);
        }
    }
  }



  static const String id = 'chat_screen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          FlatButton(
            onPressed: (){
              messagesStream();
//              _auth.signOut();
//              Navigator.pushNamed(context, WelcomeScreen.id);
            },
            child: Text("Logout",style: TextStyle(color: Colors.white,
                fontSize: 18),),
          )
//          IconButton(
//              icon: Icon(Icons.close),
//
//              onPressed: () {
//                //Implement logout functionality
//              }),
        ],
        title: Text('                   Chats',textAlign: TextAlign.center),
        backgroundColor: Color(0xFF3DDC84),
      ),
      body: SafeArea(
        child: Column(

          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
           MessageStream(),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: messageTextEditingController,
                      onChanged: (value) {
                        messageText = value;
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  FlatButton(
                    onPressed: () {
                      messageTextEditingController.clear();
                      //Implement send functionality.
                      _firestore.collection('messages').add
                        ({'Text': messageText,'sender': loggedInUser.email });
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
class MessageStream extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  StreamBuilder<QuerySnapshot>(
      stream: _firestore.collection('messages').snapshots(),
      builder: (context, snapshot){
        if(!snapshot.hasData){
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.lightBlueAccent,
            ),
          );
        }
        final messages = snapshot.data.documents;

        List<MessageBubble> messageBubbles = [];
        for(var message in messages){
          final messageText = message.data['Text'];

          final messageSender = message.data['sender'];

          final messageBubble = MessageBubble(sender: messageSender,
              text: messageText);
          messageBubbles.add(messageBubble);
        }
        return Expanded(
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 10.0,vertical:
            20.0),
            children: messageBubbles,
          ),
        );

      },
    );
  }
}


class MessageBubble extends StatelessWidget {
  MessageBubble({ @required this.sender,this.text});
  final String sender;
  final String text;
  @override
  Widget build(BuildContext context) {
    
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Text(sender,style: TextStyle(
            fontSize: 12.0,
            color: Colors.black54,

          ),),
          Material(

            borderRadius: BorderRadius.circular(30.0),
            elevation: 5.0,
            color: Color(0xFF3DDC84),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
              child: Text('$text ',style: TextStyle(
                color: Colors.white,
                  fontSize: 15
              ),),
            ),
          ),
        ],
      ),
    );
  }
}
