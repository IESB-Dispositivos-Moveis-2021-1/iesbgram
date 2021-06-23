import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:iesbgram/app/constants.dart';
import 'package:iesbgram/app/modules/home/home_module.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'modules/onboarding/onboarding_module.dart';
import 'modules/register/register_module.dart';
import 'modules/login/login_module.dart';

class AppModule extends Module {

  SharedPreferences _sharedPreferences;
  FirebaseApp _firebaseApp;
  AppModule(this._sharedPreferences, this._firebaseApp);

  @override
  List<Bind> get binds => [
    Bind.singleton((i) => _sharedPreferences),
    Bind.instance(_firebaseApp),
    Bind.factory((i) => FirebaseAuth.instance),
  ];

  @override
  late final List<ModularRoute> routes = [
    ModuleRoute(Modular.initialRoute, module: _initialModule()),
    ModuleRoute(Constants.Routes.HOME, module: HomeModule(), guards: [_FirebaseAuthGuard()]),
    ModuleRoute(Constants.Routes.ONBOARDING, module: OnboardingModule()),
    ModuleRoute(Constants.Routes.REGISTER, module: RegisterModule(), transition: TransitionType.rotate),
    ModuleRoute(Constants.Routes.LOGIN, module: LoginModule(), transition: TransitionType.scale)
  ];




  Module _initialModule() {
    final onboardingDone = _sharedPreferences.getBool(Constants.SPK_ONBOARDING_DONE) ?? false;
    final registerDone = _sharedPreferences.getBool(Constants.SPK_REGISTER_DONE) ?? false;
    if (onboardingDone) {
      if (registerDone) {
        if (FirebaseAuth.instance.currentUser?.isAnonymous ?? true) {
          return LoginModule();
        }else {
          return HomeModule();
        }
      }else {
        return RegisterModule();
      }
    }else {
      return OnboardingModule();
    }
  }

}

class _FirebaseAuthGuard extends RouteGuard {

  _FirebaseAuthGuard() : super(null);

  @override
  Future<bool> canActivate(String path, ModularRoute router) {
    return Future.value(!(FirebaseAuth.instance.currentUser?.isAnonymous ?? true));
  }
}
