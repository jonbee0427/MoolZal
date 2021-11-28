import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:moolzal/postdetail.dart';

class GridTileforPost extends StatelessWidget {
  final String writer;
  final String writer_uid;
  final String title;
  final String body;
  final String time;

  GridTileforPost({
    required this.writer,
    required this.writer_uid,
    required this.title,
    required this.body,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => PostDetail(
                  writer: writer,
                  writer_uid: writer_uid,
                  title: title,
                  body: body,
                time: time,)));
      },
      child: Card(
        clipBehavior: Clip.antiAlias,
        child:
        Column(
          children: <Widget>[
            // AspectRatio(
            //   aspectRatio: 18 / 11,
            //   child: Image.network(
            //     itemImages[index]['photo'],
            //     fit: BoxFit.fill,
            //   ),
            // ),
          Container(
                alignment: Alignment.bottomLeft,
                padding: const EdgeInsets.only(top: 50),
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 5.0),
                    Text(
                      title,
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                      maxLines: 2,
                    ),
                    Text(
                      body,
                      style: TextStyle(fontSize: 15),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
