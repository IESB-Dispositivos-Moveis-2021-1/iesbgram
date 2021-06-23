import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app/app_module.dart';
import 'app/app_widget.dart';

void main() async {
  //Aqui o Flutter ainda não foi inicializado
  WidgetsFlutterBinding.ensureInitialized();
  //Agora o Flutter já foi inicializado

  final sharedPreferences = await SharedPreferences.getInstance();

  final firebaseApp = await Firebase.initializeApp();
  log('Firebase inicializado: $firebaseApp');

  return runApp(ModularApp(module: AppModule(sharedPreferences, firebaseApp), child: AppWidget()));

}
