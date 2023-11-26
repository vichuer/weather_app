import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  //Singleton class
  static final SharedPreferencesService _instance =
      SharedPreferencesService._internal();

  factory SharedPreferencesService() {
    return _instance;
  }

  SharedPreferencesService._internal();

  static late final SharedPreferences prefs;

  Future<void> setPreferences() async {
    prefs = await SharedPreferences.getInstance();
  }
}
