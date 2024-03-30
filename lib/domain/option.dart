import 'dart:io';

enum Option {
  all(shorthand: "a", qualifiedName: "--all"),
  checked(shorthand: "c", qualifiedName: "--checked"),
  verbose(shorthand: "v", qualifiedName: "--verbose");

  const Option({required this.shorthand, required this.qualifiedName});
  final String shorthand;
  final String qualifiedName;
}

List<Option> _parseShorthands(List<String> chars) {
  List<Option> opts = [];
  for (var c in chars) {
    Option? found;
    for (var o in Option.values) {
      if (o.shorthand == c) {
        found = o;
        break;
      }
    }
    if (found == null) {
      print("ERROR: unknown option shorthand '$c'");
      exit(1);
    }
    opts.add(found);
  }
  return opts;
}

List<Option> parseOptions(List<String> args) {
  List<Option> opts = [];
  for (var arg in args) {
    if (arg.startsWith("-")) {
      List<String> chars = arg.split("");
      opts.addAll(_parseShorthands(chars.sublist(1)));
    } else if (arg.startsWith("--")) {
      Option? found;
      for (var o in Option.values) {
        if (o.qualifiedName == arg) {
          found = o;
          break;
        }
      }
      if (found == null) {
        print("ERROR: unknown option '$arg'");
        exit(1);
      }
    } else {
      // does not start with '-' or '--' -> is no option
      print("ERROR: not an option '$arg'");
      exit(1);
    }
  }
  return opts;
}
