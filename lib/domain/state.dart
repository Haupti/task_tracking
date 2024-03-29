import 'package:task/domain/workspace.dart';

class AppState {
  WorkspaceId activeWorkspace;

  AppState({required this.activeWorkspace});
  AppState.initial() : activeWorkspace = "default_id";

  Map<String, dynamic> toJson() => {"activeWorkspace": activeWorkspace};

  static AppState fromJson(Map<String, dynamic> json) =>
      AppState(activeWorkspace: json["activeWorkspace"]);
}
