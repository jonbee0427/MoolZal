import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:moolzal/database.dart';

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final String uid = FirebaseAuth.instance.currentUser!.uid.toString();
  final String name = FirebaseAuth.instance.currentUser!.displayName.toString();
  final _controller = TextEditingController();

  final Widget _readMessage = StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('posts')
          .doc('Det0bZkmIBVbUyrrc9IuTOwplRk1')
          .collection('messages')
          .orderBy('sentTime', descending: false)
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        List<DocumentSnapshot> message;
        var messageNum = 0;

        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loading");
        }
        if (snapshot.hasData) {
          message = snapshot.data!.docs;
          messageNum = message.length;

          if (messageNum > 0) {
            return ListView.builder(
                itemCount: messageNum,
                itemBuilder: (context, index) {
                  return Text(message[index]['message']);
                });
          }
        }
        return const Center(child: Text('No messages found'));
      });

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('채팅'),
          automaticallyImplyLeading: false,
        ),
        body: Container(
          padding: EdgeInsets.all(20.0),
          child: Stack(
            children: <Widget>[
              _readMessage,
              Container(
                alignment: Alignment.bottomCenter,
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.blue)),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _controller,
                        decoration: const InputDecoration(
                          hintText: '메세지를 입력하세요',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Enter your message to continue';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(width: 8),
                    IconButton(
                        onPressed: () {
                          Database(uid: uid).sendMessage(_controller.text);
                          _controller.clear();
                        },
                        icon: Icon(Icons.send))
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
