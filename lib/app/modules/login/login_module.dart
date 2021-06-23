import 'package:firebase_auth/firebase_auth.dart';
import 'package:iesbgram/app/modules/login/login_store.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:iesbgram/app/constants.dart';
import 'login_page.dart';
import 'forgot_password_page.dart';

class LoginModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => LoginStore(i.get<FirebaseAuth>())),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute, child: (context, args) => LoginPage()),
    ChildRoute(Constants.Routes.FORGOT_PASSWORD,
        child: (context, args) => ForgotPasswordPage(),
        transition: TransitionType.rightToLeft
    ),
  ];
}
