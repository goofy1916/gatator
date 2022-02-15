// To parse this JSON data, do
//
//     final question = questionFromJson(jsonString);

import 'dart:convert';
import 'package:gatator/app/ui/utils/enum.dart';

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
    this.options,
    this.correctAnswer = const [],
    required this.selectedAnswer,
    this.answered = false,
    this.isRight = false,
  });

  QuestionType type;
  String question;
  String? from;
  String? to;
  String answer;
  String topic;
  String subTopic;
  List<String>? options;
  List<String>? correctAnswer;
  List<String> selectedAnswer;
  bool answered;
  bool isRight;

  factory Question.fromJson(Map<String, dynamic> json) => Question(
      type: typeValues.map[json["type"]]!,
      question: json["question"],
      from: json["from"],
      to: json["to"],
      answer: json["answer"],
      topic: json["topic"],
      subTopic: json["subTopic"],
      options: json["options"] == null
          ? null
          : List<String>.from(json["options"].map((x) => x)),
      correctAnswer: json["correctAnswer"] == null
          ? null
          : List<String>.from(json["correctAnswer"].map((x) => x)),
      selectedAnswer: []);

  Map<String, dynamic> toJson() => {
        "type": typeValues.reverse[type],
        "question": question,
        "from": from,
        "to": to,
        "answer": answer,
        "topic": topic,
        "subTopic": subTopic,
        "options": options == null
            ? null
            : List<dynamic>.from((options ?? []).map((x) => x)),
        "correctAnswer": correctAnswer,
      };
}

final typeValues =
    EnumValues({"mcq": QuestionType.MCQ, "nat": QuestionType.NAT});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String>? reverseMap;

  EnumValues(
    this.map,
  );

  Map<T, String> get reverse {
    reverseMap ??= map.map((k, v) => MapEntry(v, k));
    return reverseMap!;
  }
}
