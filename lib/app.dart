// lib/app.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'widgets/navigation_menu.dart';
import 'data/services/theme_provider.dart';
import 'app_themes.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pokémon App',
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: themeProvider.isDarkMode ? ThemeMode.dark : ThemeMode.light,
      home: MyHomePage(),
    );
  }
}
