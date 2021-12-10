import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:moolzal/postdetail.dart';

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

  String ? url;


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
                prefixIcon: Icon(Icons.search), hintText: 'Search...',),

            onChanged: (val) {
              setState(() {
                name = val;
              });
            },
          ),
        ),
        backgroundColor: Colors.deepPurple,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: (name != "" && name != null)
            ? FirebaseFirestore.instance
            .collection('posts')
            .where("title")
            .snapshots()
            : FirebaseFirestore.instance.collection("items").snapshots(),
        builder: (context, snapshot) {
          return (snapshot.connectionState == ConnectionState.waiting)
              ? Center(child: CircularProgressIndicator())
              : ListView(

            children: snapshot.data!.docs.where((a) => a['title'].contains(name))
                .map((DocumentSnapshot document) {
              //Timestamp ts = document[fnDatetime];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              PostDetail(
                                writer: document['writer'],
                                writer_uid: document['writer_uid'],
                                title: document['title'],
                                body: document['body'],
                                time: document['time'],
                                postId: document['postId'],)));
                },
                child: Column(
                  children: [
                    Container(
                      child: ListTile(
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        child: Container(
                                          constraints: BoxConstraints(
                                              maxWidth:
                                              MediaQuery
                                                  .of(context)
                                                  .size
                                                  .width *
                                                  0.6),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                document['title'],
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.bold),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              Text(
                                                document['body'],
                                                style:
                                                TextStyle(
                                                    color: Colors.grey, fontSize: 14),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              Text(document['time'], style:
                                              TextStyle(
                                                  color: Colors.grey, fontSize: 14),),
                                            ],
                                          ),
                                        ),
                                      ),

                                      url != null ?
                                      Expanded(
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                            Container(
                                              margin: EdgeInsets.only(right: 10),
                                              height: 50,
                                              width: 50,
                                              decoration: BoxDecoration(
                                                // borderRadius:
                                                // BorderRadius.all(Radius.circular(10.0)),
                                                //border: Border.all(color: Colors.grey),
                                                  image: DecorationImage(
                                                      image: NetworkImage(url!))),
                                            )
                                          ],
                                        ),
                                      ) : Container(),
                                      // Expanded(
                                      //   child: Row(
                                      //     mainAxisAlignment: MainAxisAlignment.end,
                                      //     children: [
                                      //       Container(
                                      //         child: Text(widget.time, ),
                                      //       )
                                      //     ],
                                      //   ),
                                      // ),
                                    ],
                                  ),

                                  Divider(
                                    thickness: 1,
                                    color: Colors.grey,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }

}