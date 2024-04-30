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
  DateTime createdAt;
  DateTime updatedAt;
  String userId;

  PendingTask({
    required this.id,
    required this.tname,
    required this.tdesc,
    required this.tinst,
    required this.image,
    required this.createdAt,
    required this.updatedAt,
    required this.userId,
  });

  factory PendingTask.fromJson(Map<String, dynamic> json) => PendingTask(
        id: json["id"],
        tname: json["tname"],
        tdesc: json["tdesc"],
        tinst: json["tinst"],
        image: json["image"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        userId: json["user_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "tname": tname,
        "tdesc": tdesc,
        "tinst": tinst,
        "image": image,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "user_id": userId,
      };
}
