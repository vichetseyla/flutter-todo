import 'package:dartz/dartz.dart';
import 'package:todo/core/failures/failure.dart';
import 'package:todo/core/failures/unknown_failure.dart';
import 'package:todo/features/todo/data/datasources/todo_remote_data_source.dart';
import 'package:todo/features/todo/domain/repositories/todo_repository.dart';

import '../models/todo_model.dart';

class TodoRepositoryImpl implements TodoRepository {
  TodoRepositoryImpl({required TodoRemoteDatasource todoRemoteDatasource})
      : _todoRemoteDatasource = todoRemoteDatasource;
  final TodoRemoteDatasource _todoRemoteDatasource;
  @override
  Either<Failure, Stream<List<TodoModel>>> getTodos() {
    try {
      var data = _todoRemoteDatasource.fetchTodos();
      return Right(data);
    } catch (err) {
      return Left(UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, void>> addTodo(TodoModel todo) async {
    try {
      var result = await _todoRemoteDatasource.addTodo(todo);
      return right(result);
    } catch (err) {
      return Left(UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, void>> deleteTodo(TodoModel todo) async {
    try {
      var result = await _todoRemoteDatasource.deleteTodo(todo);
      return right(result);
    } catch (err) {
      return Left(UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, void>> updateTodo(TodoModel todo) async {
    try {
      var result = await _todoRemoteDatasource.updateTodo(todo);
      return right(result);
    } catch (err) {
      return Left(UnknownFailure());
    }
  }
}
