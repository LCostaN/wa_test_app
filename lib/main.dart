import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wa_test_app/state/app/app_state.dart';
import 'package:wa_test_app/view/load_app.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AppState(),
      builder: (context, _) => const LoadApp(),
    );
  }
}
