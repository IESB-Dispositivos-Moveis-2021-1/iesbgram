// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$UserStore on _UserStoreBase, Store {
  final _$userAtom = Atom(name: '_UserStoreBase.user');

  @override
  User? get user {
    _$userAtom.reportRead();
    return super.user;
  }

  @override
  set user(User? value) {
    _$userAtom.reportWrite(value, super.user, () {
      super.user = value;
    });
  }

  final _$bioAtom = Atom(name: '_UserStoreBase.bio');

  @override
  String? get bio {
    _$bioAtom.reportRead();
    return super.bio;
  }

  @override
  set bio(String? value) {
    _$bioAtom.reportWrite(value, super.bio, () {
      super.bio = value;
    });
  }

  final _$loadingAtom = Atom(name: '_UserStoreBase.loading');

  @override
  bool get loading {
    _$loadingAtom.reportRead();
    return super.loading;
  }

  @override
  set loading(bool value) {
    _$loadingAtom.reportWrite(value, super.loading, () {
      super.loading = value;
    });
  }

  final _$errorAtom = Atom(name: '_UserStoreBase.error');

  @override
  FirebaseException? get error {
    _$errorAtom.reportRead();
    return super.error;
  }

  @override
  set error(FirebaseException? value) {
    _$errorAtom.reportWrite(value, super.error, () {
      super.error = value;
    });
  }

  final _$updateProfileAsyncAction =
      AsyncAction('_UserStoreBase.updateProfile');

  @override
  Future<void> updateProfile(
      {required String displayName, required String bio}) {
    return _$updateProfileAsyncAction
        .run(() => super.updateProfile(displayName: displayName, bio: bio));
  }

  final _$_UserStoreBaseActionController =
      ActionController(name: '_UserStoreBase');

  @override
  void _onUserChange(User? user) {
    final _$actionInfo = _$_UserStoreBaseActionController.startAction(
        name: '_UserStoreBase._onUserChange');
    try {
      return super._onUserChange(user);
    } finally {
      _$_UserStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void _listenUserDoc(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final _$actionInfo = _$_UserStoreBaseActionController.startAction(
        name: '_UserStoreBase._listenUserDoc');
    try {
      return super._listenUserDoc(snapshot);
    } finally {
      _$_UserStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
user: ${user},
bio: ${bio},
loading: ${loading},
error: ${error}
    ''';
  }
}
