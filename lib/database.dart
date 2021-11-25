import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Database {
  final String uid;
  Database({required this.uid});

  final CollectionReference userCollection =
  FirebaseFirestore.instance.collection('users');
  final CollectionReference postCollection =
  FirebaseFirestore.instance.collection('posts');
  //final String uid = FirebaseAuth.instance.currentUser!.uid.toString();
  final String name = FirebaseAuth.instance.currentUser!.displayName.toString();


  Future savePost(String title, String body,
      List<String> path) async {
    DocumentReference groupDocRef = await postCollection.add({
      'writer': name,
      'writer_uid' : uid,
      'title': title,
      'body': body,
    });

    await groupDocRef.update({
      'members': FieldValue.arrayUnion([uid + '_' + name]),
      'groupId': groupDocRef.id,
    });
    for (String p in path) {
      print(groupDocRef.id);
    }

    DocumentReference userDocRef = userCollection.doc(uid);
    return await userDocRef.update({
      'posts': FieldValue.arrayUnion(
          [groupDocRef.id + '_' + title + '_' + DateTime.now().toString()])
    });
  }
}
