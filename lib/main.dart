import 'package:flutter/material.dart';
import 'package:gatator/app/bindings/myhome_binding.dart';
import 'package:get/get.dart';

import 'app/routes/pages.dart';
import 'app/ui/theme/app_theme_data.dart';

void main() {
  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: Routes.HOME,
    theme: appThemeData,
    defaultTransition: Transition.fade,
    initialBinding: MyHomeBinding(),
    getPages: AppPages.pages,
  ));
}
