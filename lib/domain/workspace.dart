typedef WorkspaceId = String;

class Workspace {
  WorkspaceId id;
  String name;

  Workspace({required this.id, required this.name});

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
    };
  }

  static Workspace fromJson(dynamic json) {
    return Workspace(id: json["id"], name: json["name"]);
  }
}

class WorkspacesConfig {
  List<Workspace> workspaces;

  WorkspacesConfig({required this.workspaces});

  Map<String, dynamic> toJson() {
    return {
      "workspaces": workspaces.map((it) => it.toJson()).toList(),
    };
  }

  static WorkspacesConfig fromJson(Map<String, dynamic> json) {
      List<dynamic> jsonArray = json["workspaces"];
    return WorkspacesConfig(
        workspaces: jsonArray.map((it) => Workspace.fromJson(it)).toList());
  }

  WorkspacesConfig.empty():
      workspaces = [];
}
