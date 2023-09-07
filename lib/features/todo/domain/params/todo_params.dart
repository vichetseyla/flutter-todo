import 'package:todo/core/params.dart';
import 'package:todo/features/todo/data/models/todo_model.dart';

class TodoParams extends Params {
  TodoParams({
    required this.todo,
  });
  final TodoModel todo;
}
