// To parse this JSON data, do
//
//     final homeModel = homeModelFromJson(jsonString);

import 'dart:convert';

HomeModel homeModelFromJson(String str) => HomeModel.fromJson(json.decode(str));

String homeModelToJson(HomeModel data) => json.encode(data.toJson());

class HomeModel {
  final List<Appointment>? appointments;
  final List<PatientModel>? patients;

  HomeModel({
    this.appointments,
    this.patients,
  });

  factory HomeModel.fromJson(Map<String, dynamic> json) => HomeModel(
    appointments: json["appointments"] == null ? [] : List<Appointment>.from(json["appointments"]!.map((x) => Appointment.fromJson(x))),
    patients: json["patients"] == null ? [] : List<PatientModel>.from(json["patients"]!.map((x) => PatientModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "appointments": appointments == null ? [] : List<dynamic>.from(appointments!.map((x) => x.toJson())),
    "patients": patients == null ? [] : List<dynamic>.from(patients!.map((x) => x.toJson())),
  };
}

class Appointment {
  final int? id;
  final DateTime? day;
  final String? startTime;
  final String? endTime;
  final String? sessionType;
  final String? status;

  Appointment({
    this.id,
    this.day,
    this.startTime,
    this.endTime,
    this.sessionType,
    this.status,
  });

  factory Appointment.fromJson(Map<String, dynamic> json) => Appointment(
    id: json["id"],
    day: json["day"] == null ? null : DateTime.parse(json["day"]),
    startTime: json["start_time"],
    endTime: json["end_time"],
    sessionType: json["session_type"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "day": "${day!.year.toString().padLeft(4, '0')}-${day!.month.toString().padLeft(2, '0')}-${day!.day.toString().padLeft(2, '0')}",
    "start_time": startTime,
    "end_time": endTime,
    "session_type": sessionType,
    "status": status,
  };
}

class PatientModel {
  final int? id;
  final String? name;

  PatientModel({
    this.id,
    this.name,
  });

  factory PatientModel.fromJson(Map<String, dynamic> json) => PatientModel(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}
