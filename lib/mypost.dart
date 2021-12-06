import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';


class mypost extends StatelessWidget {
   mypost({Key? key}) : super(key: key);

   // 컬렉션명
   final String colName = "posts";

   // 필드명
   final String fnTitle = "title";
   final String fnBody = "body";
   final String fnDatetime = "datetime";
   final String fnUid = 'writer_uid';
   final String check = "0";
   final String fnTime = "time";
   final String fnWriter = "writer";


  @override
  Widget build(BuildContext context) {
    FirebaseAuth.instance
        .authStateChanges()
        .listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in!');
      }
    });
    final user = FirebaseAuth.instance.currentUser;
    final uid = user?.uid;
    return Scaffold(
      appBar: AppBar(
        title: Text('mypost Page'),
        backgroundColor: Colors.deepPurple,
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.search,
            ),
            onPressed: () {
              //Navigator.pop(context);
              // 서치로 가기?
              Navigator.pushNamed(context, '/search');
            },
          ),
        ],
      ),
      body: ListView(
        children: <Widget>[
          Container(
            height: 500,
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection(colName)
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) return Text("Error: ${snapshot.error}");
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return Text("Loading...");
                  default:
                    return ListView(
                      children: snapshot.data!.docs
                          .map((DocumentSnapshot document) {
                        //Timestamp ts = document[fnDatetime];
                        return Card(
                          elevation: 2,
                          child: document[fnUid] == uid ? InkWell(
                            // Read Document
                            child:
                            Container(
                              padding: const EdgeInsets.all(8),
                              child: Column(
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment:MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(
                                        document[fnTitle],
                                        style: TextStyle(
                                          color: Colors.blueGrey,
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        //데이터 베이스에 게시글이 작성된 시간을 받아서 넣을것
                                        document[fnTime],
                                        style:
                                        TextStyle(color: Colors.grey[600]),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      document[fnBody],
                                      style: TextStyle(color: Colors.black54),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ): new Container()
                        );
                      }).toList(),
                    );
                }
              },
            ),
          )
        ],
      ),
    );
  }
}