import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:moolzal/gridforpost.dart';
import 'package:moolzal/login.dart';
import 'package:moolzal/listforpost.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _value = 1;

  Widget gridviewforPost = new StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('posts').snapshots(),
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
                    body: itemImages[index]['body'],
                    time: itemImages[index]['time'],
                  );
                });
          }
        }
        return Container(
          child: new Text("No item images found."),
        );
      });

  Widget listviewforPost = new StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('posts').snapshots(),
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
                    body: itemImages[index]['body'],
                    time: itemImages[index]['time'],
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
        centerTitle: true,
        title: Text('MoolZal'),
        automaticallyImplyLeading: false,
        actions: <Widget>[
          IconButton(
              onPressed: () {
                GoogleSignIn().signOut();
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                    builder: (BuildContext context) =>
                        LoginPage()), (route) => false);
              },
              icon: Icon(Icons.exit_to_app)),
        ],
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
                    child: Text("Grid"),
                    value: 1,
                  ),
                  DropdownMenuItem(
                    child: Text("List"),
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
            _value == 1 ? gridviewforPost : listviewforPost ,
          ],
        ),
      ),
    );
  }
}
