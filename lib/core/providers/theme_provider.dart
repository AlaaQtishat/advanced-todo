import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo/core/services/local_storage.dart';

class ThemeProvider extends ChangeNotifier {
  bool _isDarkMode = false;

  ThemeProvider() {
    _loadThemeFromMemory();
  }

  bool get isDarkMode => _isDarkMode;

  ThemeMode get currentTheme => _isDarkMode ? ThemeMode.dark : ThemeMode.light;

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
    LocalStorage.saveTheme(_isDarkMode);
  }

  Future<void> _loadThemeFromMemory() async {
    _isDarkMode = await LocalStorage.getTheme();
    notifyListeners();
  }
}
