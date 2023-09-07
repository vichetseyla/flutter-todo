import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/core/failures/failure.dart';
import 'package:todo/features/todo/data/models/todo_model.dart';
import 'package:todo/features/todo/domain/entities/todo_entity.dart';
import 'package:todo/features/todo/domain/params/no_params.dart';
import 'package:todo/features/todo/domain/params/todo_params.dart';
import 'package:todo/features/todo/domain/usecases/get_todos_usecase.dart';

import '../../domain/usecases/add_todo_usecase.dart';
import '../../domain/usecases/delete_todo_usecase.dart';
import '../../domain/usecases/update_todo_usecase.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  TodoBloc({
    required GetTodosUsecase getTodosUsecase,
    required AddTodoUsecase addTodoUsecase,
    required UpdateTodoUsecase updateTodoUsecase,
    required DeleteTodoUsecase deleteTodoUsecase,
  })  : _getTodosUsecase = getTodosUsecase,
        _addTodoUsecase = addTodoUsecase,
        _updateTodoUsecase = updateTodoUsecase,
        _deleteTodoUsecase = deleteTodoUsecase,
        super(TodoInitial()) {
    on<FetchTodos>(_onFetchTodoEventHandler);
    on<AddTodo>(_onAddTodoEventHandler);
    on<UpdateTodo>(_onUpdateTodoEventHandler);
    on<DeleteTodo>(_onDeleteTodoEventHandler);
  }
  final GetTodosUsecase _getTodosUsecase;
  final AddTodoUsecase _addTodoUsecase;
  final UpdateTodoUsecase _updateTodoUsecase;
  final DeleteTodoUsecase _deleteTodoUsecase;

  FutureOr<void> _onFetchTodoEventHandler(
      FetchTodos event, Emitter<TodoState> emit) async {
    emit(LoadingTodos());
    final result = await _getTodosUsecase(params: NoParams());
    emit(
      result.fold(
        (l) => TodosFailedToLoad(failure: l),
        (r) => TodosLoaded(todos: r),
      ),
    );
  }

  FutureOr<void> _onAddTodoEventHandler(
      AddTodo event, Emitter<TodoState> emit) async {
    await _addTodoUsecase(params: TodoParams(todo: event.todo));
  }

  FutureOr<void> _onUpdateTodoEventHandler(
      UpdateTodo event, Emitter<TodoState> emit) async {
    await _updateTodoUsecase(params: TodoParams(todo: event.todo));
  }

  FutureOr<void> _onDeleteTodoEventHandler(
      DeleteTodo event, Emitter<TodoState> emit) async {
    await _deleteTodoUsecase(params: TodoParams(todo: event.todo));
  }
}
