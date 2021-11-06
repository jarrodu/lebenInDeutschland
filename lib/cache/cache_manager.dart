import 'package:shared_preferences/shared_preferences.dart';

class CacheManager {
  static CacheManager? _instance;
  static CacheManager get instance{
    if (_instance != null) return _instance!;
    _instance = CacheManager._init();
    return _instance!;
  }

  late SharedPreferences prefs;
  CacheManager._init(){
    initPreferences();
  }

  Future<void> initPreferences() async{
    prefs = await SharedPreferences.getInstance();
  }

  Future<bool> setThemePref(bool themePref) async {
    return await prefs.setBool("themePref", themePref);
  }

  Future<bool?> getThemePref() async{
    final bool? themePref = prefs.getBool("themePref");
    return themePref;
  }
}