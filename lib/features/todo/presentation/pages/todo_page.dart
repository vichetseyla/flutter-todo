import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/features/todo/data/models/todo_model.dart';
import 'package:todo/features/todo/domain/entities/todo_entity.dart';
import 'package:todo/features/todo/presentation/widgets/todo_item.dart';

import '../../../../core/failures/failure.dart';
import '../bloc/todo_bloc.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({super.key});

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  Failure? _failure;
  String _filterText = '';
  List<TodoEntity> _localTodoList = [];
  List<TodoEntity> _filteredTodoList = [];
  final _inputFocusNode = FocusNode();
  TodoEntity? todoInEditMode;
  final _formKey = GlobalKey<FormState>();
  final _textController = TextEditingController();

  @override
  void dispose() {
    _inputFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool filterResultsEmpty =
        _filteredTodoList.isEmpty && _localTodoList.isNotEmpty;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Todo App'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      flex: 2,
                      child: Form(
                        key: _formKey,
                        child: TextFormField(
                          focusNode: _inputFocusNode,
                          autofocus: true,
                          validator: _onValidate,
                          controller: _textController,
                          onChanged: _handleOnChanged,
                          onFieldSubmitted: _handleOnSubmit,
                        ),
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: _updateButton(),
                    ),
                    Flexible(
                      flex: 1,
                      child: _cancelUpdateButton(),
                    )
                  ],
                ),
              ),
            ),
            _failureText(),
            Flexible(
              flex: 5,
              child: BlocListener<TodoBloc, TodoState>(
                listener: (context, state) {
                  if (state is TodosFailedToLoad) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(state.failure.getErrorMessage())));
                  }
                  if (state is TodosLoaded) {
                    _listenToTodosStream(state.todos);
                  }
                },
                child: _todoList(filterResultsEmpty),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _todoList(bool filterResultsEmpty) {
    if (filterResultsEmpty) {
      return const Center(
        child: Text('No Result. Create a new one instead'),
      );
    }
    return ListView.builder(
      itemCount: _filteredTodoList.length,
      itemBuilder: (context, index) {
        return TodoItem(
          todo: _filteredTodoList[index],
          onEdit: _handleOnEdit,
        );
      },
    );
  }

  Widget _updateButton() {
    if (todoInEditMode == null) {
      return const SizedBox();
    }
    return ElevatedButton(
      onPressed: _applyTodoUpdate,
      child: const Text('Update'),
    );
  }

  Widget _cancelUpdateButton() {
    if (todoInEditMode == null) {
      return const SizedBox();
    }
    return ElevatedButton(
      onPressed: _clearUpdateData,
      child: const Text('Cancel'),
    );
  }

  void _applyTodoUpdate() {
    if (_todoAlreadyExist()) {
      _showTodoAlreadyExistSnackBar();
    } else {
      context.read<TodoBloc>().add(
            UpdateTodo(
              todo: (todoInEditMode as TodoModel).copyWith(
                title: _textController.text,
              ),
            ),
          );
    }
    _clearUpdateData();
  }

  void _handleOnChanged(String value) {
    if (!mounted) return;
    _formKey.currentState!.validate();
    setState(() {
      _filterText = value;
    });
    if (todoInEditMode != null) return;
    _applyFilter();
  }

  void _handleOnSubmit(String value) {
    bool isFormValid = _formKey.currentState!.validate();
    if (!isFormValid) return;

    // Hit Enter Key During Edit Mode
    if (todoInEditMode != null) {
      _applyTodoUpdate();
      return;
    }

    // Add Todo
    if (_todoAlreadyExist()) {
      _showTodoAlreadyExistSnackBar();
    } else {
      context.read<TodoBloc>().add(
            AddTodo(
              todo: TodoModel(
                title: _textController.text,
              ),
            ),
          );
    }
    setState(() {
      _filterText = "";
    });
    _textController.text = "";
    _applyFilter();
  }

  String? _onValidate(String? value) {
    if (value?.isEmpty ?? false) {
      return "Please enter some text.";
    }
    return null;
  }

  void _handleOnEdit(TodoEntity todo) {
    if (!mounted) return;
    setState(() {
      todoInEditMode = todo;
    });
    _textController.text = todo.title;
    _formKey.currentState!.validate();
    _inputFocusNode.requestFocus();
  }

  void _listenToTodosStream(Stream<List<TodoEntity>> todos) {
    todos.listen((todoList) {
      setState(() {
        _localTodoList = todoList;
      });
      _applyFilter();
    });
  }

  void _applyFilter() {
    if (_filterText.isEmpty) {
      _filteredTodoList = _localTodoList;
    } else {
      _filteredTodoList =
          _localTodoList.where((e) => e.title.contains(_filterText)).toList();
    }
    setState(() {});
  }

  void _clearUpdateData() {
    setState(() {
      _filterText = "";
      todoInEditMode = null;
    });
    _textController.text = "";
  }

  Widget _failureText() {
    if (_failure == null) {
      return const SizedBox();
    }
    return Text(
      _failure?.getErrorMessage() ?? '',
      style: const TextStyle(color: Colors.red),
    );
  }

  bool _todoAlreadyExist() {
    return _localTodoList
        .where((e) => e.title == _textController.text)
        .isNotEmpty;
  }

  void _showTodoAlreadyExistSnackBar() {
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('Todo already exists !')));
  }
}
