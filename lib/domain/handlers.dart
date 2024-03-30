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
  List<DoneTodo> dones = readDoneTodos(state.activeWorkspace);

  List<Option> options = parseOptions(args);
  bool verbose = options.contains(Option.verbose);

  if (options.contains(Option.all)) {
      print("TODOS");
    showTodos(todos, verbose);
      print("DONE TODOS");
    showDoneTodos(dones, verbose);
  } else {
    showTodos(todos, verbose);
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
  AppState state = readAppState();
  List<Todo> todos = readTodos(state.activeWorkspace);
  List<Todo> keepTodos = [];
  for (int index = 0; index < todos.length; index++) {
    if ("$index" != arg && todos[index].id != arg) {
      keepTodos.add(todos[index]);
    }
  }
  if (todos.length == keepTodos.length) {
    print("no todo with this id or index found");
    return;
  }
  saveTodos(keepTodos, state.activeWorkspace);
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
