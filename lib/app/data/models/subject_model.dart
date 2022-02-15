// To parse this JSON data, do
//
//     final subject = subjectFromJson(jsonString);

import 'dart:convert';

List<Subject> subjectFromJson(String str) =>
    List<Subject>.from(json.decode(str).map((x) => Subject.fromJson(x)));

String subjectToJson(List<Subject> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Subject {
  Subject({
    required this.title,
    this.subTopics,
    this.selected = false,
  });

  String title;
  List<SubTopic>? subTopics;
  bool selected;

  factory Subject.fromJson(Map<String, dynamic> json) => Subject(
        title: json["title"],
        subTopics: List<SubTopic>.from(
            (json["sub_topics"] ?? []).map((x) => SubTopic.fromJson(x))),
        selected: json["fullSubject"] ?? false,
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "sub_topics":
            List<dynamic>.from((subTopics ?? []).map((x) => x.toJson())),
      };
}

class SubTopic {
  SubTopic({
    required this.title,
    this.selected = false,
  });

  String title;
  bool selected;

  factory SubTopic.fromJson(Map<String, dynamic> json) => SubTopic(
        title: json["title"],
        selected: json["selected"] ?? false,
      );

  Map<String, dynamic> toJson() => {
        "title": title,
      };
}
