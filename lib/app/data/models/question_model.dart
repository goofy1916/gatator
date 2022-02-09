// To parse this JSON data, do
//
//     final question = questionFromJson(jsonString);

import 'dart:convert';

List<Question> questionFromJson(String str) =>
    List<Question>.from(json.decode(str).map((x) => Question.fromJson(x)));

String questionToJson(List<Question> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Question {
  Question({
    required this.type,
    required this.question,
    this.from,
    this.to,
    required this.answer,
    required this.topic,
    required this.subTopic,
    this.optionA,
    this.optionB,
    this.optionC,
    this.optionD,
    this.optionE,
    this.correctAnswer,
  });

  Type type;
  String question;
  String? from;
  String? to;
  String answer;
  String topic;
  String subTopic;
  String? optionA;
  String? optionB;
  String? optionC;
  String? optionD;
  String? optionE;
  String? correctAnswer;

  factory Question.fromJson(Map<String, dynamic> json) => Question(
        type: typeValues.map[json["type"]]!,
        question: json["question"],
        from: json["from"],
        to: json["to"],
        answer: json["answer"],
        topic: json["topic"],
        subTopic: json["SubTopic"],
        optionA: json["optionA"],
        optionB: json["optionB"],
        optionC: json["optionC"],
        optionD: json["optionD"],
        optionE: json["optionE"],
        correctAnswer: json["correctAnswer"],
      );

  Map<String, dynamic> toJson() => {
        "type": typeValues.reverse[type],
        "question": question,
        "from": from,
        "to": to,
        "answer": answer,
        "topic": topic,
        "SubTopic": subTopic,
        "optionA": optionA,
        "optionB": optionB,
        "optionC": optionC,
        "optionD": optionD,
        "optionE": optionE,
        "correctAnswer": correctAnswer,
      };
}

enum Type { NAT, MCQ }

final typeValues = EnumValues({"mcq": Type.MCQ, "nat": Type.NAT});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String>? reverseMap;

  EnumValues(
    this.map,
  );

  Map<T, String> get reverse {
    reverseMap ??= map.map((k, v) => MapEntry(v, k));
    return reverseMap!;
  }
}
