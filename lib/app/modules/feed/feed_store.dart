import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mobx/mobx.dart';

part 'feed_store.g.dart';

class FeedStore = _FeedStoreBase with _$FeedStore;
abstract class _FeedStoreBase with Store {

  FirebaseAuth firebaseAuth;
  FirebaseFirestore firebaseFirestore;

  _FeedStoreBase({
    required this.firebaseAuth,
    required this.firebaseFirestore
  });

  @computed
  Stream<QuerySnapshot> get posts {
    return firebaseFirestore.collection('post')
        .orderBy('dateTime', descending: true)
        .snapshots();
  }

  Future<DocumentSnapshot> getUser(String userId) async {
    return firebaseFirestore.doc('user/$userId').get();
  }

}