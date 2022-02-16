import 'dart:math' as math;

import 'package:gatator/app/data/models/question_model.dart';
import 'package:gatator/app/data/services/firebase_service.dart';
import 'package:gatator/app/routes/pages.dart';
import 'package:get/get.dart';

import 'myhome_controller.dart';

class QuizPreferencesController extends GetxController {
  final RxList<Question> questions = <Question>[].obs;

  var noOfQuestions = 10.obs;

  var timeInMinutes = 10.00.obs;

  MyHomeController controller = Get.find();

  bool notEnoughQuestions = false;

  updateNoOfQuestions(int i) {
    if (i < 0 && noOfQuestions.value < 2) {
      return;
    }
    noOfQuestions.value += i;
  }

  updateTimeWanted(double i) {
    if (i < 0 && timeInMinutes.value < 3) {
      return;
    }
    timeInMinutes.value += i;
  }

  takeQuiz() async {
    List<Question> allQuestions = [];

    for (final subject in controller.allSubjects) {
      List<String> subTopics = [];
      for (final sub in subject.subTopics ?? []) {
        if (sub.selected) {
          subTopics.add(sub.title);
        }
      }
      if (subTopics.isNotEmpty) {
        final response = await FirebaseService()
            .getQuestionsForSelection(subject, subTopics);
        for (final doc in response) {
          allQuestions.add(Question.fromJson(doc.data()));
        }
      }
    }

    allQuestions = allQuestions..shuffle();
    if (noOfQuestions.value > allQuestions.length) {
      notEnoughQuestions = true;
      questions.addAll(allQuestions);
    } else {
      questions.addAll(allQuestions.sublist(0, noOfQuestions.value));
    }
    if (allQuestions.isNotEmpty) {
      Get.toNamed(Routes.Quiz);
    }
  }
}
