// To parse this JSON data, do
//
//     final pendingTask = pendingTaskFromJson(jsonString);

import 'dart:convert';

List<PendingTask> pendingTaskFromJson(String str) => List<PendingTask>.from(
    json.decode(str).map((x) => PendingTask.fromJson(x)));

String pendingTaskToJson(List<PendingTask> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PendingTask {
  int id;
  String tname;
  String tdesc;
  String tinst;
  String image;
  int userId;
  String taskid;
  String taskstatus;
  DateTime taskcreatetime;
  DateTime createdAt;
  DateTime updatedAt;

  PendingTask({
    required this.id,
    required this.tname,
    required this.tdesc,
    required this.tinst,
    required this.image,
    required this.userId,
    required this.taskid,
    required this.taskstatus,
    required this.taskcreatetime,
    required this.createdAt,
    required this.updatedAt,
  });

  factory PendingTask.fromJson(Map<String, dynamic> json) => PendingTask(
        id: json["id"],
        tname: json["tname"],
        tdesc: json["tdesc"],
        tinst: json["tinst"],
        image: json["image"],
        userId: json["user_id"],
        taskid: json["taskid"],
        taskstatus: json["taskstatus"],
        taskcreatetime: DateTime.parse(json["taskcreatetime"]),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "tname": tname,
        "tdesc": tdesc,
        "tinst": tinst,
        "image": image,
        "user_id": userId,
        "taskid": taskid,
        "taskstatus": taskstatus,
        "taskcreatetime": taskcreatetime.toIso8601String(),
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
