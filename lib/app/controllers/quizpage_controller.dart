import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gatator/app/controllers/home_controller.dart';
import 'package:gatator/app/data/models/question_model.dart';
import 'package:gatator/app/ui/utils/enum.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart' show rootBundle;

class QuizPageController extends GetxController {
  RxBool isLoading = true.obs;
  RxList<Question> questions = <Question>[].obs;

  HomeController myHomeController = Get.find();

  RxBool submitted = false.obs;
  int correctAnswers = 0;

  RxInt currentQuestion = 0.obs;

  @override
  Future<void> onInit() async {
    try {
      isLoading(true);
      questions.value = myHomeController.questions;
      log("Questions Loaded!");
    } catch (e) {
      log("Error getting questions");
    } finally {
      isLoading(false);
    }
    super.onInit();
  }

  final questionController = PageController(initialPage: 0);

  Future<String> getJson() {
    Future.delayed(const Duration(seconds: 2));
    return rootBundle.loadString('questions.json');
  }

  selectAnswer(String? value, int index) {
    if (!questions[index].selectedAnswer.contains(value)) {
      questions[index].selectedAnswer.add(value.toString());
    } else {
      questions[index].selectedAnswer.remove(value.toString());
    }
    questions.refresh();
  }

  natAnswer(String value, int index) {
    if (questions[index].selectedAnswer.isNotEmpty) {
      questions[index].selectedAnswer.first = value;
    } else {
      questions[index].selectedAnswer.add(value);
    }
    questions.refresh();
  }

  submit() {
    correctAnswers = 0;
    for (final question in questions) {
      if (question.selectedAnswer.isNotEmpty) {
        if (question.type == QuestionType.MCQ) {
          if (const ListEquality().equals(question.selectedAnswer..sort(),
              question.correctAnswer!..sort())) {
            question.isRight = true;
            correctAnswers++;
          }
        } else if (question.type == QuestionType.NAT) {
          if (double.parse(question.from!) <=
                  double.parse(question.selectedAnswer.first) &&
              double.parse(question.selectedAnswer.first) <=
                  double.parse(question.to!)) {
            question.isRight = true;
            correctAnswers++;
          }
        }
      }
    }
    questions.refresh();
    submitted.value = true;
  }

  updateCurrentQuestion(int value) {
    currentQuestion.value = value;
    update();
  }

  updateStep(int i) {
    if (currentQuestion.value < questions.length - 1 && i > 0) {
      currentQuestion.value += i;
    }
    if (currentQuestion.value > 0 && i < 0) {
      currentQuestion.value += i;
    }
    update();
  }
}
