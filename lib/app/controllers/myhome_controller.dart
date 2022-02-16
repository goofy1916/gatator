import 'dart:developer';

import 'package:gatator/app/data/models/question_model.dart';
import 'package:gatator/app/data/models/subject_model.dart';
import 'package:gatator/app/data/services/firebase_service.dart';
import 'package:gatator/app/routes/pages.dart';
import 'package:get/get.dart';

class MyHomeController extends GetxController {
  final RxBool _isLoading = false.obs;
  final RxList<Subject> _allSubjects = RxList<Subject>([]);
  final RxList<bool> _isExpanded = <bool>[].obs;
  final RxList<Question> questions = <Question>[].obs;

  bool notEnoughQuestions = false;

  bool get isLoading => _isLoading.value;
  List<Subject> get allSubjects => _allSubjects;
  List<bool> get isExpanded => _isExpanded;

  var noOfQuestions = 10.obs;

  updateIsExpanded(int index) {
    _isExpanded[index] = !_isExpanded[index];
    _isExpanded.refresh();
  }

  @override
  Future<void> onInit() async {
    try {
      _isLoading(true);
      _allSubjects.value = await FirebaseService().getSubjects();
      _isExpanded.value = List.filled(_allSubjects.length, false);
    } catch (e) {
      log("Error fetching subjects");
    } finally {
      _isLoading(false);
    }
    super.onInit();
  }

  selectSubject(Subject subject) {
    subject.selected = !subject.selected;
    for (var element in subject.subTopics ?? []) {
      element.selected = subject.selected;
    }
    _allSubjects.refresh();
  }

  selectSubjectTopic(Subject subject, SubTopic topic) {
    subject.subTopics!.firstWhere((element) => element == topic).selected =
        !subject.subTopics!.firstWhere((element) => element == topic).selected;
    if (!subject.selected) {
      bool subjectSelected = false;
      for (var topic in subject.subTopics!) {
        if (topic.selected) {
          subjectSelected = true;
        }
      }
      subject.selected = subjectSelected;
    }
    _allSubjects.refresh();
  }

  updateNoOfQuestions(int i) {
    if (i < 0 && noOfQuestions.value < 2) {
      return;
    }
    noOfQuestions.value += i;
  }

  takeQuiz() async {
    List<Question> allQuestions = [];

    for (final subject in allSubjects) {
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

  addQuestion() {
    Get.toNamed(Routes.AddQuestion);
  }
}
