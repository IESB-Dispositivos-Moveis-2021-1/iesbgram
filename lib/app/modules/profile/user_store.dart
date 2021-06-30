import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mobx/mobx.dart';

part 'user_store.g.dart';

class UserStore = _UserStoreBase with _$UserStore;
abstract class _UserStoreBase with Store {

  FirebaseAuth firebaseAuth;
  FirebaseFirestore firebaseFirestore;
  _UserStoreBase(this.firebaseAuth, this.firebaseFirestore) {
    firebaseAuth.userChanges().listen(_onUserChange);
  }

  @observable
  User? user;

  @observable
  String? bio;

  @observable
  bool loading = false;

  @observable
  FirebaseException? error;

  @action
  void _onUserChange(User? user) {
    this.user = user;
    if (user != null) {
      firebaseFirestore.doc('user/${user.uid}').snapshots().listen(_listenUserDoc);
    }
  }

  @action
  void _listenUserDoc(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    if (snapshot.exists) {
      bio = snapshot.data()?['bio'] as String;
    }
  }

  @action
  Future<void> updateProfile({required String displayName, required String bio}) async {
    if (user == null) {
      return;
    }

    try {
      loading = true;
      await firebaseFirestore.doc('user/${user!.uid}').set({
        'displayName': displayName,
        'bio': bio
      });

      await firebaseAuth.currentUser?.updateDisplayName(displayName);
      loading = false;
    }on FirebaseException catch (e) {
      error = e;
      log('Erro ao salvar edição de perfil', error: e);
    }
  }



}
