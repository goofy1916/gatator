import 'package:get/get.dart';
import '../controllers/quizpreferences_controller.dart';

class QuizPreferencesBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<QuizPreferencesController>(() => QuizPreferencesController());
  }
}
