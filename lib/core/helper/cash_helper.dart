import 'package:shared_preferences/shared_preferences.dart';

class CashNetwork {
  static late SharedPreferences sharedoref;
  // ignore: non_constant_identifier_names
  static Future CashInitialization() async {
    sharedoref = await SharedPreferences.getInstance();
  }

  static Future<bool> insertTocash(
      {required String key, required String value}) async {
    return await sharedoref.setString(key, value);
  }

 static String getCashData({required String key})  {
    return sharedoref.getString(key) ?? '';
  }

 static Future<bool> deleteCashItem({required String key}) async {
  return await  sharedoref.remove(key); 
  }
}

