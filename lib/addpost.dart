import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:moolzal/database.dart';

class AddPost extends StatefulWidget {
  @override
  _AddPostState createState() => _AddPostState();
}

List<String> path = [];
List<String> images = [];
int maxImg = 0;
ImagePicker picker = ImagePicker();
XFile? image;

class _AddPostState extends State<AddPost> {
  final _titleController = TextEditingController();
  final _bodyController = TextEditingController();
  final String uid = FirebaseAuth.instance.currentUser!.uid.toString();

  @override
  void initState() {
    super.initState();
    path = [];
    images = [];
  }

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('글 작성'),
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
                      labelText: '제목',
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
                      labelText: '내용',
                      hintText: '내용을 입력하세요.',
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
                      child: Text('이미지 업로드',
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
                        '작성 완료',
                        style: TextStyle(fontSize: 17, color: Colors.black),
                      ),
                      onPressed: () async {
                        Database(uid: uid)
                            .getDownloadURL(_titleController.text);
                        Database(uid: uid).savePost(_titleController.text,
                            _bodyController.text, path); //게시글 저장
                        for (int i = 0; i < images.length; i++) {
                          Database(uid: uid).uploadFile(
                              _titleController.text, images[i]); //사진 저장
                        }
                        Navigator.pushNamed(context, '/layout');
                        print('post added!');
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
