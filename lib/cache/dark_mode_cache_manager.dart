import 'package:hive_flutter/hive_flutter.dart';
import 'package:leben_in_deutschland/constants/string_constants.dart';

class DarkModeCacheManager {
  Box? _darkModeBox;

  static final DarkModeCacheManager _darkModeCacheManager =
      DarkModeCacheManager.internal();

  factory DarkModeCacheManager() {
    return _darkModeCacheManager;
  }
  DarkModeCacheManager.internal();

  Box? get getDarkModeBox => _darkModeBox;

   Future<void> init() async {
    _darkModeBox = Hive.box(darkModeBoxName);
  }

  bool getDarkMode(){
    return _darkModeBox?.get('darkMode', defaultValue: true);
  }

  void putDarkMode(bool darkMode){
    _darkModeBox?.put('darkMode', !darkMode);
  }
}
