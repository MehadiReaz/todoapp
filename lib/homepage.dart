import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:todoapp/dropdownbuttonwidget.dart';
import 'package:todoapp/todosscreen.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          title: const Center(
            child: Text(
              'TODO',
              style: TextStyle(
                  fontFamily: 'Tilt Prism',
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 35),
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {
                AdaptiveTheme.of(context).toggleThemeMode();
              },
              icon: const Icon(Icons.sunny),
            ),
          ],
          leading: const MyDropdownButton()),
      body: const TodosScreen(),
    );
  }
}
