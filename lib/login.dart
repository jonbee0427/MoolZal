import 'package:flutter/material.dart';
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
        .collection('user')
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
    }).then((value) => print("New User: '$name' Added"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          children: <Widget>[
            const SizedBox(height: 70.0),
            Column(
              children: <Widget>[
                Container(
                    width: 250,
                    height: 250,
                    child: Image.asset(
                      'moolzal.png',
                      fit: BoxFit.fill,
                    )),
                const SizedBox(
                  height: 16.0,
                ),
              ],
            ),
            const SizedBox(height: 120.0),
            Padding(
              padding: const EdgeInsets.all(70.0),
              child: OutlinedButton.icon(
                icon: Image.asset('google.png', width: 25, height: 25),
                style: OutlinedButton.styleFrom(
                  primary: Colors.white,
                  backgroundColor: const Color.fromARGB(255, 192, 192, 192),
                ),
                onPressed: () {
                  signInWithGoogle();
                  Navigator.pushNamed(context, '/');
                },
                label: Text('GOOGLE LOGIN'),
              ),
            ),
            const SizedBox(height: 15.0),
          ],
        ),
      ),
    );
  }
}
