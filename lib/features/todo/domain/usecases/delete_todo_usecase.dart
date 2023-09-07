import 'package:dartz/dartz.dart';
import 'package:todo/core/failures/failure.dart';
import 'package:todo/features/todo/domain/params/todo_params.dart';

import '../../../../core/usecase.dart';
import '../repositories/todo_repository.dart';

class DeleteTodoUsecase implements Usecase<void, TodoParams> {
  DeleteTodoUsecase({
    required TodoRepository todoRepository,
  }) : _todoRepository = todoRepository;
  final TodoRepository _todoRepository;

  @override
  Future<Either<Failure, void>> call({required TodoParams params}) async {
    return await _todoRepository.deleteTodo(params.todo);
  }
}
