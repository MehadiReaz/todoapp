import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'homepage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AdaptiveTheme(
      light: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.purple,
        hintColor: Colors.indigo,
      ),
      dark: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.deepOrange,
        //backgroundColor: const Color.fromRGBO(23, 107, 135, 1),
        hintColor: Colors.greenAccent,
      ),
      initial: AdaptiveThemeMode.dark,
      builder: (theme, darkTheme) => MaterialApp(
        title: 'Adaptive Theme Demo',
        theme: theme,
        darkTheme: darkTheme,
        home: const HomePage(),
      ),
    );
  }
}
