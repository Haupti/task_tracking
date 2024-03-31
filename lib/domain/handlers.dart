import 'dart:io';

import 'package:nanoid/nanoid.dart';
import 'package:task/domain/option.dart';
import 'package:task/domain/pretty_printer.dart';
import 'package:task/domain/state.dart';
import 'package:task/domain/todo.dart';
import 'package:task/domain/workspace.dart';
import 'package:task/domain/ws_pretty_printer.dart';
import 'package:task/repository/state_repository.dart';
import 'package:task/repository/todo_repository.dart';
import 'package:task/repository/workspace_repository.dart';

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
  WorkspacesConfig wsconfig = readWorkspacesConfig();
  wsconfig.workspaces.add(Workspace(id: nanoid(), name: arg));
  saveWorkspacesConfig(wsconfig);
}

void handleWorkspaceDelete(String arg) {
  WorkspacesConfig wsconfig = readWorkspacesConfig();
  var filtered = wsconfig.workspaces.where((it) => it.id != arg).toList();
  if (wsconfig.workspaces.length == filtered.length) {
    print("no workspace with id '$arg' found.");
    return;
  }
  wsconfig.workspaces = filtered;
  saveWorkspacesConfig(wsconfig);
}

void handleWorkspaceList(List<String> args) {
  AppState state = readAppState();
  WorkspacesConfig wsconfig = readWorkspacesConfig();
  List<Option> options = parseOptions(args);

  if (options.contains(Option.verbose)) {
    showWorkspacesWithTodos(wsconfig.workspaces, state.activeWorkspace);
  } else {
    showWorkspaces(wsconfig.workspaces, state.activeWorkspace);
  }
}

void handleWorkspaceSelect(String arg) {
  AppState state = readAppState();
  WorkspacesConfig wsconfig = readWorkspacesConfig();
  Workspace selected =
      wsconfig.workspaces.firstWhere((it) => it.id == arg || it.name == arg);
  state.activeWorkspace = selected.id;
  saveAppState(state);
}

void helpHandler(){
    String ind = "     ";
    print("usage: <command> [<subcommand>] [<options>]");
    print("commands:");
    print("${ind}workspace list         lists all workspaces");
    print("${ind}workspace list -v      lists all workspaces and their currently open todos/tasks");
    print("${ind}workspace select <arg> selects a workspace to be active. all non-workspace commands apply to the selected workspace");
    print("$ind                       the argument is the name or id of the workspace");
    print("${ind}workspace create <arg> creates a new workspace, the argument is its name");
    print("${ind}workspace delete <arg> deletes a workspace and all its active and completed tasks");
    print("$ind workspace shorthand: ws");
    print("${ind}add <arg>              adds a todo to the currenlty selected workspace, the argument is the todo");
    print("${ind}list [<options>] <arg> lists all todos, that are active");
    print("$ind                       options: '-v'/'--verbose' prints additional information, '-a', '--all' also prints done todos");
    print("${ind}done <arg>             checks a active todo and moves it to done todos. the argument is its index (when using list) or its id");
    print("${ind}check <arg>            alias for done");
    print("${ind}delete <arg>           deletes a todo, not moving it to the completed todos. the argument is its index in the listing (list command) or its id");
    print("$ind--help                 shows help (this)");

}

