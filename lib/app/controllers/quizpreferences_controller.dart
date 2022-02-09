import 'package:gatator/app/routes/pages.dart';
import 'package:get/get.dart';

class QuizPreferencesController extends GetxController {
  var noOfQuestions = 10.obs;

  var timeInMinutes = 10.00.obs;

  updateNoOfQuestions(int i) {
    if (i < 0 && noOfQuestions.value < 0) {
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

  takeQuiz() {
    Get.toNamed(Routes.Quiz);
  }
}
