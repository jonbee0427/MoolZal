import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class myprofile extends StatelessWidget {
  const myprofile({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('My Profile'),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.search,
            ),
            onPressed: () {
              //Navigator.pop(context);
              // 서치로 가기?
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            SizedBox(height: MediaQuery.of(context).size.height*0.05),
            CircleAvatar(
              radius: 100,
              backgroundColor: Colors.grey,
              backgroundImage: NetworkImage('https://www.woolha.com/media/2020/03/eevee.png'),
              //child: Image.network('https://handong.edu/site/handong/res/img/logo.png'),
            ),
            SizedBox(height: MediaQuery.of(context).size.height*0.05),
            Container(
              child: Text("대충 누구누구 님"),
            ),
            SizedBox(height: MediaQuery.of(context).size.height*0.05),
            RaisedButton(
                child: const Text('나의 게시글'),
                onPressed:() {
                 //Navigator.pushNamed(context, '/profile');
                  //나의 게시글 페이지로 가기
                }
            ),
            SizedBox(height: MediaQuery.of(context).size.height*0.05),
            RaisedButton(
                child: const Text('나의 댓글'),
                onPressed:() {
                  //Navigator.pushNamed(context, '/profile');
                  // 나의 댓글 페이지로 보내기
                }
            ),
            SizedBox(height: MediaQuery.of(context).size.height*0.05),
            RaisedButton(
                child: const Text('즐겨찾는 게시글'),
                onPressed:() {
                  //Navigator.pushNamed(context, '/profile');
                  // 나의 즐겨찾는 게시글로 가기
                }
            ),
          ],
        ),
      ),
    );
  }
}



