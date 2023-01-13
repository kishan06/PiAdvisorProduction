import 'package:shared_preferences/shared_preferences.dart';

Future<int?> getUserId() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  int? user_id = await prefs.getInt('user_id');
  return user_id;
}
