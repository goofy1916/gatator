import 'dart:developer';

import 'package:gatator/app/data/models/question_model.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart' show rootBundle;

class QuizPageController extends GetxController {
  RxBool isLoading = true.obs;
  RxList<Question> questions = <Question>[].obs;

  @override
  Future<void> onInit() async {
    try {
      isLoading(true);
      questions.value = questionFromJson(await getJson());
    } catch (e) {
      log("Error getting questions");
    } finally {
      isLoading(false);
    }
    super.onInit();
  }

  Future<String> getJson() {
    Future.delayed(const Duration(seconds: 2));
    return rootBundle.loadString('questions.json');
  }
}
