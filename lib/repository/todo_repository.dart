import 'dart:convert';
import 'dart:io';

import 'package:task/domain/todo.dart';
import 'package:task/domain/workspace.dart';

File todosFileFor(WorkspaceId workspaceId) =>
    File("todos_ws_$workspaceId.json");

File doneTodosFileFor(WorkspaceId workspaceId) =>
    File("done_todos_ws_$workspaceId.json");

void saveTodos(List<Todo> todos, WorkspaceId workspaceId) {
  File todosFile = todosFileFor(workspaceId);
  if (!todosFile.existsSync()) {
    todosFile.create(recursive: true);
  }
  todosFile.writeAsStringSync(json.encode(todos.map((it) => it.toJson())));
}

List<Todo> readTodos(WorkspaceId workspaceId) {
  File todosFile = todosFileFor(workspaceId);
  if (!todosFile.existsSync()) {
    return [];
  }
  return json
      .decode(todosFile.readAsStringSync())
      .map((it) => Todo.fromJson(it))
      .toList();
}

void saveDoneTodos(List<DoneTodo> dones, WorkspaceId workspaceId) {
  File donesFile = doneTodosFileFor(workspaceId);
  if (!donesFile.existsSync()) {
    donesFile.create(recursive: true);
  }
  donesFile.writeAsStringSync(json.encode(dones.map((it) => it.toJson())));
}

List<DoneTodo> readDoneTodos(WorkspaceId workspaceId) {
  File donesFile = doneTodosFileFor(workspaceId);
  if (!donesFile.existsSync()) {
    return [];
  }
  return json
      .decode(donesFile.readAsStringSync())
      .map((it) => DoneTodo.fromJson(it))
      .toList();
}
