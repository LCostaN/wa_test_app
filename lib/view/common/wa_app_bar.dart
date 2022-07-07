import 'package:flutter/material.dart';
import 'package:wa_test_app/view/settings/settings_page.dart';

class WaAppBar extends StatefulWidget implements PreferredSizeWidget {
  const WaAppBar({Key? key, required this.title, this.bottom, this.actions}) : super(key: key);

  final String title;
  final PreferredSizeWidget? bottom;
  final List<Widget>? actions;

  @override
  State<WaAppBar> createState() => _WaAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _WaAppBarState extends State<WaAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(widget.title),
      bottom: widget.bottom,
      actions: [
        ...(widget.actions ?? []),
        IconButton(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
          icon: const Icon(Icons.settings),
          onPressed: goToSettings,
        ),
      ],
    );
  }

  void goToSettings() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => const SettingsPage()),
    );
  }
}
