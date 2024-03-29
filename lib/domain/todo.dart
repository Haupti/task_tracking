class Todo {
  final int id;
  final String description;
  final int createdEpochMillis;

  Todo(
      {required this.id,
      required this.description,
      required DateTime createdAt})
      : createdEpochMillis = createdAt.millisecondsSinceEpoch;

  Todo.create(
      {required this.id,
      required this.description,
      required this.createdEpochMillis});

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "description": description,
      "createdEpochMillis": createdEpochMillis,
    };
  }

  static Todo fromJson(Map<String, dynamic> json) {
    return Todo.create(
        id: json["id"],
        description: json["name"],
        createdEpochMillis: json["createdEpochMillis"]);
  }
}

class DoneTodo {
  final Todo todo;
  final int completedEpochMillis;

  DoneTodo({
    required this.todo,
    required DateTime completedAt,
  }) : completedEpochMillis = completedAt.millisecondsSinceEpoch;

  DoneTodo.create({
    required this.todo,
    required this.completedEpochMillis,
  });

  Map<String, dynamic> toJson() {
    return {
      "todo": todo.toJson(),
      "completedEpochMillis": completedEpochMillis,
    };
  }

  static DoneTodo fromJson(Map<String, dynamic> json) {
    return DoneTodo.create(
      todo: Todo.fromJson(json["todo"]),
      completedEpochMillis: json["completedEpochMillis"],
    );
  }
}
