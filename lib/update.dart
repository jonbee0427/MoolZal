import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:moolzal/database.dart';

class UpdatePost extends StatefulWidget {
  String writer;
  String writer_uid;
  String title;
  String body;
  String time;
  String postId;

  UpdatePost({
    required this.writer,
    required this.writer_uid,
    required this.title,
    required this.body,
    required this.time,
    required this.postId,
  });

  @override
  _UpdatePostState createState() => _UpdatePostState();
}

List<String> path = [];
List<String> images = [];
int maxImg = 0;
ImagePicker picker = ImagePicker();
XFile? image;

class _UpdatePostState extends State<UpdatePost> {
  final _titleController = TextEditingController();
  final _bodyController = TextEditingController();
  final String uid = FirebaseAuth.instance.currentUser!.uid.toString();

  Future<void> pickImage() async {
    XFile? newImage = await picker.pickImage(source: ImageSource.gallery);
    if (maxImg <= 7) {
      setState(() {
        images.add(newImage!.path);
        print('image path : ');
        print(newImage.path);
        image = newImage;
        maxImg++;
      });
    }
  }

  Future<void> updatePost() {
    widget.title = _titleController.text;
    widget.body = _bodyController.text;
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd kk:mm').format(now);
    widget.time = formattedDate;

    CollectionReference postCollection =
        FirebaseFirestore.instance.collection('posts');
    return postCollection
        .doc(widget.postId)
        .update({
          'title': widget.title,
          'body': widget.body,
          'time': widget.time,
        })
        .then((value) => print("Post Updated"))
        .catchError((error) => print("Failed to update user: $error"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('??? ??????'),
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: ListView(
          children: [
            Column(
              children: [
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
                  child: TextField(
                    cursorColor: Colors.black,
                    decoration: InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: '??????',
                    ),
                    controller: _titleController,
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 30.0),
                  child: TextField(
                    maxLines: 20,
                    minLines: 15,
                    cursorColor: Colors.black,
                    decoration: InputDecoration(
                      labelText: '??????',
                      hintText: widget.body,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                    ),
                    controller: _bodyController,
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 30.0),
                  child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(width: 2.0, color: Colors.grey),
                      ),
                      child: Text('????????? ?????????',
                          style:
                              TextStyle(color: Colors.black, fontSize: 16.0)),
                      onPressed: () {
                        pickImage();
                        print('image uploaded');
                      }),
                ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  child: maxImg != 0
                      ? Container(
                          padding: EdgeInsets.symmetric(horizontal: 30.0),
                          width: 250,
                          height: 200,
                          child: maxImg != 0
                              ? Swiper(
                                  key: UniqueKey(),
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Image.file(
                                      File(images[index]),
                                    );
                                  },
                                  itemCount: images.length,
                                  autoplayDisableOnInteraction: true,
                                  pagination: new SwiperPagination(
                                    alignment: Alignment.bottomCenter,
                                    builder: new DotSwiperPaginationBuilder(
                                      color: Colors.grey,
                                      activeColor: Colors.grey,
                                    ),
                                  ),
                                  control: new SwiperControl(
                                    color: Colors.grey,
                                  ),
                                )
                              : null,
                        )
                      : null,
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 30.0, vertical: 30.0),
                  child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(width: 2.0, color: Colors.grey),
                      ),
                      child: Text(
                        '?????? ??????',
                        style: TextStyle(fontSize: 17, color: Colors.black),
                      ),
                      onPressed: () async {
                        updatePost(); //????????? ??????
                        for (int i = 0; i < images.length; i++) {
                          Database(uid: uid).uploadFile(
                              _titleController.text, images[i]); //?????? ??????
                        }
                        Navigator.pushNamed(context, '/layout');
                      }),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
