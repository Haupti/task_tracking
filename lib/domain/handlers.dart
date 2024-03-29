import 'package:nanoid/nanoid.dart';
import 'package:task/domain/state.dart';
import 'package:task/domain/todo.dart';
import 'package:task/repository/state_repository.dart';
import 'package:task/repository/todo_repository.dart';

void handleTodoList(List<String> args) {
  AppState state = readAppState();
  List<Todo> todos = readTodos(state.activeWorkspace);
  // TODO
}

void handleTodoCheck(List<String> args) {
  print("handleTodoCheck"); // TODO
}

void handleTodoAdd(String arg) {
  AppState state = readAppState();
  List<Todo> todos = readTodos(state.activeWorkspace);
  todos.add(Todo(id: nanoid(), description: arg, createdAt: DateTime.now()));
  saveTodos(todos, state.activeWorkspace);
}

void handleTodoRemove(String arg) {
  print("handleTodoRemove"); // TODO
}

void handleWorkspaceCreate(String arg) {
  print("handleWorkspaceCreate"); // TODO
}

void handleWorkspaceDelete(String arg) {
  print("handleWorkspaceDelete"); // TODO
}

void handleWorkspaceList() {
  print("handleWorkspaceList"); // TODO
}
