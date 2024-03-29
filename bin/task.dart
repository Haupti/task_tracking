import 'dart:convert';
import 'dart:io';

import 'package:task/domain/workspace.dart';

final String appdataEnvVar = "TASK_HOME";

void initializeAppdataPath() {
  String? homePath = Platform.environment["TASK_HOME"];
  if (homePath == null) {
    print("ERROR: TASK_HOME not set.");
    print("please set the environment variable in the context of execution.");
    print(
        "it should point to a location where i can create a .taskdata directory to store all data.");
    print(
        "e.g. in bash you can set an alias for this tool: 'export TASK_HOME=/some/path && task'");
    print("aborting...");
    exit(1);
  }
  var workspacesFilePath = homePath;
  if (homePath.endsWith("/") || homePath.endsWith("\\")) {
    workspacesFilePath += ".taskdata/workspaces.json";
  } else {
    workspacesFilePath += "/.taskdata/workspaces.json";
  }
  File workspacesFile = File(workspacesFilePath);
  if (workspacesFile.existsSync()) {
    return;
  } else {
    workspacesFile.createSync(recursive: true);
    workspacesFile.writeAsStringSync(
        json.encode(WorkspacesConfig(workspaces: []).toJson()));
  }
}

void main(List<String> arguments) {
  initializeAppdataPath();
  /*
       planned commands:

       // create a new workspace with name
       workspace create <name> 

       // use workspace by name
       workspace <name>

       // goto prev workspace used
       workspace -p

       // remove a workspace and all todos & dones 
       // asks is u are sure
       workspace --remove <name>

       // lists all workspaces
       workspace [-l, --list]

       workspace shortahand: ws

       // adds a todo
        add <description>

       //lists all todos
       // option shows all done and current todos
       [l,list] [-a, --all] 
       //lists all todos
       // option shows extra information (creation & completion dates ...)
       [l,list] [-v,--verbose]

       // shows todos from all workspaces sorted
       overview
       // shows todos from all workspaces, also the done ones
       overview [--all, -a]

       // l [-va,-av] should work

       // check multiple todos
       [check, done] <numbers space separated> 

       // help, lists all commands
       --help

       */
}
