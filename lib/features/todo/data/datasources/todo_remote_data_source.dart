import 'package:todo/features/todo/data/models/todo_model.dart';

abstract class TodoRemoteDatasource {
  Stream<List<TodoModel>> fetchTodos();
  Future<void> addTodo(TodoModel todo);
  Future<void> updateTodo(TodoModel todo);
  Future<void> deleteTodo(TodoModel todo);
}
