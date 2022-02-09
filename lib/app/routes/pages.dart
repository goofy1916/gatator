import 'package:gatator/app/bindings/myhome_binding.dart';
import 'package:gatator/app/ui/pages/myhome_page/myhome_page.dart';
import 'package:get/get.dart';
part './routes.dart';

abstract class AppPages {
  static final pages = [
    GetPage(
        name: Routes.HOME,
        page: () => const MyHomePage(),
        binding: MyHomeBinding())
  ];
}
