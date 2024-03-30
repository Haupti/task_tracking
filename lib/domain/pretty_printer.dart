import 'package:task/domain/todo.dart';

String _prettyDateTemplate(int year, int month, int day, int hour, int minute) {
  return "$year-${month < 10 ? "0$month" : month}-${day < 10 ? "0$day" : day}|${hour < 10 ? "0$hour" : hour}:${minute < 10 ? "0$minute" : minute}";
}

String prettyDate(int epochMillis) {
  DateTime t = DateTime.fromMillisecondsSinceEpoch(epochMillis);
  return _prettyDateTemplate(t.year, t.month, t.day, t.hour, t.minute);
}

var dateLength = _prettyDateTemplate(1000, 1, 1, 1, 1).length;
int dateLengthSpacing(String fieldName) => dateLength - fieldName.length;

void showTodos(List<Todo> todos, bool verbose, {String prefix = ""}) {
  if (todos.isEmpty) {
    print("${prefix}nothing to do...");
    return;
  }

  if (verbose) {
    String row = "$prefix[#]   ";
    row += "[id]${" " * (todos[0].id.length - 2)}   ";
    row += "[createdAt]${" " * dateLengthSpacing("createdAt")}   ";
    row += "description";
    print(row);
  } else {
    print("$prefix[#]   [description]");
  }

  int index = 0;
  for (var td in todos) {
    String row = prefix;
    row += "[$index]";
    row += index >= 100
        ? " "
        : (index >= 10 ? "  " : "   "); // spacing depending on the index width
    row += verbose ? """[${td.id}]   """ : "";
    row += verbose ? """[${prettyDate(td.createdEpochMillis)}]   """ : "";
    row += td.description;
    print(row);
    index += 1;
  }
}

void showDoneTodos(List<DoneTodo> dones, bool verbose, {String prefix = ""}) {
  if (dones.isEmpty) {
    print("${prefix}nothing to do...");
    return;
  }

  if (verbose) {
    String row = "$prefix[#]   ";
    row += "[id]${" " * (dones[0].todo.id.length - 2)}   ";
    row += "[createdAt]${" " * dateLengthSpacing("createdAt")}   ";
    row += "[completedAt]${" " * dateLengthSpacing("createdAt")} ";
    row += "description";
    print(row);
  } else {
    print("$prefix[#]   [description]");
  }

  int index = 0;
  for (var done in dones) {
    String row = prefix;
    row += "[$index]";
    row += index >= 100
        ? " "
        : (index >= 10 ? "  " : "   "); // spacing depending on the index width
    row += verbose ? """[${done.todo.id}]   """ : "";
    row +=
        verbose ? """[${prettyDate(done.todo.createdEpochMillis)}]   """ : "";
    row += verbose ? """[${prettyDate(done.completedEpochMillis)}]   """ : "";
    row += done.todo.description;
    print(row);
  }
}
