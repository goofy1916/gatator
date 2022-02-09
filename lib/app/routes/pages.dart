import 'package:gatator/app/bindings/myhome_binding.dart';
import 'package:gatator/app/bindings/quizpage_binding.dart';
import 'package:gatator/app/bindings/quizprefrences_binding.dart';
import 'package:gatator/app/ui/pages/myhome_page/myhome_page.dart';
import 'package:gatator/app/ui/pages/quiz_page/quiz_page.dart';
import 'package:gatator/app/ui/pages/quizpreferences_page/quizpreferences_page.dart';
import 'package:get/get.dart';
part './routes.dart';

abstract class AppPages {
  static final pages = [
    GetPage(
        name: Routes.HOME,
        page: () => const MyHomePage(),
        binding: MyHomeBinding()),
    GetPage(
        name: Routes.QuizPrefrences,
        page: () => const QuizPreferencesPage(),
        binding: QuizPreferencesBinding()),
    GetPage(
        name: Routes.Quiz,
        page: () => const QuizPage(),
        binding: QuizPageBinding()),
  ];
}
