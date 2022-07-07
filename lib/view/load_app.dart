import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wa_test_app/state/app/app_state.dart';
import 'package:wa_test_app/view/auth/login_page.dart';
import 'package:wa_test_app/view/pet_list/pet_list_page.dart';

class LoadApp extends StatefulWidget {
  const LoadApp({Key? key}) : super(key: key);

  @override
  State<LoadApp> createState() => _LoadAppState();
}

class _LoadAppState extends State<LoadApp> {
  
  @override
  Widget build(BuildContext context) {
    return Consumer<AppState>(
      builder: (context, state, _) => state.isLoaded
          ? MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'WA Pet App',
              theme: state.theme,
              home: state.user == null ? const LoginPage() : const PetListPage(),
            )
          : const Center(child: CircularProgressIndicator.adaptive()),
    );
  }
}
