class Todo {
  int? id;
  String description;
  bool done;
  String creationDate;
  String taskDate;
  String updatedDate;
  String? deletedDate;
  int priority;
  Todo({
    this.id,
    required this.creationDate,
    required this.deletedDate,
    required this.description,
    required this.done,
    required this.taskDate,
    required this.priority,
    required this.updatedDate,
  });
  Todo.fromMap(Map<String, dynamic> map)
      : description = map['description'],
        done = map['done'] == 1,
        taskDate = map['task_date'],
        creationDate = map['creation_date'],
        updatedDate = map['updated_date'],
        id = map['id'],
        deletedDate =
            map['deleted_date'] == "null" ? null : map['deleted_date'],
        priority = map['priority'];
  Map<String, Object?> toMap() {
    return {
      "task_date": taskDate,
      "description": description,
      "done": done ? 1 : 0,
      "creation_date": creationDate,
      "updated_date": updatedDate,
      "deleted_date": deletedDate,
      "priority": priority,
    };
  }
}
