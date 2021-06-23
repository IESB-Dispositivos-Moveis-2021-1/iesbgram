import 'package:firebase_auth/firebase_auth.dart';
import 'package:iesbgram/app/constants.dart';
import 'package:mobx/mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'register_store.g.dart';

class RegisterStore = _RegisterStoreBase with _$RegisterStore;
abstract class _RegisterStoreBase with Store {

  FirebaseAuth firebaseAuth;
  SharedPreferences sharedPreferences;
  _RegisterStoreBase({required this.firebaseAuth, required this.sharedPreferences}) {
    firebaseAuth.authStateChanges().listen(_onAuthChange);
  }

  @observable
  User? user;

  @observable
  bool loading = false;

  @action
  void _onAuthChange(User? user) {
    if (user?.isAnonymous ?? true) {
      this.user = null;
    }else {
      this.user = user;
    }
  }

  @action
  Future<void> registerUser({required String name, required String email, required String password}) async {
    loading = true;
    final credential = await firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
    firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
    await credential.user?.updateDisplayName(name);
    sharedPreferences.setBool(Constants.SPK_REGISTER_DONE, true);
    loading = false;
  }

}
