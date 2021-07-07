import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mobx/mobx.dart';

part 'search_store.g.dart';

class SearchStore = _SearchStoreBase with _$SearchStore;
abstract class _SearchStoreBase with Store {

  FirebaseAuth firebaseAuth;
  FirebaseFirestore firebaseFirestore;
  _SearchStoreBase({
    required this.firebaseAuth,
    required this.firebaseFirestore
  });

  @computed
  Stream<QuerySnapshot> get posts {
    return firebaseFirestore.collection('post')
        .snapshots();
  }
  
  @observable
  Stream<QuerySnapshot> searchResult = Stream.empty();

  @action
  Future<void> search(String query) async {
    searchResult.drain();
    searchResult = firebaseFirestore.collection('user')
        .where('displayName', isGreaterThanOrEqualTo: query)
        .orderBy('displayName')
        .snapshots();
  }
  

}