import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/services/theme_provider.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const CustomAppBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return AppBar(
      title: Text(title),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: Switch(
            value: themeProvider.isDarkMode,
            onChanged: (_) => themeProvider.toggleTheme(),
            activeColor:
                Theme.of(context)
                    .colorScheme
                    .onPrimary, //Color del circulo(thumb) cuando el switch está activado
            activeTrackColor: Theme.of(context).colorScheme.primary.withAlpha(
              153,
            ), //Color de la linea de fondo cuando está activado
            inactiveThumbColor:
                Theme.of(context)
                    .colorScheme
                    .onSurface, //Color del circulo cuando está desactivado
            inactiveTrackColor: Theme.of(context).colorScheme.surface.withAlpha(
              153,
            ), //Color de la linea de fondo cuando esta desactivado
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
