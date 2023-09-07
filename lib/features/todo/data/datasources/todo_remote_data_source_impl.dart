import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo/features/todo/data/datasources/todo_remote_data_source.dart';
import 'package:todo/features/todo/data/models/todo_model.dart';

class TodoRemoteDatasourceImpl implements TodoRemoteDatasource {
  @override
  Stream<List<TodoModel>> fetchTodos() {
    StreamController<List<TodoModel>> todosStreamController =
        StreamController.broadcast();
    var data = FirebaseFirestore.instance.collection('todos').snapshots();
    data.listen((event) {
      var todos =
          event.docs.map((e) => TodoModel.fromJson(e.data(), e.id)).toList();
      todosStreamController.add(todos);
    });
    return todosStreamController.stream;
  }

  @override
  Future<void> addTodo(TodoModel todo) async {
    await FirebaseFirestore.instance.collection('todos').add(todo.toJson());
  }

  @override
  Future<void> deleteTodo(TodoModel todo) async {
    await FirebaseFirestore.instance.collection('todos').doc(todo.id).delete();
  }

  @override
  Future<void> updateTodo(TodoModel todo) async {
    await FirebaseFirestore.instance
        .collection('todos')
        .doc(todo.id)
        .set(todo.toJson());
  }
}
