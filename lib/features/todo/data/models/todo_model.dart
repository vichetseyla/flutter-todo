import 'package:todo/features/todo/domain/entities/todo_entity.dart';

class TodoModel extends TodoEntity {
  const TodoModel(
      {super.id = '', required super.title, super.completed = false});

  factory TodoModel.fromJson(Map<String, dynamic> json, String id) {
    return TodoModel(
        id: id, title: json['title'], completed: json['completed'] as bool);
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'completed': completed,
    };
  }

  TodoModel copyWith({String? id, bool? completed, String? title}) {
    return TodoModel(
      id: id ?? this.id,
      title: title ?? this.title,
      completed: completed ?? this.completed,
    );
  }
}
