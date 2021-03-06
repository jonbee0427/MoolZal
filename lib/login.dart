import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GoogleSignIn googleSignIn = GoogleSignIn();

  String id = '';
  String name = '';
  String photo = '';
  String email = '';

  Future<UserCredential> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser!.authentication;

    final OAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final UserCredential authResult =
        await FirebaseAuth.instance.signInWithCredential(credential);
    id = FirebaseAuth.instance.currentUser!.uid.toString();
    name = FirebaseAuth.instance.currentUser!.displayName.toString();
    photo = FirebaseAuth.instance.currentUser!.photoURL.toString();
    email = FirebaseAuth.instance.currentUser!.email.toString();

    FirebaseFirestore.instance
        .collection('users')
        .doc(authResult.user!.uid)
        .get()
        .then((value) => {
              if (!value.exists) {addUser()}
            });

    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  Future<void> addUser() async {
    FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .set({
      'uid': id,
      'name': name,
      'photo': photo,
      'email': email,
      'posts': [],
      'comments': [],
    }).then((value) => print("New User: '$name' Added"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          children: <Widget>[
            SizedBox(height: MediaQuery.of(context).size.height*0.1),
            Column(
              children: <Widget>[
                Container(
                  width: 200,
                  height: 200,
                  child: Image.asset(
                    'moolzal.png',
                    fit: BoxFit.fill,
                  ),
                ),
                AnimatedTextKit(
                  animatedTexts: [
                    WavyAnimatedText(
                      '???????????? ?????????',
                      textStyle: TextStyle(
                        fontSize: 20.0,
                        color: Colors.deepPurple,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                  isRepeatingAnimation: true,
                  onTap: () {
                    print("Tap Event");
                  },
                ),
              ],
            ),
            SizedBox(height: MediaQuery.of(context).size.height*0.3),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*0.08),
              child: SizedBox(
                width: MediaQuery.of(context).size.width*0.1,
                height: MediaQuery.of(context).size.height*0.1,
                child: OutlinedButton.icon(
                  icon: Image.asset('google.png', width: 30, height: 30),
                  style: OutlinedButton.styleFrom(
                    primary: Colors.white,
                    backgroundColor: Colors.deepPurple[400],
                  ),
                  onPressed: () {
                    signInWithGoogle();
                    Navigator.pushNamed(context, '/category');
                  },
                  label: Text('GOOGLE LOGIN', style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
