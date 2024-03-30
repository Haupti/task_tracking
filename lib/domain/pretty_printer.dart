import 'package:task/domain/todo.dart';

String _prettyDateTemplate(int year, int month, int day, int hour, int minute) {
  return "$year-${month < 10 ? "0$month" : month}-${day < 10 ? "0$day" : day}|${hour < 10 ? "0$hour" : hour}:${minute < 10 ? "0$minute" : minute}";
}

String prettyDate(int epochMillis) {
  DateTime t = DateTime.fromMillisecondsSinceEpoch(epochMillis);
  return _prettyDateTemplate(t.year, t.month, t.day, t.hour, t.minute);
}

void showTodos(List<Todo> todos, bool verbose) {
  if (todos.isEmpty) {
    print("nothing to do...");
    return;
  }

  if (verbose) {
    print(
        "[#]   [id]${" " * (todos[0].id.length - 2)}   [createdAt]${" " * (_prettyDateTemplate(1000, 1, 1, 1, 1).length - "createdAt".length)}   description");
  } else {
    print("[#]   [description]");
  }

  int index = 0;
  for (var td in todos) {
    String row = "";
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

void showDoneTodos(List<DoneTodo> dones, bool verbose) {
  if (dones.isEmpty) {
    print("nothing to do...");
    return;
  }

  if (verbose) {
    print("[#]   [id]   [createdAt]   [completedAt]   description");
  } else {
    print("[#]   [description]");
  }

  int index = 0;
  for (var done in dones) {
    String row = "";
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
