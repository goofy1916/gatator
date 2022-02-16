import 'dart:developer';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:image_picker_web/image_picker_web.dart';
import 'package:universal_io/io.dart' as io;
import 'dart:math' as math;

import 'package:flutter/widgets.dart';
import 'package:gatator/app/controllers/home_controller.dart';
import 'package:gatator/app/data/models/question_model.dart';
import 'package:gatator/app/data/models/subject_model.dart';
import 'package:gatator/app/data/services/firebase_service.dart';
import 'package:gatator/app/ui/utils/enum.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AddQuestionController extends GetxController {
  final RxBool isLoading = false.obs;
  final RxBool _questionSelected = false.obs;
  final RxBool _solSelected = false.obs;

  var natToController = TextEditingController();
  var natFromController = TextEditingController();

  RxList<String> subjectsList = <String>[].obs;
  RxList<String> subTopicList = <String>[].obs;

  Rxn<Subject> subject = Rxn<Subject>();
  Rxn<SubTopic> subTopic = Rxn<SubTopic>();

  get getSolutionImage => solutionImage;

  get getQuestionImage => questionImage;

  @override
  void onInit() {
    try {
      isLoading(true);
    } catch (e) {
      log("Subject not initialized");
    } finally {
      isLoading(false);
    }
    super.onInit();
  }

  var options = 4.obs;

  var availableOptions = ["A", "B", "C", "D", "E", "F", "G"];

  var correctAnswers = <String>[].obs;

  var questionImage;
  var solutionImage;

  var typeOfQuestion = QuestionType.MCQ.obs;

  updateTypeOfQuestion(bool value) {
    typeOfQuestion.value = value ? QuestionType.NAT : QuestionType.MCQ;
  }

  bool get questionSelected => _questionSelected.value;
  bool get solutionSelected => _solSelected.value;

  Future<void> imgFromGallery(String type) async {
    final image = kIsWeb
        ? await ImagePickerWeb.getImageAsBytes()
        : await ImagePicker().pickImage(
            source: ImageSource.gallery, imageQuality: 50, maxHeight: 500);
    if (image != null) {
      if (type == "question") {
        questionImage = image;
        _questionSelected.value = true;
      } else if (type == "solution") {
        solutionImage = image;
        _solSelected.value = true;
      }
    }
    update();
  }

  selectAnswer(String? value) {
    if (!correctAnswers.contains(value)) {
      correctAnswers.add(value.toString());
    } else {
      correctAnswers.remove(value.toString());
    }
    correctAnswers.refresh();
  }

  updateOptions(int i) {
    if (i < 0 && options.value < 5) {
      return;
    } else if (i > 0 && options.value > 4) {
      return;
    }
    options.value += i;
    update();
  }

  removeQuestion() {
    questionImage = null;
    _questionSelected.value = false;
    update();
  }

  void updateSubject(Subject? value) {
    if (value != null) {
      subject.value = value;
    }
    updateSubTopic(null);
  }

  void updateSubTopic(SubTopic? value) {
    subTopic.value = value;
    update();
  }

  submit() async {
    try {
      isLoading(true);

      int rand = (math.Random().nextInt(1000) + 100);
      String questionUrl = await FirebaseService().uploadImageToFirebase(
          questionImage,
          "question" +
              subject.value!.title.removeAllWhitespace +
              subTopic.value!.title.removeAllWhitespace +
              rand.toString(),
          true);
      String answerUrl = await FirebaseService().uploadImageToFirebase(
          solutionImage,
          "solution" +
              subject.value!.title.removeAllWhitespace +
              subTopic.value!.title.removeAllWhitespace +
              rand.toString(),
          false);
      Question question = Question(
          type: typeOfQuestion.value,
          question: questionUrl,
          answer: answerUrl,
          topic: subject.value!.title,
          subTopic: subTopic.value!.title,
          selectedAnswer: [],
          from: typeOfQuestion.value == QuestionType.NAT
              ? natFromController.text
              : null,
          to: typeOfQuestion.value == QuestionType.NAT
              ? natToController.text
              : null,
          correctAnswer:
              typeOfQuestion.value == QuestionType.NAT ? [] : correctAnswers,
          options: typeOfQuestion.value == QuestionType.NAT
              ? []
              : availableOptions.sublist(0, options.value));
      await FirebaseService().postQuestion(question.toJson());
      clearForm();
    } catch (e) {
      log("Question not created!" + e.toString());
    } finally {
      isLoading(false);
    }
  }

  void clearForm() {
    log(subject.value!.title.toString() + subTopic.value!.title.toString());
    natFromController.clear();
    natToController.clear();
    correctAnswers.clear();
    questionImage = null;
    _questionSelected.value = false;
    solutionImage = null;
    _solSelected.value = false;
    options.value = 4;
    subject.value = null;
    subTopic.value = null;
  }

  removeSolution() {
    solutionImage = null;
    _solSelected.value = false;
    update();
  }
}
