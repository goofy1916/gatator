
import 'package:get/get.dart';
import '../controllers/addquestion_controller.dart';


class AddQuestionBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddQuestionController>(() => AddQuestionController());
  }
}