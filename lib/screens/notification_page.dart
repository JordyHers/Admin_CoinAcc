import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class NotificationPage extends StatefulWidget {
  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  List<Message> _messages;


  _setMessage(Map<String, dynamic> message) {
    final notification = message['notification'];
    final String title = notification['title'];
    final data = message['data'];
    final String body = notification['body'];
    String mMessage = data['message'];
    print("Title: $title, body: $body, message: $mMessage");
    setState(() {
      Message msg = Message(title, body,mMessage);
      _messages.add(msg);
    });
  }
  _configureFirebaseListeners() {
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print('onMessage: $message');
        _setMessage(message);
      },
      onLaunch: (Map<String, dynamic> message) async {
        print('onLaunch: $message');
        _setMessage(message);
      },
      onResume: (Map<String, dynamic> message) async {
        print('onResume: $message');
        _setMessage(message);
      },
    );
    _firebaseMessaging.requestNotificationPermissions(
      const IosNotificationSettings(sound: true, badge: true, alert: true),
    );
  }

  getToken() {
    _firebaseMessaging.getToken().then((token) {
      print("Device Token: $token");
    });
  }


  @override
  void initState() {
    super.initState();
    _messages =List<Message>();
   getToken();
   _configureFirebaseListeners();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal[50],
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.grey[300],
        title: Text("Notifications",style: TextStyle(color: Colors.black,fontSize: 22,fontWeight: FontWeight.w600,fontFamily: 'Lobster'),),
      ),
      body: ListView.builder(
        itemCount: null == _messages ? 0 : _messages.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(

            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: Text(
                _messages[index].message,
                style: TextStyle(
                  fontSize: 21.0,
                  color: Colors.black,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}


class Message {
  String title;
  String body;
 String message;
  Message(title, body,message) {
    this.title = title;
    this.body = body;
    this.message =message;

  }
}
