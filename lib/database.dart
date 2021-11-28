import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:intl/intl.dart';

class Database {
  final String uid;
  Database({required this.uid});

  final CollectionReference userCollection =
  FirebaseFirestore.instance.collection('users');
  final CollectionReference postCollection =
  FirebaseFirestore.instance.collection('posts');
  final String name = FirebaseAuth.instance.currentUser!.displayName.toString();

  Future uploadFile(String title, String path) async {
    String time = DateTime.now().millisecondsSinceEpoch.toString();
    Reference reference = FirebaseStorage.instance
        .ref()
        .child('${name}/' + '${title}/' + time);
    UploadTask uploadTask = reference.putFile(File(path));
    TaskSnapshot taskSnapshot = await uploadTask;
    taskSnapshot.ref.getDownloadURL().then((downloadURL) {
      // setState(() {
      //   채팅방 이동?
      // });
    }, onError: (err) {
      // Toast.show('the file is not a image.', context,
      //     duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    });
  }



  Future savePost(String title, String body,
      List<String> path) async {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd kk:mm').format(now);
    DocumentReference postRef = await postCollection.add({
      'writer': name,
      'writer_uid' : uid,
      'title': title,
      'body': body,
      'time' : formattedDate,
    });

    await postRef.update({
      'members': FieldValue.arrayUnion([uid + '_' + name]),
      'groupId': postRef.id,
    });
    for (String p in path) {
      print(postRef.id);
    }

    DocumentReference userDocRef = userCollection.doc(uid);
    return await userDocRef.update({
      'posts': FieldValue.arrayUnion(
          [postRef.id + '_' + title + '_' + DateTime.now().toString()])
    });
  }
}
