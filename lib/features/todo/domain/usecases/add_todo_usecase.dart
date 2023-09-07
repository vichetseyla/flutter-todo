import 'package:dartz/dartz.dart';
import 'package:todo/core/failures/failure.dart';
import 'package:todo/features/todo/domain/params/todo_params.dart';

import '../../../../core/usecase.dart';
import '../repositories/todo_repository.dart';

class AddTodoUsecase implements Usecase<void, TodoParams> {
  AddTodoUsecase({
    required TodoRepository todoRepository,
  }) : _todoRepository = todoRepository;
  final TodoRepository _todoRepository;

  @override
  Future<Either<Failure, void>> call({required TodoParams params}) async {
    return await _todoRepository.addTodo(params.todo);
  }
}
