import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _value = 1;

  Widget itemsOrderbyASC = new StreamBuilder<QuerySnapshot>(
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
                  return Card(
                    clipBehavior: Clip.antiAlias,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        // AspectRatio(
                        //   aspectRatio: 18 / 11,
                        //   child: Image.network(
                        //     itemImages[index]['photo'],
                        //     fit: BoxFit.fill,
                        //   ),
                        // ),
                        Container(
                          padding: EdgeInsets.fromLTRB(20.0, 5.0, 0.0, 5.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              SizedBox(height: 5.0),
                              Text(
                                itemImages[index]['title'],
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                                maxLines: 2,
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.fromLTRB(20.0, 0.0, 0.0, 5.0),
                            child: Row(
                              children: [
                                Row(
                                  children: <Widget>[
                                    Text(
                                      itemImages[index]['body'],
                                      style: TextStyle(fontSize: 15),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                                // Expanded(
                                //   child: TextButton(
                                //     onPressed: () {
                                //       Navigator.push(
                                //         context,
                                //         MaterialPageRoute(
                                //           builder: (context) =>
                                //               HomeDetail(
                                //                 docId: snapshot.data!
                                //                     .docs[index].id,
                                //                 uid: itemImages[index]['uid'],
                                //                 productName: itemImages[index]['productName'],
                                //                 photo: itemImages[index]['photo'],
                                //                 price: itemImages[index]['price'],
                                //                 description: itemImages[index]['description'],
                                //                 createdTime: itemImages[index]['createdTime'],
                                //               ),
                                //         ),
                                //       );
                                //     },
                                //     child: const Text(
                                //       'more',
                                //       style: TextStyle(
                                //           fontSize: 12, color: Colors.blue),
                                //     ),
                                //   ),
                                // ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                });
          }
        }
        return Container(
          child: new Text("No item images found."),
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
                Navigator.pop(context);
              },
              icon: Icon(Icons.exit_to_app))
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
            _value == 1 ? itemsOrderbyASC : Container(child: Text('nothing'),) ,
          ],
        ),
      ),
    );
  }
}
