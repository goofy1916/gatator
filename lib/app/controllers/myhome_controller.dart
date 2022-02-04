import 'package:get/get.dart';

class MyHomeController extends GetxController {
  RxList<Map<String, dynamic>> subjectsList = <Map<String, dynamic>>[
    {"title": "Digital Logic", "isSelected": false},
    {"title": "Data Structures and Algorithms", "isSelected": false},
    {"title": "Computer Networks", "isSelected": false},
    {"title": "Opertaing System", "isSelected": false},
    {"title": "DBMS", "isSelected": false},
    {"title": "COA", "isSelected": false},
    {"title": "Compiler Design", "isSelected": false},
    {"title": "Discrete Mathematics and Graph Theory", "isSelected": false}
  ].obs;

  updateSelectedSubjects(Map<String, dynamic> subject) {
    subjectsList[subjectsList.indexWhere((p0) => subject == p0)]['isSelected'] =
        !subject['isSelected'];
  }
}
