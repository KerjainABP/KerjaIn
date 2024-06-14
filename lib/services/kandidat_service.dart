import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:kerjain/models/kandidat.dart';

class KandidatService {
  static Future<List<Kandidat>> fetchKandidat(String idLowongan) async {
    final url = Uri.parse(
        'https://bekerjain-production.up.railway.app/api/pt/lowonganperusahaan/pendaftar/$idLowongan');
    final response = await http.get(url);
    print(
        "Response kandidat: ${response.body}"); // Print the response body for debugging

    if (response.statusCode == 200) {
      List<dynamic> jsonList = jsonDecode(response.body);
      return jsonList.map((json) => Kandidat.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load candidates');
    }
  }
}
