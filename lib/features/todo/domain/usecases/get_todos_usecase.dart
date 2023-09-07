import 'package:dartz/dartz.dart';
import 'package:todo/core/failures/failure.dart';
import 'package:todo/core/usecase.dart';
import 'package:todo/features/todo/domain/entities/todo_entity.dart';
import 'package:todo/features/todo/domain/params/no_params.dart';
import 'package:todo/features/todo/domain/repositories/todo_repository.dart';

class GetTodosUsecase implements Usecase<Stream<List<TodoEntity>>, NoParams> {
  GetTodosUsecase({
    required TodoRepository todoRepository,
  }) : _todoRepository = todoRepository;
  final TodoRepository _todoRepository;
  @override
  Future<Either<Failure, Stream<List<TodoEntity>>>> call(
      {required NoParams params}) async {
    return _todoRepository.getTodos();
  }
}
