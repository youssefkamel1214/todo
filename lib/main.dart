
import 'package:TODO/controllers/task_controller.dart';
import 'package:TODO/db/db_helper.dart';
import 'package:TODO/services/theme_services.dart';
import 'package:TODO/ui/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'ui/theme.dart'as th;

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
   await DBHelper.InitDB();
   await GetStorage.init();
  runApp(const MyApp());

  // NotifyHelper().InitializationNotification();
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
 
  @override

  Widget build(BuildContext context) {
    Get.put(TaskController());
    return  GetMaterialApp(
      title: 'Flutter Demo',
      theme:th.Themes.light,
      darkTheme: th.Themes.dark,
      themeMode:ThemeServices().theme,

      debugShowCheckedModeBanner: false,
      home:  HomePage(),
    );
  }
}
