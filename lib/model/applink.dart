import 'dart:convert';

class OtherLinksModel {
  bool? status;
  String? message;
  List<Applink>? otherlinks;

  OtherLinksModel({
    this.status,
    this.message,
    this.otherlinks,
  });

  OtherLinksModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['otherlinks'] != null) {
      otherlinks = <Applink>[];
      json['otherlinks'].forEach((v) {
        otherlinks!.add(Applink.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (otherlinks != null) {
      data['otherlinks'] = otherlinks!.map((v) => v.toJson()).toList();
    }

    return data;
  }
}

List<Applink> applinkFromJson(String str) =>
    List<Applink>.from(json.decode(str).map((x) => Applink.fromJson(x)));

String applinkToJson(List<Applink> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Applink {
  int id;
  String reason;
  String link;
  dynamic createdAt;
  dynamic updatedAt;

  Applink({
    required this.id,
    required this.reason,
    required this.link,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Applink.fromJson(Map<String, dynamic> json) => Applink(
        id: json["id"],
        reason: json["Reason"],
        link: json["link"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "Reason": reason,
        "link": link,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}
