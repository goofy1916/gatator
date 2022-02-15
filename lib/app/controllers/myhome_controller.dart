import 'dart:developer';

import 'package:gatator/app/data/models/subject_model.dart';
import 'package:gatator/app/data/services/firebase_service.dart';
import 'package:gatator/app/routes/pages.dart';
import 'package:get/get.dart';

class MyHomeController extends GetxController {
  final RxBool _isLoading = false.obs;
  final RxList<Subject> _allSubjects = RxList<Subject>([]);
  final RxList<bool> _isExpanded = <bool>[].obs;

  bool get isLoading => _isLoading.value;
  List<Subject> get allSubjects => _allSubjects;
  List<bool> get isExpanded => _isExpanded;

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

  toQuizCustomizationScreen() {
    Get.toNamed(Routes.QuizPrefrences);
  }

  addQuestion() {
    Get.toNamed(Routes.AddQuestion);
  }
}
