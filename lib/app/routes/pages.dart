import 'package:gatator/app/bindings/addquestion_binding.dart';
import 'package:gatator/app/bindings/home_binding.dart';
import 'package:gatator/app/bindings/quizpage_binding.dart';
import 'package:gatator/app/ui/pages/addquestion_page/addquestion_page.dart';
import 'package:gatator/app/ui/pages/home_page/home_page.dart';
import 'package:gatator/app/ui/pages/quiz_page/quiz_page.dart';
import 'package:get/get.dart';
part './routes.dart';

abstract class AppPages {
  static final pages = [
    GetPage(
        name: Routes.HOME,
        page: () => const HomePage(),
        binding: MyHomeBinding()),
    GetPage(
        name: Routes.Quiz,
        page: () => const QuizPage(),
        binding: QuizPageBinding()),
    GetPage(
        name: Routes.AddQuestion,
        page: () => AddQuestionPage(),
        binding: AddQuestionBinding()),
  ];
}
