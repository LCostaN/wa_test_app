import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wa_test_app/state/app/app_state.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool openColor = false;
  bool openFont = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Configurações')),
      body: SafeArea(
        child: Consumer<AppState>(
          builder: (context, state, _) => ListView(
            children: [
              ListTile(
                leading: const Icon(Icons.color_lens),
                title: const Text("Tema"),
                trailing: Text(state.currentColor.toUpperCase()),
                onTap: openCloseColors,
              ),
              AnimatedSize(
                duration: const Duration(milliseconds: 300),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16.0, 0, 12, 0),
                  child: Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: buildColorCards(),
                  ),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.font_download),
                title: const Text("Fonte"),
                trailing: Text(state.currentFont.toUpperCase()),
                onTap: openCloseFonts,
              ),
              AnimatedSize(
                duration: const Duration(milliseconds: 300),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16.0, 0, 8, 0),
                  child: Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: buildFontCards(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void openCloseColors() {
    setState(() => openColor = !openColor);
  }

  void openCloseFonts() {
    setState(() => openFont = !openFont);
  }

  List<Widget> buildColorCards() {
    AppState state = context.read<AppState>();
    double height = openColor ? 100 : 0;

    List<Widget> list = List.generate(
      6,
      (index) => AnimatedContainer(
        height: height,
        duration: const Duration(milliseconds: 300),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            fixedSize: const Size.square(100),
            primary: state.colors[index],
            onPrimary: index > 3 ? Colors.black : Colors.white,
          ),
          onPressed: () => state.setThemeColor(index),
          child: Text(state.colorName(index)),
        ),
      ),
    );

    return [
      ...list,
      AnimatedContainer(
        height: height,
        duration: const Duration(milliseconds: 300),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            fixedSize: const Size(100, 100),
            primary: Colors.grey.shade900,
            onPrimary: Colors.white,
          ),
          onPressed: () => state.setThemeColor(6),
          child: Text(state.colorName(6)),
        ),
      ),
    ];
  }

  List<Widget> buildFontCards() {
    AppState state = context.read<AppState>();
    double height = openFont ? 60 : 0;

    List<Widget> list = List.generate(
      3,
      (index) => AnimatedContainer(
        height: height,
        duration: const Duration(milliseconds: 300),
        child: ElevatedButton(
          onPressed: () => state.setFontFamily(index),
          child: Text(
            state.fontName(index),
            style: TextStyle(fontFamily: state.currentFont),
          ),
        ),
      ),
    );

    return list;
  }
}
