import 'package:flutter_modular/flutter_modular.dart';
import 'package:iesbgram/app/constants.dart';
import 'login_page.dart';
import 'forgot_password_page.dart';

class LoginModule extends Module {
  @override
  final List<Bind> binds = [];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute, child: (context, args) => LoginPage()),
    ChildRoute(Constants.Routes.FORGOT_PASSWORD, child: (context, args) => ForgotPasswordPage()),
  ];

}
