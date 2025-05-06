import 'package:flutter/material.dart'; //Para changeNotifier, notificaciones a la UI, etc
import 'package:shared_preferences/shared_preferences.dart'; //Para guardar la preferencia en local

//La clase creada que extiende de ChangeNotifier permite notificar a los widgets cuando hay cambios
class ThemeProvider extends ChangeNotifier {
  bool _isDarkMode = false;

  //Para acceder a _isDarkMode desde fuera de forma segura
  bool get isDarkMode => _isDarkMode;

  //Al crear la instancia se ejecuta _loadTheme() para cargar la preferencia guardada
  ThemeProvider() {
    _loadTheme();
  }

  void _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    _isDarkMode = prefs.getBool('isDarkMode') ?? false;
    notifyListeners();
  }

  void toggleTheme() async {
    _isDarkMode = !_isDarkMode;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkMode', _isDarkMode);
    notifyListeners();
  }
}
