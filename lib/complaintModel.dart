// To parse this JSON data, do
//
//     final complaintModel = complaintModelFromJson(jsonString);

import 'dart:convert';

ComplaintModel complaintModelFromJson(String str) =>
    ComplaintModel.fromJson(json.decode(str));

String complaintModelToJson(ComplaintModel data) => json.encode(data.toJson());

class ComplaintModel {
  ComplaintModel({
    this.complaints,
    this.status,
  });

  List<Complaint> complaints;
  bool status;

  factory ComplaintModel.fromJson(Map<String, dynamic> json) => ComplaintModel(
        complaints: json["complaints"] == null
            ? []
            : List<Complaint>.from(
                json["complaints"].map((x) => Complaint.fromJson(x))),
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "complaints": List<dynamic>.from(complaints.map((x) => x.toJson())),
        "status": status,
      };
}

class Complaint {
  Complaint({
    this.complaintId,
    this.complaintStatus,
    this.solution,
    this.query,
    this.service,
  });

  String complaintId;
  String complaintStatus;
  String solution;
  String query;
  String service;

  factory Complaint.fromJson(Map<String, dynamic> json) => Complaint(
        complaintId: json["complaint_id"],
        complaintStatus: json["complaint_status"],
        solution: json["solution"],
        query: json["query"],
        service: json["service"],
      );

  Map<String, dynamic> toJson() => {
        "complaint_id": complaintId,
        "complaint_status": complaintStatus,
        "solution": solution,
        "query": query,
        "service": service,
      };
}
