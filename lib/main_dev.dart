import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'app.dart';
import 'config/environment.dart';
import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Environment.flavor = EFlavor.dev;
  await Hive.initFlutter();
  await Hive.openBox('settings');
  await di.init();
  runApp(const App());
}
