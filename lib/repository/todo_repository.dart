import 'dart:convert';
import 'dart:io';

import 'package:task/config/config.dart';
import 'package:task/domain/todo.dart';
import 'package:task/domain/workspace.dart';

File todosFileFor(WorkspaceId workspaceId) =>
    File("$homePath/todos_ws_$workspaceId.json");

File doneTodosFileFor(WorkspaceId workspaceId) =>
    File("$homePath/done_todos_ws_$workspaceId.json");

void saveTodos(List<Todo> todos, WorkspaceId workspaceId) {
  File todosFile = todosFileFor(workspaceId);
  if (!todosFile.existsSync()) {
    todosFile.createSync(recursive: true);
  }
  List<Map<String, dynamic>> jsonTodos =
      todos.map((it) => it.toJson()).toList();
  todosFile.writeAsStringSync(json.encode(jsonTodos));
}

List<Todo> readTodos(WorkspaceId workspaceId) {
  File todosFile = todosFileFor(workspaceId);
  if (!todosFile.existsSync()) {
    print(todosFile.path);
    return [];
  }
  List<dynamic> jsonTodosRaw = json.decode(todosFile.readAsStringSync()).cast();
  List<Map<String, dynamic>> jsonTodos = jsonTodosRaw.cast();
  return jsonTodos.map((it) => Todo.fromJson(it)).toList();
}

void saveDoneTodos(List<DoneTodo> dones, WorkspaceId workspaceId) {
  File donesFile = doneTodosFileFor(workspaceId);
  if (!donesFile.existsSync()) {
    donesFile.createSync(recursive: true);
  }
  List<Map<String, dynamic>> jsonDones =
      dones.map((it) => it.toJson()).toList();
  donesFile.writeAsStringSync(json.encode(jsonDones));
}

List<DoneTodo> readDoneTodos(WorkspaceId workspaceId) {
  File donesFile = doneTodosFileFor(workspaceId);
  if (!donesFile.existsSync()) {
    return [];
  }

  List<dynamic> jsonDonesRaw = json.decode(donesFile.readAsStringSync()).cast();
  List<Map<String, dynamic>> jsonDones = jsonDonesRaw.cast();
  return jsonDones.map((it) => DoneTodo.fromJson(it)).toList();
}
