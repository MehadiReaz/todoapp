class Todo {
  String id;
  String todo;
  bool checked;
  bool values;

  Todo({
    required this.id,
    required this.todo,
    this.checked = false,
    this.values = false,
  });
}
