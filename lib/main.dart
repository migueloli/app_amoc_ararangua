import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'features/presentation/app/app_module.dart';
import 'features/presentation/app/app_widget.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runZonedGuarded(mainRunApp, FirebaseCrashlytics.instance.recordError);
}

void mainRunApp() => runApp(
  ModularApp(
    module: AppModule(),
    child: AppWidget(),
  ),
);
