import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:moolzal/gridforpost.dart';
import 'package:moolzal/login.dart';
import 'package:moolzal/listforpost.dart';
import 'package:firebase_auth/firebase_auth.dart';

class mycomment extends StatefulWidget {
  @override
  _mycommentState createState() => _mycommentState();
}

class _mycommentState extends State<mycomment> {
  int _value = 1;
  String name = FirebaseAuth.instance.currentUser!.displayName.toString();

  Widget gridviewforPost = new StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('comments')
          .where("comment_writer", isEqualTo:FirebaseAuth.instance.currentUser!.displayName.toString())
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return new Text('Error in receiving trip photos: ${snapshot.error}');
        }

        var ImagesCount = 0;
        List<DocumentSnapshot> itemImages;

        if (snapshot.hasData) {
          itemImages = snapshot.data!.docs;
          ImagesCount = itemImages.length;

          if (ImagesCount > 0) {
            return new GridView.builder(
                itemCount: ImagesCount,
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                primary: false,
                gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemBuilder: (BuildContext context, int index) {
                  return GridTileforPost(
                    writer: itemImages[index]['writer'],
                    writer_uid: itemImages[index]['writer_uid'],
                    title: itemImages[index]['title'],
                    body: itemImages[index]['comment'],
                    time: itemImages[index]['time'],
                    postId: itemImages[index]['postId'],
                  );
                });
          }
        }
        return Container(
          child: new Text("No item images found."),
        );
      });

  Widget listviewforPost = new StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('comments')
          .where("comment_writer", isEqualTo:FirebaseAuth.instance.currentUser!.displayName.toString())
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return new Text('Error in receiving trip photos: ${snapshot.error}');
        }

        var PostsCount = 0;
        List<DocumentSnapshot> itemImages;

        if (snapshot.hasData) {
          itemImages = snapshot.data!.docs;
          PostsCount = itemImages.length;

          if (PostsCount > 0) {
            return new ListView.builder(
                itemCount: PostsCount,
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                primary: false,
                itemBuilder: (BuildContext context, int index) {
                  return ListTileforPost(
                    writer: itemImages[index]['writer'],
                    writer_uid: itemImages[index]['writer_uid'],
                    title: itemImages[index]['title'],
                    body: itemImages[index]['comment'],
                    time: itemImages[index]['time'],
                    postId: itemImages[index]['postId'],
                  );
                });
          }
        }
        return Container(
          child: new Text("No posts found."),
        );
      });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Text('나의 댓글'),
        backgroundColor: Colors.deepPurple,
      ),
      body: SingleChildScrollView(
        child : Column(
          children: [
            Container(
              padding: EdgeInsets.all(30),
              child:DropdownButton(
                value: _value,
                items: [
                  DropdownMenuItem(
                    child: Text("List"),
                    value: 1,
                  ),
                  DropdownMenuItem(
                    child: Text("Grid"),
                    value: 2,
                  )
                ],
                onChanged: (int ? value) {
                  setState(() {
                    _value = value!;
                  });
                },
              ),
            ),
            _value == 1 ? listviewforPost : gridviewforPost,
          ],
        ),
      ),
    );
  }
}
