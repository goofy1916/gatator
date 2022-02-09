import 'package:gatator/app/data/services/firebase_service.dart';
import 'package:get/get.dart';
import '../controllers/myhome_controller.dart';

class MyHomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MyHomeController>(() => MyHomeController());
  }
}
