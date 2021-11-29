import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class myprofile extends StatelessWidget {
  const myprofile({Key? key}) : super(key: key);




  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final ProfileImage = user?.photoURL;
    String name = FirebaseAuth.instance.currentUser!.displayName.toString();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
          ),
          onPressed: () {
            Navigator.pushNamed(context, '/layout');
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
              Navigator.pushNamed(context, '/search');
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
              backgroundImage: NetworkImage(ProfileImage!),
            ),
            SizedBox(height: MediaQuery.of(context).size.height*0.05),
            Container(
              child: Text(name),
            ),
            SizedBox(height: MediaQuery.of(context).size.height*0.05),
            SizedBox(
              width: MediaQuery.of(context).size.width*0.8,
              child: OutlineButton(
                child: Text('나의 게시글',style: TextStyle(color: Colors.grey)),
                borderSide: BorderSide(
                  color: Colors.grey,
                  style: BorderStyle.solid,
                  width: 1.8,
                ),
                onPressed: () {
                  //나의 게시글 각
                  Navigator.pushNamed(context, '/mypost');
                },
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height*0.05),
            SizedBox(
              width: MediaQuery.of(context).size.width*0.8,
              child: OutlineButton(
                child: Text('나의 댓글',style: TextStyle(color: Colors.grey)),
                borderSide: BorderSide(
                  color: Colors.grey,
                  style: BorderStyle.solid,
                  width: 1.8,
                ),
                onPressed: () {
                  //나으 댓글로 가기
                  Navigator.pushNamed(context, '/mycomment');
                },
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height*0.05),
            SizedBox(
              width: MediaQuery.of(context).size.width*0.8,
              child: OutlineButton(
                child: Text('즐겨찾는 게시글',style: TextStyle(color: Colors.grey)),
                borderSide: BorderSide(
                  color: Colors.grey,
                  style: BorderStyle.solid,
                  width: 1.8,
                ),
                onPressed: () {
                  //즐겨찾는 게시글로 가기
                  Navigator.pushNamed(context, '/myfavorite');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}



