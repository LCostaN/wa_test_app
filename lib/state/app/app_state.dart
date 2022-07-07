import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dart:developer' as dev;

class AppState extends ChangeNotifier {
  bool isLoaded = false;
  int _currentColorIndex = 1;
  int _currentFontIndex = 0;
  String? _user;

  late SharedPreferences _pref;

  AppState() {
    init();
  }

  Future<void> init() async {
    _pref = await SharedPreferences.getInstance();
    _currentColorIndex = _pref.getInt('theme') ?? 1;
    _currentFontIndex = _pref.getInt('font') ?? 0;
    _user = _pref.getString('user');
    isLoaded = true;
    dev.log("USER: $_user    THEME: $_currentColorIndex", name: "Loaded Data");
    notifyListeners();
  }

  List<String> get _fonts => ["Roboto", "Arima", "Nautigal"];

  List<MaterialColor> get colors => [
        Colors.deepPurple,
        Colors.blue,
        Colors.green,
        Colors.red,
        Colors.yellow,
        Colors.orange,
      ];

  ThemeData get theme => _currentColorIndex < 6
      ? ThemeData(
          primarySwatch: colors[_currentColorIndex],
          fontFamily: _fonts[_currentFontIndex],
        )
      : ThemeData.dark().copyWith(
          textTheme: ThemeData.dark().textTheme.apply(
            fontFamily: _fonts[_currentFontIndex],
          ),
        );

  String fontName(int index) {
    switch (index) {
      case 0:
        return "Roboto";
      case 1:
        return "Arima";
      case 2:
        return "Nautigal";
      default:
        return "Roboto";
    }
  }

  String colorName(int index) {
    switch (index) {
      case 0:
        return "Violeta";
      case 1:
        return "Azul";
      case 2:
        return "Verde";
      case 3:
        return "Vermelho";
      case 4:
        return "Amarelo";
      case 5:
        return "Laranja";
      case 6:
        return "Escuro";
      default:
        return "Azul";
    }
  }

  String? get user => _user;
  String get currentColor => colorName(_currentColorIndex);
  String get currentFont => fontName(_currentFontIndex);

  void setUser(String email) {
    _pref.setString('user', email);
    _user = email;
    notifyListeners();
  }

  void setFontFamily(int index) {
    _currentFontIndex = index;
    _pref.setInt('font', index);
    notifyListeners();
  }

  void setThemeColor(int index) {
    _currentColorIndex = index;
    _pref.setInt('theme', index);
    notifyListeners();
  }

  Future<void> signOut() async {
    _user = null;
    _pref.clear();
    notifyListeners();
  }
}
