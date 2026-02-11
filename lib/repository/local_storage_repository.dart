import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageRepository {
  void setToken( String tok) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('x-auth-token', tok);
  }

  Future<String?> getToken( ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token =  prefs.getString('x-auth-token');

    return token;
  }

}