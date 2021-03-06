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
      stream: FirebaseFirestore.instance.collection('posts').orderBy(('time'), descending: true).snapshots(),
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
                    postId: itemImages[index]['postId'],
                  );
                });
          }
        }
        return Center(
          child: Container(
            child: Text("NO POSTS FOUND.", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
          ),
        );
      });

  Widget listviewforPost = new StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('posts').orderBy(('time'), descending: true).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return new Text('Error in receiving trip photos: ${snapshot.error}');
        }

        var PostsCount = 0;
        List<DocumentSnapshot> itemImages;

        if (snapshot.hasData) {
          itemImages = snapshot.data!.docs;
          PostsCount = itemImages.length;

          if (!snapshot.hasData)
            return Center(child: Text("Loading..."));

          if  (PostsCount > 0) {
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
                    postId: itemImages[index]['postId'],
                  );
                });
          }
        }
        return Center(
          child: Container(
            child: Text("NO POSTS FOUND.", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
          ),
        );
      });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('MoolZal'),
        backgroundColor: Colors.deepPurple,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
          ),
          onPressed: () {
            Navigator.pushNamedAndRemoveUntil(context, '/category', (route) => false);
          },
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.search,
            ),
            onPressed: () {
              //Navigator.pop(context);
              // ????????? ???????
              Navigator.pushNamed(context, '/search');
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child : Column(
          children: [
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(20),
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
            SizedBox(height: 20.0,),
          ],
        ),
      ),
    );
  }
}