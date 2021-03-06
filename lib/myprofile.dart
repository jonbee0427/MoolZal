import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:moolzal/login.dart';

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
        title: Text('마이페이지'),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        actions: <Widget>[
          IconButton(
              onPressed: () {
                GoogleSignIn().signOut();
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                    builder: (BuildContext context) =>
                        LoginPage()), (route) => false);
              },
              icon: Icon(Icons.exit_to_app)),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          child: Column(
            children: <Widget>[
              SizedBox(height: MediaQuery.of(context).size.height*0.05),
              CircleAvatar(
                radius: 80,
                backgroundColor: Colors.deepPurple,
                backgroundImage: NetworkImage(ProfileImage!),
              ),
              SizedBox(height: MediaQuery.of(context).size.height*0.05),
              Container(
                child: Text(name, style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20)),
              ),
              SizedBox(height: MediaQuery.of(context).size.height*0.05),
              SizedBox(
                width: MediaQuery.of(context).size.width*0.8,
                child: OutlineButton(
                  child: Text('나의 게시글',style: TextStyle(color: Colors.black)),
                  borderSide: BorderSide(
                    color: Colors.deepPurple,
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
                  child: Text('나의 댓글',style: TextStyle(color: Colors.black)),
                  borderSide: BorderSide(
                    color: Colors.deepPurple,
                    style: BorderStyle.solid,
                    width: 1.8,
                  ),
                  onPressed: () {
                    //나으 댓글로 가기
                    Navigator.pushNamed(context, '/mycomment');
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}



