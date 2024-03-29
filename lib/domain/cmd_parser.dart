enum Option {
  all(qualifiedName: "all", shorthands: ["a"]);

  const Option({required this.qualifiedName, required this.shorthands});

  final String qualifiedName;
  final List<String> shorthands;
}

enum Command {
  list(names: ["list", "l"]),
  tree(names: ["tree"]),
  check(names: ["check", "done"]),
  add(names: ["add"]),
  workspace(names: ["workspace", "ws"]);

  const Command({required this.names});

  final List<String> names;
}

typedef Instruction = ({Command cmd, List<Option> opts, List<String> args});
typedef FailureReason = String;

(Command?, FailureReason?) parseCommand(String command) {
  for (var c in Command.values) {
    if (c.names.contains(command)) {
      return (c, null);
    }
  }
  return (null, "command not known '$command'");
}

(Option?, FailureReason?) parseQualifiedOpt(String arg) {
  String argValue = arg;
  if (arg.startsWith("--")) {
    argValue = arg.replaceFirst("--", "");
  }

  for (var o in Option.values) {
    if (o.qualifiedName == argValue) {
      return (o, null);
    }
  }
  return (null, "qualified option not known '$argValue'");
}

(List<Option>? opts, FailureReason?) parseOpts(String arg) {
  String argValue = arg;
  if (argValue.startsWith("--")) {
    throw Exception(
        "parsing opts: found qulaified opt, this is not parsed here");
  }
  if (argValue.startsWith("-")) {
    argValue = arg.replaceFirst("-", "");
  }

  List<Option> options = [];
  List<String> chars = argValue.split('');
  for (var c in chars) {
    List<Option> optsForC = [];
    for (var o in Option.values) {
      if (o.shorthands.contains(c)) {
        optsForC.add(o);
      }
    }
    if (optsForC.isEmpty) {
      return (null, "option not known '$c'");
    } else {
      options.addAll(optsForC);
    }
  }
  return (options, null);
}

(Instruction?, FailureReason?) parseInstruction(List<String> args) {
  if (args.isEmpty) {
    return (null, "no args supplied");
  }

  Command? cmd;
  var (command, err) = parseCommand(args[0]);
  if (err == null) {
    cmd = command;
  } else {
    return (null, err);
  }

  List<String> arguments = [];
  List<Option> opts = [];
  for (final arg in args.sublist(1)) {
    if (arg.startsWith("--")) {
      var (opt, err) = parseQualifiedOpt(arg);
      if (err == null && opt != null) {
        opts.add(opt);
      } else {
        return (null, err);
      }
    } else if (arg.startsWith("-")) {
      var (os, err) = parseOpts(arg);
      if (err == null && os != null) {
        opts.addAll(os);
      } else {
        return (null, err);
      }
    } else {
      arguments.add(arg);
    }
  }

  return cmd == null
      ? (null, "no command")
      : ((cmd: cmd, opts: opts, args: arguments), null);
}
