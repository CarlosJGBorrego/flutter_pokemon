import 'package:flutter/material.dart'; //UI estándar de Flutter
import 'package:provider/provider.dart'; //Se usa para la gestión del estado
import 'app.dart';
import 'data/services/theme_provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: const MyApp(),
    ),
  );
}
