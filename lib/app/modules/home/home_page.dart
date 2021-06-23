import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:iesbgram/app/constants.dart';
import 'package:mobx/mobx.dart';
import 'home_store.dart';

class HomePage extends StatefulWidget {
  final String title;
  const HomePage({Key? key, this.title = "Home"}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends ModularState<HomePage, HomeStore> {

  late final ReactionDisposer _disposer;

  @override
  void initState() {
    super.initState();

    _disposer = when(
      (_) => store.user == null,
      () => Modular.to.pushReplacementNamed(Constants.Routes.LOGIN)
    );

  }

  @override
  void dispose() {
    _disposer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Counter'),
      ),
      body: Container(
        child: Center(
          child: ElevatedButton(
            child: Text('LOGOFF'),
            onPressed: () {
              store.logoff();
            },
          ),
        ),
      ),
    );
  }
}
