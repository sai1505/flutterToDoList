import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todolist/models/todo_model.dart';

class TodoCubit extends Cubit<List<TodoModel>> {
  TodoCubit() : super([]);

  void addTask(String title) {
    final todo = TodoModel(
      taskData: title,
      createdAt: DateTime.now(),
    );

    state.add(todo);
    emit([...state]);
  }
}
