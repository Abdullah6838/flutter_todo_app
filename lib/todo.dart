class Todo {
  String? id;
  String? todoText;
  bool isDone;

  Todo({
    required this.id,
    required this.todoText,
    this.isDone = false,
  });

  static List<Todo> todoList () {
    return [
      Todo(id: '01', todoText: 'cheek mail', isDone: true),
      Todo(id: '02', todoText: 'cheek box', isDone: true),
      Todo(id: '03', todoText: 'writting'),
      Todo(id: '04', todoText: 'work'),
      Todo(id: '05', todoText: 'checking'),
    ];
  }
}