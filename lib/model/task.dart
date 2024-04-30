import 'dart:convert';

List<Task> taskFromJson(String str) =>
    List<Task>.from(json.decode(str).map((x) => Task.fromJson(x)));

String taskToJson(List<Task> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Task {
  int id;
  String taskname;
  String taskdesc;
  String taskinst;
  dynamic createdAt;
  dynamic updatedAt;

  Task({
    required this.id,
    required this.taskname,
    required this.taskdesc,
    required this.taskinst,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Task.fromJson(Map<String, dynamic> json) => Task(
        id: json["id"],
        taskname: json["taskname"],
        taskdesc: json["taskdesc"],
        taskinst: json["taskinst"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "taskname": taskname,
        "taskdesc": taskdesc,
        "taskinst": taskinst,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}
