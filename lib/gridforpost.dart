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

  String? url;

  imageFromStorage() {
    String path = '${widget.writer}/' + '${widget.title}/';
    Reference storage = FirebaseStorage.instance.ref().child(path);
    storage.listAll().then((value) {
      value.items.forEach((element) {
        element.getDownloadURL().then((value) {
          print('Image url  : ' + value);
          if (mounted) {
            setState(() {
              url = value;
            });
          }
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
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            url != null
                ? AspectRatio(
                aspectRatio: 16 / 9,
                child: Image.network(url!, fit: BoxFit.fill))
                : AspectRatio(
                aspectRatio: 16 / 9,
                child: Image.asset("moolzal.png", fit: BoxFit.fill)),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.title,
                          style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                          maxLines: 1,
                        ),
                        Text(
                          widget.body,
                          style: TextStyle(fontSize: 15),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.width*0.02,),
                  Align(
                      alignment: Alignment.bottomRight,
                      child: Text(
                        widget.time,
                        style: TextStyle(fontSize: 12),
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}