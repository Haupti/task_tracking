import 'dart:io';
import 'package:task/config/config.dart' as config;
import 'package:task/domain/handlers.dart' as handlers;

void initializeAppdataPath() {
  String? path = Platform.environment[config.appdataEnvVar];
  if (path == null) {
    print("ERROR: TASK_HOME not set.");
    print("please set the environment variable in the context of execution.");
    print(
        "it should point to a location where i can create a .taskdata directory to store all data.");
    print("e.g. in bash you can set an alias for this tool:");
    print("   'export TASK_HOME=/some/path && task'");
    print("aborting...");
    exit(1);
  }
  if (path.endsWith("/") || path.endsWith("\\")) {
    config.homePath += "$path.taskdata/";
  } else {
    config.homePath += "$path/.taskdata/";
  }
}

void main(List<String> arguments) {
  initializeAppdataPath();

  switch (arguments) {
    case ["workspace" || "ws", "create", var arg]:
      handlers.handleWorkspaceCreate(arg);
    case ["workspace" || "ws", "delete", var arg]:
      handlers.handleWorkspaceDelete(arg);
    case ["workspace" || "ws", "list"]:
      handlers.handleWorkspaceList();
    case ["add", var arg]:
      handlers.handleTodoAdd(arg);
    case ["delete" || "remove", var arg]:
      handlers.handleTodoRemove(arg);
    case ["done" || "check", ...var args]:
      handlers.handleTodoCheck(args);
    case ["list" || "l", ...var args]:
      handlers.handleTodoList(args);
  }
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
