import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:moolzal/postdetail.dart';

class GridTileforPost extends StatefulWidget {
  final String writer;
  final String writer_uid;
  final String title;
  final String body;
  final String time;
  final String postId;

  GridTileforPost({
    required this.writer,
    required this.writer_uid,
    required this.title,
    required this.body,
    required this.time,
    required this.postId,
  });

  @override
  _GridTileforPostState createState() => _GridTileforPostState();
}

class _GridTileforPostState extends State<GridTileforPost> {
  @override
  initState() {
    imageFromStorage();
    super.initState();
  }

  List<dynamic> images = [];

  imageFromStorage() {
    String path = '${widget.writer}/' + '${widget.title}/';
    Reference storage = FirebaseStorage.instance.ref().child(path);
    print('Current post : ' + path);
    storage.listAll().then((value) {
      value.items.forEach((element) {
        element.getDownloadURL().then((value) {
          print('Current value  : ' + value);
          setState(() {
            images.add(value);
          });
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => PostDetail(
                      writer: widget.writer,
                      writer_uid: widget.writer_uid,
                      title: widget.title,
                      body: widget.body,
                      time: widget.time,
                      postId: widget.postId,
                    )));
      },
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: Column(
          children: <Widget>[
            Container(
              alignment: Alignment.bottomLeft,
              //padding: const EdgeInsets.only(top: 50),
              child: Column(
                children: <Widget>[
                  SizedBox(height: 5.0),
                  Text(
                    widget.title,
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    maxLines: 2,
                  ),
                  Text(
                    widget.body,
                    style: TextStyle(fontSize: 15),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                   child: Text(widget.time),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            images[0] != null
                ? AspectRatio(
                    aspectRatio: 20 / 10,
                    child: Container(
                      margin: EdgeInsets.only(right: 10),
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                          // borderRadius:
                          // BorderRadius.all(Radius.circular(10.0)),
                          //border: Border.all(color: Colors.grey),
                          image:
                              DecorationImage(image: NetworkImage(images[0]))),
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
