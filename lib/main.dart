import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'features/presentation/app/app_module.dart';
import 'features/presentation/app/app_widget.dart';

void main() =>
  runApp(
    ModularApp(
      module: AppModule(),
      child: AppWidget(),
    )
  );
