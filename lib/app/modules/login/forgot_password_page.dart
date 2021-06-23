import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:iesbgram/app/constants.dart';
import 'package:iesbgram/app/modules/login/login_store.dart';

class ForgotPasswordPage extends StatefulWidget {
  final String title;
  const ForgotPasswordPage({Key? key, this.title = 'Esqueceu a senha?'}) : super(key: key);
  @override
  ForgotPasswordPageState createState() => ForgotPasswordPageState();
}
class ForgotPasswordPageState extends ModularState<ForgotPasswordPage, LoginStore> {

  late final TextEditingController _emailController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
        child: ListView(
          children: <Widget>[
            Text('Não tem problema!', style: Theme.of(context).textTheme.headline1?.copyWith(fontSize: 32)),
            Image.asset('assets/forgot_password.png'),
            Text('Vamos te enviar um link para redefinir...', style: Theme.of(context).textTheme.headline1?.copyWith(fontSize: 18)),
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Qual é o seu e-mail?'
              ),
            ),
            SizedBox(height: 24),
            ElevatedButton(
              child: Text('REDEFINIR SENHA'),
              onPressed: () {
                store.resetPassword(withEmail: _emailController.text)
                    .then((_) {
                      showDialog(context: context, builder: (_) {
                        return AlertDialog(
                          title: Text('E-mail enviado'),
                          content: Text('Siga as instruções no seu e-mail.'),
                          actions: [
                            ElevatedButton(
                              child: Text('OK'),
                              onPressed: () {
                                Modular.to.pop();
                                Modular.to.pop();
                              },
                            )
                          ],
                        );
                      });
                });
              },
            )
          ],
        ),
      ),
    );
  }
}
