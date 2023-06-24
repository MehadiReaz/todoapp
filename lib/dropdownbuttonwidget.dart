import 'package:flutter/material.dart';

enum Category { all, completed, important, incompleted }

class MyDropdownButton extends StatefulWidget {
  const MyDropdownButton({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MyDropdownButtonState createState() => _MyDropdownButtonState();
}

class _MyDropdownButtonState extends State<MyDropdownButton> {
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
        onSelected: (Category selectedvalue) {},
        icon: const Icon(Icons.more_vert),
        itemBuilder: (_) => [
              const PopupMenuItem(
                value: Category.incompleted,
                child: Text('Incompleted'),
              ),
              const PopupMenuItem(
                value: Category.all,
                child: Text('All'),
              ),
              const PopupMenuItem(
                value: Category.completed,
                child: Text('Completed'),
              ),
              const PopupMenuItem(
                value: Category.important,
                child: Text('Important'),
              )
            ]);
  }
}
