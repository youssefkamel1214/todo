import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';
class ThemeServices {
  final GetStorage _box=GetStorage();
  final _key='isdarkmode';
  ThemeMode get theme =>_loadfrombox()?ThemeMode.dark:ThemeMode.light;
  bool _loadfrombox() => _box.read<bool>(_key)??true;
  void _savethemebox(bool isDarkmode)=> _box.write(_key,isDarkmode);
  void switchmode(){
    Get.changeThemeMode(_loadfrombox()?ThemeMode.light:ThemeMode.dark);
    _savethemebox(!_loadfrombox());
  }
}
