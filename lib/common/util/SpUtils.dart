import 'package:shared_preferences/shared_preferences.dart';

class SpUtils {
  static String userName = "username";
  static String uid = "uid";
  static String phone = "phone";

  Future<SharedPreferences> _sp = SharedPreferences.getInstance();

  Future<bool> saveString(String key,String value) async {
    final SharedPreferences sp = await _sp;
    sp.setString(key, value).then((value){
      return value;
    });
    return false;
  }
  Future<bool> saveInt(String key,int value) async {
    final SharedPreferences sp = await _sp;
    sp.setInt(key, value).then((value){
      return value;
    });
    return false;
  }

  Future<String> getString(String key) async{
    final SharedPreferences sp = await _sp;
    return sp.getString(key);
  }


  Future<int> getInt(String key) async{
    final SharedPreferences sp = await _sp;
    return sp.getInt(key);
  }

}