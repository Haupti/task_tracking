
import 'dart:convert';
import 'dart:io';

import 'package:task/config/config.dart';
import 'package:task/domain/state.dart';

final File workspacesConfigFile = File("$homePath/workspaces.json");

void saveAppState(AppState appstate) {
  if (!workspacesConfigFile.existsSync()) {
    workspacesConfigFile.createSync(recursive: true);
  }
  workspacesConfigFile.writeAsStringSync(json.encode(appstate.toJson()));
}

AppState readAppState() {
  if (!workspacesConfigFile.existsSync()) {
    return AppState.initial();
  }
  return AppState.fromJson(
      json.decode(workspacesConfigFile.readAsStringSync()));
}
