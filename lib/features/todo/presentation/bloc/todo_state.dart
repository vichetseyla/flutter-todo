part of 'todo_bloc.dart';

abstract class TodoState extends Equatable {
  const TodoState();

  @override
  List<Object> get props => [];
}

class TodoInitial extends TodoState {}

class LoadingTodos extends TodoState {}

class TodosFiltered extends TodoState {
  const TodosFiltered({required this.todos});
  final List<TodoEntity> todos;
}

class TodosLoaded extends TodoState {
  const TodosLoaded({required this.todos});
  final Stream<List<TodoEntity>> todos;
}

class TodosFailedToLoad extends TodoState {
  const TodosFailedToLoad({
    required this.failure,
  });
  final Failure failure;
}
