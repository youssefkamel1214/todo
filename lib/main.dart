
import 'package:TODO/services/notification_services.dart';
import 'package:TODO/services/theme_services.dart';
import 'package:TODO/ui/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'ui/theme.dart'as th;

void main() async{

  runApp(const MyApp());
  WidgetsFlutterBinding.ensureInitialized;
  // NotifyHelper().InitializationNotification();
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
 
  @override

  Widget build(BuildContext context) {
    return  GetMaterialApp(
      title: 'Flutter Demo',
      theme:th.Themes.light,
      darkTheme: th.Themes.dark,
      themeMode:ThemeServices().theme,

      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}
