import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:moolzal/database.dart';

class AddPost extends StatefulWidget {
  @override
  _AddPostState createState() => _AddPostState();
}

List<String> path = [];

class _AddPostState extends State<AddPost> {
  final _titleController = TextEditingController();
  final _bodyController = TextEditingController();
  final String uid = FirebaseAuth.instance.currentUser!.uid.toString();

  @override
  void initState() {
    super.initState();
    path = [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('글 작성'),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                border: UnderlineInputBorder(),
                labelText: '제목',
              ),
              controller: _titleController,
            ),
            TextField(
              decoration: InputDecoration(
                border: UnderlineInputBorder(),
                labelText: '내용',
              ),
              controller: _bodyController,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: TextButton(
                child: Text('작성 완료'),
                onPressed: () async {
                  Database(uid: uid).savePost(_titleController.text, _bodyController.text, path);
                  Navigator.pushNamed(context, '/layout');
                  print('post added!');
                }
              ),
            )
          ],
        ),
        ),
    );
  }
}
