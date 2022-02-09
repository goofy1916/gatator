import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gatator/app/bindings/myhome_binding.dart';
import 'package:gatator/firebase_config.dart';
import 'package:get/get.dart';

import 'app/routes/pages.dart';
import 'app/ui/theme/app_theme_data.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseConfig.platformOptions);
  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: Routes.HOME,
    theme: appThemeData,
    defaultTransition: Transition.fade,
    initialBinding: MyHomeBinding(),
    getPages: AppPages.pages,
  ));
}
