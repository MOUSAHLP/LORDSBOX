import 'dart:async';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lordsbox/core/functions/background_service.dart';
import 'package:lordsbox/core/localization/change_localization.dart';
import 'package:lordsbox/core/localization/my_localization.dart';
import 'package:lordsbox/core/routes/routes.dart';
import 'package:lordsbox/core/services/storage_service.dart';
import 'package:lordsbox/core/theme/theme.dart';
import 'package:wakelock/wakelock.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Wakelock.enable();
  await initialAwesomeNotification();
  await initialServices();
  await initializeService();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Colors.grey,
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    LocaleController controller = Get.put(LocaleController());
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeApp().light,
      darkTheme: ThemeApp().light,
      // themeMode: ThemeController().handelThemeGet,
      getPages: routes,
      translations: MyLocalization(),
      locale: controller.language,
    );
  }
}
