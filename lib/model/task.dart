// To parse this JSON data, do
//
//     final task = taskFromJson(jsonString);

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
  DateTime? createdAt;
  DateTime? updatedAt;
  int tcoin;
  int tfrequency;
  String timage;

  Task({
    required this.id,
    required this.taskname,
    required this.taskdesc,
    required this.taskinst,
    required this.createdAt,
    required this.updatedAt,
    required this.tcoin,
    required this.tfrequency,
    required this.timage,
  });

  factory Task.fromJson(Map<String, dynamic> json) => Task(
        id: json["id"],
        taskname: json["taskname"],
        taskdesc: json["taskdesc"],
        taskinst: json["taskinst"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        tcoin: json["tcoin"],
        tfrequency: json["tfrequency"],
        timage: json["timage"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "taskname": taskname,
        "taskdesc": taskdesc,
        "taskinst": taskinst,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "tcoin": tcoin,
        "tfrequency": tfrequency,
        "timage": timage,
      };
}
