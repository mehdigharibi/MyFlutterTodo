// ignore_for_file: public_member_api_docs, sort_constructors_first
class Todo {
  String? id;
  String? todoText;
  bool? isDone;
  Todo({
    required this.id,
    required this.todoText,
    required this.isDone,
  });

  static List<Todo> todoList() {
    return [
      Todo(id: '01', todoText: 'Morning Excercise', isDone: true),
      Todo(id: '02', todoText: 'Buy Book', isDone: false),
      Todo(id: '03', todoText: 'Check Mails', isDone: false),
      Todo(id: '04', todoText: 'Call John', isDone: true),
      Todo(id: '05', todoText: 'Work On Github', isDone: false),
      Todo(id: '06', todoText: 'Response To Tasks', isDone: true),
      Todo(id: '07', todoText: 'Call John', isDone: true),
      Todo(id: '08', todoText: 'Work On Github', isDone: false),
      Todo(id: '09', todoText: 'Response To Tasks', isDone: true),
    ];
  }
}
