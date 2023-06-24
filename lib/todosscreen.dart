import 'package:flutter/material.dart';
import 'package:todoapp/todo.dart';

class TodosScreen extends StatefulWidget {
  const TodosScreen({Key? key}) : super(key: key);

  @override
  State<TodosScreen> createState() => _TodosScreenState();
}

class _TodosScreenState extends State<TodosScreen> {
  final TextEditingController todoAddController = TextEditingController();
  bool category = true;
  List<Todo> todos = [];

  List<Todo> _complete() {
    return todos.where((todo) => todo.checked).toList();
  }

  List<Todo> _incomplete() {
    return todos.where((todo) => !todo.checked).toList();
  }

  bool modalCheckboxValue = false;

  @override
  Widget build(BuildContext context) {
    List<Todo> complete = _complete();
    List<Todo> incomplete = _incomplete();
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: _category, icon: const Icon(Icons.add))
        ],
      ),
      backgroundColor: const Color.fromRGBO(23, 107, 135, 11),
      body: todos.isEmpty
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Center(
                  child: Text(
                    'TODO List is Empty',
                    style: TextStyle(fontSize: 30),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Center(child: Image.asset('assets/images/NC5zdmc.png')),
              ],
            )
          : category
              ? ListView.builder(
                  itemCount: incomplete.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Card(
                          color: todos[index].values
                              ? Colors.redAccent
                              : const Color.fromARGB(10, 110, 189, 0),
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(20),
                            ),
                          ),
                          elevation: 10,
                          child: ListTile(
                            title: GestureDetector(
                              onTap: () {
                                showEditTodoModalSheet(
                                  context,
                                  incomplete[index].id,
                                  incomplete[index].todo,
                                );
                              },
                              child: Text(
                                incomplete[index].todo,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  decoration: incomplete[index].checked
                                      ? TextDecoration.lineThrough
                                      : TextDecoration.none,
                                ),
                              ),
                            ),
                            leading: Checkbox(
                              onChanged: (bool? value) {
                                setState(() {
                                  incomplete[index].checked = value!;
                                });
                              },
                              value: incomplete[index].checked,
                            ),
                            trailing: IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () {
                                deleteTodo(incomplete[index].id);
                              },
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                )
              : ListView.builder(
                  itemCount: complete.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Card(
                          color: todos[index].values
                              ? Colors.redAccent
                              : const Color.fromARGB(10, 110, 189, 0),
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(20),
                            ),
                          ),
                          elevation: 10,
                          child: ListTile(
                            title: GestureDetector(
                              onTap: () {
                                showEditTodoModalSheet(
                                  context,
                                  complete[index].id,
                                  complete[index].todo,
                                );
                              },
                              child: Text(
                                complete[index].todo,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  decoration: complete[index].checked
                                      ? TextDecoration.lineThrough
                                      : TextDecoration.none,
                                ),
                              ),
                            ),
                            leading: Checkbox(
                              onChanged: (bool? value) {
                                setState(() {
                                  complete[index].checked = value!;
                                });
                              },
                              value: complete[index].checked,
                            ),
                            trailing: IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () {
                                deleteTodo(complete[index].id);
                              },
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showAddNewTodoModalSheet(context);
        },
        label: const Text('Add TODO'),
      ),
    );
  }

  void _category() {
    category = !category;
    setState(() {});
  }

  void addTodo() {
    if (todoAddController.text.trim().isNotEmpty) {
      setState(() {
        todos.add(
          Todo(
            id: DateTime.now().microsecondsSinceEpoch.toString(),
            todo: todoAddController.text,
            values: modalCheckboxValue,
          ),
        );
      });
      todoAddController.clear();
      Navigator.of(context).pop();
    }
  }

  void deleteTodo(String id) {
    setState(() {
      todos.removeWhere((element) => element.id == id);
    });
  }

  void showAddNewTodoModalSheet(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        'Add TODO',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      TextField(
                        controller: todoAddController,
                        decoration: const InputDecoration(hintText: 'New Todo'),
                        maxLines: null,
                      ),
                      Row(
                        children: [
                          Checkbox(
                            value: modalCheckboxValue,
                            onChanged: (bool? value) {
                              setState(() {
                                modalCheckboxValue = value!;
                              });
                            },
                          ),
                          const Text('Important'),
                        ],
                      ),
                      Card(
                        child: IntrinsicHeight(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: addTodo,
                                  child: const Text('Save'),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  void showEditTodoModalSheet(
      BuildContext context, String id, String currentTitle) {
    final TextEditingController todoEditController =
        TextEditingController(text: currentTitle);

    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        'Edit TODO',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      TextField(
                        controller: todoEditController,
                        decoration:
                            const InputDecoration(hintText: 'Edit Todo'),
                        maxLines: null,
                      ),
                      Row(
                        children: [
                          Checkbox(
                            value: modalCheckboxValue,
                            onChanged: (bool? value) {
                              setState(() {
                                modalCheckboxValue = value!;
                              });
                            },
                          ),
                          const Text('Important'),
                        ],
                      ),
                      Card(
                        child: IntrinsicHeight(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: () {
                                    editTitle(id, todoEditController.text,
                                        modalCheckboxValue);
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('Save'),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  void editTitle(String id, String newTitle, bool newValue) {
    final int index = todos.indexWhere((todo) => todo.id == id);
    if (index != -1) {
      setState(() {
        todos[index].todo = newTitle;
        todos[index].values = newValue;
      });
    }
  }
}
