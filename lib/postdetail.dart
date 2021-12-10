import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
  String? currentUserName;
  String? time;
  String? text;
  TextEditingController _commentController = TextEditingController();
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');
  final CollectionReference commentCollection =
      FirebaseFirestore.instance.collection('comments');

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  @override
  initState() {
    super.initState();
    imageFromStorage();
    getCurrrentUser();
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
    currentUserName = FirebaseAuth.instance.currentUser!.displayName.toString();
  }

  Future<void> deletePost() {
    CollectionReference postCollection =
        FirebaseFirestore.instance.collection('posts');
    return postCollection
        .doc(widget.postId)
        .delete()
        .then((value) => print("Post deleted!"))
        .catchError((error) => print("Failed to delete user: $error"));
  }

  Future<void> deletePostinUser() async {
    CollectionReference userCollection =
        FirebaseFirestore.instance.collection('users');
    DocumentReference userDocRef = userCollection.doc(widget.writer_uid);
    String deletedArray =
        widget.postId + '_' + widget.title + '_' + widget.time;
    return await userDocRef.update({
      'posts': FieldValue.arrayRemove([deletedArray]),
    });
  }

  Future addComment() async {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd HH:mm').format(now);
    FirebaseFirestore.instance.collection('comments').doc(widget.postId).set({
      'post_uid': widget.postId,
      'comment': text,
      'comment_writer': currentUserName,
      'title': widget.title,
      'time': formattedDate,
    },).then((value) => print("Comment added!"));

    DocumentReference userDocRef = userCollection.doc(currentUid);
    return await userDocRef.update({
      'comments': FieldValue.arrayUnion(
          [widget.postId + '_' + text! + '_' + formattedDate])
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('게시글 상세 정보'),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ChatPage(
                            title: widget.title, postId: widget.postId)));
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
                                  builder: (_) =>
                                      ResultPage(path: images[index])));
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
          Padding(
            padding: const EdgeInsets.only(top: 10, left: 25),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: _commentController,
                    cursorColor: Colors.deepPurple,
                    decoration: InputDecoration(
                      hintText: '댓글을 입력하세요 :)',
                      border: UnderlineInputBorder(
                        borderSide:
                            BorderSide(width: 1, color: Colors.deepPurple),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(
                    Icons.send,
                    color: Colors.deepPurple,
                  ),
                  onPressed: () {
                    text = _commentController.text;
                    addComment();
                    _commentController.clear();
                    print('Comment added!');
                  },
                ),
              ],
            ),
          ),
          StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('comments')
                  .orderBy(('time'), descending: true)
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                List<DocumentSnapshot> comment;
                var commentNum = 0;

                if (snapshot.hasError) {
                  return const Text('Something went wrong');
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Text("Loading");
                }
                if (snapshot.hasData) {
                  comment = snapshot.data!.docs;
                  commentNum = comment.length;

                  if (commentNum > 0) {
                    return ListView.builder(
                        itemCount: commentNum,
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        primary: false,
                        itemBuilder: (context, index) {
                          return commentTile(
                            comment: comment[index]['comment'],
                            comment_writer: comment[index]['comment_writer'],
                            time: comment[index]['time'],
                            title: comment[index]['title'],
                            docId: snapshot.data!.docs[index].id,
                            postId: widget.postId,
                            uid: currentUid!,
                            writer_uid: widget.writer_uid,
                          );
                        });
                  }
                }
                return Container(
                  padding: const EdgeInsets.only(top: 10, left: 25),
                  child: new Text("No comments found"),
                );
              }),
          SizedBox(
            height: 30,
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
                                    )));
                          }),
                    ),
                    SizedBox(
                      width: 20,
                    ),
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
                            deletePostinUser();
                            print('Post deleted!');
                            Navigator.pop(context);
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

class commentTile extends StatelessWidget {
  final String comment;
  final String comment_writer;
  final String title;
  final String time;
  final String docId;
  final String postId;
  final String uid;
  final String writer_uid;

  commentTile({
    required this.comment,
    required this.comment_writer,
    required this.title,
    required this.time,
    required this.docId,
    required this.postId,
    required this.uid,
    required this.writer_uid,
  });


  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');
  final CollectionReference commentCollection =
      FirebaseFirestore.instance.collection('comments');
  User ? currentUser;
  String? currentUid;

  initialize() {
    currentUser = FirebaseAuth.instance.currentUser;
    currentUid = currentUser!.uid;
  }

  Future<void> deleteComment() {
    CollectionReference postCollection =
        FirebaseFirestore.instance.collection('comments');
    return postCollection
        .doc(docId)
        .delete()
        .then((value) => print("Comment deleted!"))
        .catchError((error) => print("Failed to delete comment: $error"));
  }

  Future deleteCommentinUser() async {
    DocumentReference userDocRef = userCollection.doc(uid);
    return await userDocRef.update({
      'comments': FieldValue.arrayRemove([postId + '_' + comment + '_' + time])
    });
  }

  Future<String> getCurrentPostId() async {
    DocumentReference doc_ref = FirebaseFirestore.instance.collection("posts").doc();
    DocumentSnapshot docSnap = await doc_ref.get();
    String doc_id2 = docSnap.reference.id;
    return doc_id2;
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final ProfileImage = user?.photoURL;
    //String currentDocId = getCurrentPostId();

    return docId == postId ? ListTile(
      leading: CircleAvatar(
        radius: 20,
        backgroundImage: NetworkImage(ProfileImage!, scale: 10),
      ),
      title: Text(
        comment_writer,
      ),
      subtitle: Text(
        comment + '\n' + time,
        style: TextStyle(fontSize: 17),
      ),
      trailing: IconButton(
        icon: Icon(Icons.delete_forever),
        onPressed: () {
          if (uid == writer_uid) {
            deleteComment();
            deleteCommentinUser();
            print('Comment deleted!');
          }
        },
      ),
    ) : Container();
  }
}
