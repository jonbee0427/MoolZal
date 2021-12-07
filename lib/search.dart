import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class search extends StatefulWidget {
  @override
  _searchState createState() => _searchState();
}

class _searchState extends State<search> {
  String name = "";
  String name2 = "";
  final String fnTitle = "title";
  final String fnBody = "body";
  final String fnDatetime = "datetime";
  final String fnUid = 'writer_uid';
  final String check = "0";
  final String fnTime = "time";
  final String fnWriter = "writer";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Card(
          child: TextField(
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.search), hintText: 'Search...'),
            onChanged: (val) {
              setState(() {
                name = val;
              });
            },
          ),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: (name != "" && name != null)
            ? FirebaseFirestore.instance
            .collection('posts')
            .where("title", isGreaterThanOrEqualTo: name)
            .snapshots()
            : FirebaseFirestore.instance.collection("items").snapshots(),
        builder: (context, snapshot) {
          return (snapshot.connectionState == ConnectionState.waiting)
              ? Center(child: CircularProgressIndicator())
              : ListView(
            children: snapshot.data!.docs
                .map((DocumentSnapshot document) {
              //Timestamp ts = document[fnDatetime];
              return Card(
                elevation: 2,
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
              );
            }).toList(),
          );
        },
      ),
    );
  }

}