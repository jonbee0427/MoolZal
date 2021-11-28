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

  Future savePost(String title, String body, List<String> path) async {
    DocumentReference groupDocRef = await postCollection.add({
      'writer': name,
      'writer_uid': uid,
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

  Future sendMessage(String msg) async {
    DocumentReference groupDocRef = postCollection.doc(uid);
    FirebaseFirestore.instance
        .collection('posts')
        .doc(uid)
        .collection('messages')
        .add({
      'message': msg,
      'sender': name,
      'sentTime': FieldValue.serverTimestamp()
        });
  }

}

// sendMessage(String groupId, chatMessageData, String type) {
//   FirebaseFirestore.instance
//       .collection('groups')
//       .doc(groupId)
//       .collection('messages')
//       .add(chatMessageData);
//   FirebaseFirestore.instance.collection('groups').doc(groupId).update({
//     'recentMessage': chatMessageData['message'],
//     'recentMessageSender': chatMessageData['sender'],
//     'recentMessageTime': chatMessageData['time'],
//     'recentMessageType': chatMessageData['type']
//   });
// }
