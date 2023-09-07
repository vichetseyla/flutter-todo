import 'package:get_it/get_it.dart';
import 'package:todo/features/todo/data/datasources/todo_remote_data_source.dart';
import 'package:todo/features/todo/data/datasources/todo_remote_data_source_impl.dart';
import 'package:todo/features/todo/data/repositories/todo_repository_impl.dart';
import 'package:todo/features/todo/domain/usecases/add_todo_usecase.dart';
import 'package:todo/features/todo/domain/usecases/delete_todo_usecase.dart';
import 'package:todo/features/todo/domain/usecases/get_todos_usecase.dart';
import 'package:todo/features/todo/domain/usecases/update_todo_usecase.dart';

import '../features/todo/domain/repositories/todo_repository.dart';

final sl = GetIt.instance;

class ServiceLocator {
  ServiceLocator._();
  static void init() {
    sl.registerLazySingleton<TodoRemoteDatasource>(
        () => TodoRemoteDatasourceImpl());
    sl.registerLazySingleton<TodoRepository>(
        () => TodoRepositoryImpl(todoRemoteDatasource: sl()));
    sl.registerLazySingleton(() => GetTodosUsecase(todoRepository: sl()));
    sl.registerLazySingleton(() => AddTodoUsecase(todoRepository: sl()));
    sl.registerLazySingleton(() => UpdateTodoUsecase(todoRepository: sl()));
    sl.registerLazySingleton(() => DeleteTodoUsecase(todoRepository: sl()));
  }
}
