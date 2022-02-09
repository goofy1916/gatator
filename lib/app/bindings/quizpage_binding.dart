
import 'package:get/get.dart';
import '../controllers/quizpage_controller.dart';


class QuizPageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<QuizPageController>(() => QuizPageController());
  }
}