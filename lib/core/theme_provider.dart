import 'package:flutter/material.dart';

class ThemeProvider with ChangeNotifier {
  bool _highContrast = false;
  bool get highContrast => _highContrast;

  ThemeData get themeData {
    if (_highContrast) {
      return ThemeData.dark().copyWith(
        colorScheme: const ColorScheme.dark(
          primary: Colors.yellow,
          secondary: Colors.yellowAccent,
        ),
      );
    }
    return ThemeData.light();
  }

  void toggleHighContrast() {
    _highContrast = !_highContrast;
    notifyListeners();
  }
}
