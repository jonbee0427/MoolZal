import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:moolzal/database.dart';
import 'package:moolzal/message.dart';

class ChatPage extends StatefulWidget {
  final String postId;
  final String title;

  const ChatPage({Key? key, required this.postId, required this.title})
      : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final String uid = FirebaseAuth.instance.currentUser!.uid.toString();
  final String name = FirebaseAuth.instance.currentUser!.displayName.toString();
  final _controller = TextEditingController();
  final ScrollController scrollController = new ScrollController();

  @override
  void initState() {
    addMember();
    super.initState();
  }

  Future<void> addMember () async {
    final CollectionReference postCollection =
    FirebaseFirestore.instance.collection('posts');
    DocumentReference postRef = postCollection.doc(widget.postId);
    await postRef.update({
      'members': FieldValue.arrayUnion([uid + '_' + name]),
    });
  }

  Widget readMessage(String postId) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('posts')
            .doc(postId)
            .collection('messages')
            .orderBy('time', descending: false)
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
                  padding: EdgeInsets.only(bottom: 80),
                  reverse: false,
                  controller: scrollController,
                  itemCount: messageNum,
                  itemBuilder: (context, index) {
                    return MessageTile(
                      message: message[index]['message'],
                      sender: message[index]['sender'],
                      time: message[index]['time'],
                      photo: message[index]['photo'],
                      sentByMe: name == message[index]['sender'],
                    );
                  });
            }
          }
          return const Center(child: Text('No messages found'));
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.title),
        backgroundColor: Colors.deepPurple,
        actions: <Widget>[
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/voicecall');
              },
              icon: Icon(Icons.call)),
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(5.0),
        // decoration: BoxDecoration(border: Border.all(color: Colors.black)),
        child: Stack(children: <Widget>[
            readMessage(widget.postId),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                decoration: BoxDecoration(
                  //border: Border.all(width: 2, color: Colors.deepPurple),
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 3,
                      blurRadius: 5,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                  color: Colors.white,
                ),
                padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
                child: Row(
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
                            Database(uid: uid).sendMessage(
                                widget.title, _controller.text, widget.postId);
                            _controller.clear();
                            Timer(
                                Duration(milliseconds: 100),
                                () => scrollController.jumpTo(
                                    scrollController.position.maxScrollExtent));
                          },
                          icon: Icon(Icons.send))
                    ],

                ),
              ),
            )
        ]),
      ),
      // bottomNavigationBar: BottomAppBar(
      //   color: Colors.transparent,
      //   child: Container(
      //     padding: EdgeInsets.all(5.0),
      //     child: Row(
      //       crossAxisAlignment: CrossAxisAlignment.end,
      //       children: [
      //         Expanded(
      //           child: TextFormField(
      //             controller: _controller,
      //             decoration: const InputDecoration(
      //               hintText: '메세지를 입력하세요',
      //             ),
      //             validator: (value) {
      //               if (value == null || value.isEmpty) {
      //                 return 'Enter your message to continue';
      //               }
      //               return null;
      //             },
      //           ),
      //         ),
      //         const SizedBox(width: 8),
      //         IconButton(
      //             onPressed: () {
      //               Database(uid: uid).sendMessage(
      //                   widget.title, _controller.text, widget.postId);
      //               _controller.clear();
      //               Timer(
      //                   Duration(milliseconds: 100),
      //                   () => scrollController
      //                       .jumpTo(scrollController.position.maxScrollExtent));
      //             },
      //             icon: Icon(Icons.send))
      //       ],
      //     ),
      //   ),
      //   elevation: 0,
      // ),
    );
  }
}
