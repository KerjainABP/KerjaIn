import 'dart:convert';
import 'package:http/http.dart' as http;

class UserService {
  static const String baseUrl =
      'https://bekerjain-production.up.railway.app/api/user/';

  Future<Map<String, dynamic>?> fetchUser(String idUser) async {
    try {
      var apiUrl = Uri.parse('$baseUrl$idUser');
      var response = await http.get(apiUrl);

      print('Response: ${response.body}');

      if (response.statusCode == 200) {
        var userData = jsonDecode(response.body);
        String nama =
            userData['nama']; // Memanggil atribut 'nama' dari userData
        print('Nama pengguna: $nama'); // Contoh pencetakan nama pengguna

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
