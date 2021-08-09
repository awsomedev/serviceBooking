// To parse this JSON data, do
//
//     final itemModel = itemModelFromJson(jsonString);

import 'dart:convert';

ItemModel itemModelFromJson(String str) => ItemModel.fromJson(json.decode(str));

String itemModelToJson(ItemModel data) => json.encode(data.toJson());

class ItemModel {
    ItemModel({
        this.issues,
    });

    List<Issue> issues;

    factory ItemModel.fromJson(Map<String, dynamic> json) => ItemModel(
        issues: List<Issue>.from(json["issues"].map((x) => Issue.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "issues": List<dynamic>.from(issues.map((x) => x.toJson())),
    };
}

class Issue {
    Issue({
        this.id,
        this.name,
    });

    String id;
    String name;

    factory Issue.fromJson(Map<String, dynamic> json) => Issue(
        id: json["id"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
    };
}
