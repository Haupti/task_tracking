import 'package:task/domain/pretty_printer.dart';
import 'package:task/domain/todo.dart';
import 'package:task/domain/workspace.dart';
import 'package:task/repository/todo_repository.dart';

void showWorkspaces(List<Workspace> workspaces, WorkspaceId activeWorkspace) {
  print("\x1B[1m[#] [status]   [id]                    name\x1B[22m");
  for (int i = 0; i < workspaces.length; i++) {
    print(
        "[$i] [${workspaces[i].id == activeWorkspace ? "selected" : "        "}] [${workspaces[i].id}] ${workspaces[i].name}");
  }
}

void showWorkspacesWithTodos(
    List<Workspace> workspaces, WorkspaceId activeWorkspace) {
  print("\x1B[1m[#] [status]   name\x1B[22m");
  for (int i = 0; i < workspaces.length; i++) {
    print(
        "[$i] [${workspaces[i].id == activeWorkspace ? "selected" : "        "}] ${workspaces[i].name}");
    List<Todo> todos = readTodos(workspaces[i].id);
    showTodos(todos, false, prefix: " |- ");
  }
}
