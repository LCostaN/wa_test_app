import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wa_test_app/services/auth_service.dart';
import 'package:wa_test_app/state/app/app_state.dart';
import 'package:wa_test_app/view/pet_list/pet_list_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String email = "";
  bool loading = false;
  String? error;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Card(
          child: Container(
            padding: const EdgeInsets.all(24),
            width: min(450, MediaQuery.of(context).size.width * 0.8),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset('assets/images/waproject_logo.jpeg'),
                const SizedBox(height: 20),
                TextFormField(
                  textInputAction: TextInputAction.done,
                  style: const TextStyle(fontSize: 20),
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(24),
                    border: const OutlineInputBorder(),
                    prefixIcon: const Icon(Icons.email),
                    errorText: error,
                  ),
                  onEditingComplete: login,
                  onChanged: (value) => email = value,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: loading ? null : login,
                  style:
                      ElevatedButton.styleFrom(fixedSize: const Size(150, 48)),
                  child: loading
                      ? const CircularProgressIndicator.adaptive()
                      : const Text("Entrar"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void login() async {
    setState(() => loading = true);
    await Future.delayed(const Duration(seconds: 3));
    if (await AuthService().tryLogin(email)) {
      saveUser(email);
      goToPetList();
    } else {
      setState(() {
        error = "Usuário não permitido";
        loading = false;
      });
    }
  }

  void saveUser(String email) {
    context.read<AppState>().setUser(email);
  }

  void goToPetList() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => const PetListPage()),
    );
  }
}
