import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:kerjain/models/lowongan.dart';

class LowonganService {
  static const String baseUrl =
      "https://bekerjain-production.up.railway.app/api/user/lowongan/";

  static Future<Lowongan> connectAPI(String id) async {
    Uri url = Uri.parse(baseUrl + id);
    var hasil = await http.get(url);
    var data = jsonDecode(hasil.body);

    return Lowongan.fromJson(data);
  }

  static Future<List<Lowongan>> fetchLowongan() async {
    try {
      final response = await http.get(Uri.parse(baseUrl + 'all'));
      if (response.statusCode == 200) {
        final body = response.body;
        final List<dynamic> jsonData = jsonDecode(body);
        List<Lowongan> lowong =
            jsonData.map((json) => Lowongan.fromJson(json)).toList();
        return lowong;
      } else {
        throw Exception('Failed to load lowongan');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception(e.toString());
    }
  }

  static Future<List<Lowongan>> checkLowongan(String id) async {
    try {
      final response = await http.get(Uri.parse(
          'https://bekerjain-production.up.railway.app/api/pt/lowonganperusahaan/${id}'));
      if (response.statusCode == 200) {
        final body = response.body;
        final List<dynamic> jsonData = jsonDecode(body);

        List<Lowongan> lowong =
            jsonData.map((json) => Lowongan.fromJson(json)).toList();

        return lowong;
      } else {
        throw Exception('Failed to load lowongan');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception(e.toString());
    }
  }

  static Future<void> addLowongan(Lowongan lowongan) async {
    final response = await http.post(
      Uri.parse(
          'https://kerjainbe-production.up.railway.app/api/pt/newlowongan/e0a2e7ec-36d4-4150-af23-e685c628b2df'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(lowongan),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to add lowongan');
    }
  }
}
