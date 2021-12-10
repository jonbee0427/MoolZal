import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:moolzal/text_result.dart';
import 'package:moolzal/update.dart';
import 'package:moolzal/chat.dart';

class PostDetail extends StatefulWidget {
  final String writer;
  final String writer_uid;
  final String title;
  final String body;
  final String time;
  final String postId;

  PostDetail({
    required this.writer,
    required this.writer_uid,
    required this.title,
    required this.body,
    required this.time,
    required this.postId,
  });

  @override
  _PostDetailState createState() => _PostDetailState();
}

class _PostDetailState extends State<PostDetail> {
  User? currentUser;
  String? currentUid;

  @override
  initState() {
    super.initState();
    imageFromStorage();
    getCurrrentUser();
    //fileDownload(widget.groupName, widget.admin);
  }

  List<dynamic> images = [];

  imageFromStorage() async {
    String path = '${widget.writer}/' + '${widget.title}/';
    Reference storage = FirebaseStorage.instance.ref().child(path);
    print('Current post : ' + path);
    storage.listAll().then((value) async {
      value.items.forEach((element) async {
        await element.getDownloadURL().then((value) {
          print('Current value  : ' + value);
          setState(() {
            images.add(value);
          });
        });
      });
    });
  }

  getCurrrentUser() {
    currentUser = FirebaseAuth.instance.currentUser;
    currentUid = currentUser!.uid;
  }

  Future<void> deletePost() {
    CollectionReference postCollection = FirebaseFirestore.instance.collection('posts');
    return postCollection
        .doc(widget.postId)
        .delete()
        .then((value) => print("Post deleted!"))
        .catchError((error) => print("Failed to delete user: $error"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('게시글 상세 정보'),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => ChatPage(title: widget.title, postId: widget.postId)));
              },
              icon: Icon(Icons.message))
        ],
      ),
      body: ListView(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                constraints:
                    BoxConstraints(maxWidth: MediaQuery.of(context).size.width),
                padding: const EdgeInsets.only(top: 10, left: 25),
                child: Text(
                  widget.title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                  // overflow: TextOverflow.ellipse,
                ),
              ),
              Column(
                children: [
                  Container(
                    alignment: Alignment.topRight,
                    padding: const EdgeInsets.only(right: 15),
                    child: Text(
                      widget.writer,
                      style: TextStyle(
                        fontSize: 15,
                      ),
                      // overflow: TextOverflow.ellipse,
                    ),
                  ),
                  Container(
                    alignment: Alignment.topRight,
                    padding: const EdgeInsets.only(right: 15),
                    child: Text(
                      widget.time,
                      style: TextStyle(
                        fontSize: 15,
                      ),
                      // overflow: TextOverflow.ellipse,
                    ),
                  ),
                ],
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.875,
                //height: MediaQuery.of(context).size.height * 0.9,
                constraints: BoxConstraints(
                    minHeight: MediaQuery.of(context).size.width * 0.4),
                margin: const EdgeInsets.only(
                    top: 30, left: 25, right: 15, bottom: 10),
                padding: const EdgeInsets.only(
                    top: 15, left: 15, right: 15, bottom: 15),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 3),
                  borderRadius: BorderRadius.all(
                    Radius.circular(40),
                  ),
                ),
                child: Container(
                  //mainAxisAlignment: MainAxisAlignment.start,
                  child: Text(
                    widget.body,
                    style: TextStyle(
                      fontSize: 16,
                    ),
                    overflow: TextOverflow.visible,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          images.length != 0
              ? Container(
                  margin: EdgeInsets.only(left: 25),
                  height: 150,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: images.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => ResultPage(path: images[index])));
                        },
                        child: Container(
                          margin: EdgeInsets.only(right: 10),
                          height: 150,
                          width: 150,
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                              border: Border.all(color: Colors.grey),
                              image: DecorationImage(
                                  image: NetworkImage(images[index]))),
                        ),
                      );
                    },
                  ),
                )
              : Container(),
          SizedBox(
            height: 40,
          ),
          widget.writer_uid == currentUid
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      //width: double.infinity,
                      height: 50.0,
                      child: OutlinedButton(
                          child: Text('게시글 수정',
                              style: TextStyle(
                                  color: Colors.black, fontSize: 16.0)),
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(width: 2.0, color: Colors.grey),
                          ),
                          onPressed: () {
                            print('Post updated!');
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => UpdatePost(
                                writer: widget.writer,
                                writer_uid: widget.writer_uid,
                                title: widget.title,
                                body: widget.body,
                                time: widget.time,
                                postId: widget.postId,
                                ))
                            );
                          }),
                    ),
                    SizedBox(width: 20,),
                    SizedBox(
                      //width: double.infinity,
                      height: 50.0,
                      child: OutlinedButton(
                          child: Text('게시글 삭제',
                              style: TextStyle(
                                  color: Colors.black, fontSize: 16.0)),
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(width: 2.0, color: Colors.grey),
                          ),
                          onPressed: () {
                            deletePost();
                            Navigator.pop(context);
                            print('Post deleted!');
                          }),
                    ),
                  ],
                )
              : Row(),
          SizedBox(
            height: 30,
          ),
        ],
      ),
      bottomNavigationBar: null,
    );
  }
}