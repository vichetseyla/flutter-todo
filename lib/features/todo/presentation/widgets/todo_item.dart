import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/features/todo/data/models/todo_model.dart';
import 'package:todo/features/todo/domain/entities/todo_entity.dart';
import 'package:todo/features/todo/presentation/bloc/todo_bloc.dart';

class TodoItem extends StatelessWidget {
  final void Function(TodoEntity todo) onEdit;
  final TodoEntity todo;
  const TodoItem({super.key, required this.todo, required this.onEdit});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(
          todo.title,
          style: TextStyle(
              decoration: todo.completed ? TextDecoration.lineThrough : null),
        ),
        Row(
          children: [
            IconButton(
              onPressed: () {
                context.read<TodoBloc>().add(
                      UpdateTodo(
                        todo: (todo as TodoModel).copyWith(
                          completed: !todo.completed,
                        ),
                      ),
                    );
              },
              icon: Icon(
                todo.completed
                    ? Icons.check_box
                    : Icons.check_box_outline_blank,
              ),
            ),
            IconButton(
              onPressed: () {
                onEdit(todo);
              },
              icon: const Icon(
                Icons.edit,
              ),
            ),
            IconButton(
              onPressed: () {
                context.read<TodoBloc>().add(
                      DeleteTodo(
                        todo: (todo as TodoModel),
                      ),
                    );
              },
              icon: const Icon(
                Icons.delete,
              ),
            )
          ],
        ),
      ],
    );
  }
}
