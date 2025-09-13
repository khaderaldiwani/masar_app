import 'package:shared_preferences/shared_preferences.dart';

class CachHelper {

static late SharedPreferences sharedPreferences;
  static inti ()async{
sharedPreferences=await SharedPreferences.getInstance();
  }
static void  putBool({
    required String key,
    required bool value
  }){
    sharedPreferences.setBool(key, value);
  }
  static void  putString({
    required String key,
    required String value
  }){
    sharedPreferences.setString(key, value);
  }
 static String?  getString({
    required String key,
  }){
  return sharedPreferences.getString(key);
  } 

  static bool?  getBool({
    required String key,
  }){
  return sharedPreferences.getBool(key);
  }
}