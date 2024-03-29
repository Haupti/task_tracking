import 'dart:convert';
import 'dart:io';

import 'package:task/domain/workspace.dart';

final File workspacesConfigFile = File("workspaces.json");

void saveWorkspacesConfig(WorkspacesConfig workspaces) {
  if (!workspacesConfigFile.existsSync()) {
    workspacesConfigFile.create(recursive: true);
  }
  workspacesConfigFile.writeAsStringSync(json.encode(workspaces.toJson()));
}

WorkspacesConfig readWorkspacesConfig() {
  if (!workspacesConfigFile.existsSync()) {
    return WorkspacesConfig.empty();
  }
  return WorkspacesConfig.fromJson(
      json.decode(workspacesConfigFile.readAsStringSync()));
}
