import 'dart:convert';
import 'package:http/http.dart' as http;

class UserService {
  static const String baseUrl = 'https://bekerjain-production.up.railway.app/api/user/';

  Future<Map<String, dynamic>?> fetchUser(String idUser) async {
    try {
      var apiUrl = Uri.parse('$baseUrl$idUser');
      var response = await http.get(apiUrl);

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        var userData = jsonDecode(response.body);
        return userData;
      } else {
        print('Failed to load user data: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error fetching user data: $e');
      return null;
    }
  }
}
