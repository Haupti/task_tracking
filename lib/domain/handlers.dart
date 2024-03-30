import 'package:nanoid/nanoid.dart';
import 'package:task/domain/option.dart';
import 'package:task/domain/pretty_printer.dart';
import 'package:task/domain/state.dart';
import 'package:task/domain/todo.dart';
import 'package:task/repository/state_repository.dart';
import 'package:task/repository/todo_repository.dart';

void handleTodoList(List<String> args) {
  AppState state = readAppState();
  List<Todo> todos = readTodos(state.activeWorkspace);
  List<Option> options = parseOptions(args);
  if (options.contains(Option.verbose)) {
    showTodos(todos, true);
  } else {
    showTodos(todos, false);
  }
}

void handleTodoCheck(List<String> args) {
  AppState state = readAppState();
  List<Todo> todos = readTodos(state.activeWorkspace);
  List<DoneTodo> dones = readDoneTodos(state.activeWorkspace);

  int index = 0;
  List<Todo> todosToRemove = [];
  for (var td in todos) {
    if (args.contains(td.id) || args.contains("$index")) {
      todosToRemove.add(td);
      dones.add(DoneTodo(todo: td, completedAt: DateTime.now()));
    }
    index += 1;
  }
  List<String> todosRemoveIds = todosToRemove.map((it) => it.id).toList();
  saveTodos(todos.where((it) => !todosRemoveIds.contains(it.id)).toList(),
      state.activeWorkspace);
  saveDoneTodos(dones, state.activeWorkspace);
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
