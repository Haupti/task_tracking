import 'package:task/domain/workspace.dart';

class AppState {
  WorkspaceId activeWorkspace;
  bool isWorkspaceSet;

  AppState({required this.activeWorkspace, required this.isWorkspaceSet});
  AppState.initial()
      : activeWorkspace = "",
        isWorkspaceSet = false;

  Map<String, dynamic> toJson() =>
      {"activeWorkspace": activeWorkspace, "isWorkspaceSet": isWorkspaceSet};

  static AppState fromJson(Map<String, dynamic> json) => AppState(
      activeWorkspace: json["activeWorkspace"],
      isWorkspaceSet: json["isWorkspaceSet"]);
}
