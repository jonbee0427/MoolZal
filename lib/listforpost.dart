import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:moolzal/postdetail.dart';

class ListTileforPost extends StatefulWidget {
  final String writer;
  final String writer_uid;
  final String title;
  final String body;
  final String time;
  final String postId;

  ListTileforPost({
    required this.writer,
    required this.writer_uid,
    required this.title,
    required this.body,
    required this.time,
    required this.postId,
  });

  @override
  _ListTileforPostState createState() => _ListTileforPostState();
}

class _ListTileforPostState extends State<ListTileforPost> {
  @override
  initState() {
    imageFromStorage();
    super.initState();
  }

  String? url;

  imageFromStorage() {
    String path = '${widget.writer}/' + '${widget.title}/';
    Reference storage = FirebaseStorage.instance.ref().child(path);
    print('Current post : ' + path);
    storage.listAll().then((value) {
      value.items.forEach((element) {
        element.getDownloadURL().then((value) {
          print('Current value  : ' + value);
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
      child: Column(
        children: [
          Container(
            child: ListTile(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              child: Container(
                                constraints: BoxConstraints(
                                    maxWidth:
                                        MediaQuery.of(context).size.width *
                                            0.6),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      widget.title,
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Text(
                                      widget.body,
                                      style: TextStyle(
                                          color: Colors.grey, fontSize: 14),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Text(
                                      widget.time,
                                      style: TextStyle(
                                          color: Colors.grey, fontSize: 14),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            url != null
                                ? Expanded(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(right: 10),
                                          height: 50,
                                          width: 50,
                                          decoration: BoxDecoration(
                                              // borderRadius:
                                              // BorderRadius.all(Radius.circular(10.0)),
                                              //border: Border.all(color: Colors.grey),
                                              image: DecorationImage(
                                                  image: NetworkImage(url!))),
                                        )
                                      ],
                                    ),
                                  )
                                : Expanded(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(right: 10),
                                          height: 50,
                                          width: 50,
                                          child: Image.asset("moolzal.png",
                                              fit: BoxFit.fill),
                                        )
                                      ],
                                    ),
                                  )

                            // Expanded(
                            //   child: Row(
                            //     mainAxisAlignment: MainAxisAlignment.end,
                            //     children: [
                            //       Container(
                            //         child: Text(widget.time, ),
                            //       )
                            //     ],
                            //   ),
                            // ),
                          ],
                        ),
                        Divider(
                          thickness: 1,
                          color: Colors.grey,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
