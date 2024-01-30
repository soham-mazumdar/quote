import 'package:flutter/material.dart';
import 'package:quote/app/app.dart';
import 'package:quote/di/di.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await di.init();
  runApp(const App());
}
