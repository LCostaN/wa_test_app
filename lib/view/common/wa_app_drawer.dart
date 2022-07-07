import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wa_test_app/state/app/app_state.dart';
import 'package:wa_test_app/view/auth/login_page.dart';

class WaAppDrawer extends StatefulWidget {
  const WaAppDrawer({Key? key}) : super(key: key);

  @override
  State<WaAppDrawer> createState() => _WaAppDrawerState();
}

class _WaAppDrawerState extends State<WaAppDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          Container(
            constraints: BoxConstraints.loose(const Size.fromHeight(200)),
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(context.watch<AppState>().user!,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold)),
                Text("Tema: ${context.watch<AppState>().currentColor}"),
                Text("Fonte: ${context.watch<AppState>().currentFont}"),
              ],
            ),
          ),
          const Divider(thickness: 1, height: 0),
          // const ListTile(
          //   leading: Icon(Icons.offline_bolt),
          //   title: Text("Option 1"),
          // ),
          ListTile(
            tileColor: Colors.red.shade100,
            leading: const Icon(Icons.logout),
            title: const Text("Sair"),
            onTap: logout,
          ),
        ],
      ),
    );
  }

  void logout() {
    context.read<AppState>().signOut();
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => const LoginPage()),
      (route) => false,
    );
  }
}
