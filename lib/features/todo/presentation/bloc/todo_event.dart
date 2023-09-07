part of 'todo_bloc.dart';

abstract class TodoEvent extends Equatable {
  const TodoEvent();

  @override
  List<Object> get props => [];
}

class FetchTodos extends TodoEvent {}

class AddTodo extends TodoEvent {
  const AddTodo({required this.todo});
  final TodoModel todo;
}

class UpdateTodo extends TodoEvent {
  const UpdateTodo({required this.todo});
  final TodoModel todo;
}

class DeleteTodo extends TodoEvent {
  const DeleteTodo({required this.todo});
  final TodoModel todo;
}
