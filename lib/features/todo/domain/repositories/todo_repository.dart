import 'package:todo/core/failures/failure.dart';
import 'package:todo/features/todo/data/models/todo_model.dart';
import 'package:dartz/dartz.dart';

abstract class TodoRepository {
  Either<Failure, Stream<List<TodoModel>>> getTodos();
  Future<Either<Failure, void>> addTodo(TodoModel todo);
  Future<Either<Failure, void>> updateTodo(TodoModel todo);
  Future<Either<Failure, void>> deleteTodo(TodoModel todo);
}
