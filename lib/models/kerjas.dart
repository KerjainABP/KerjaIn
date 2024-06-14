import 'dart:convert';
import 'package:http/http.dart' as http;

class Kerjas {
  String id, id_lowongan, id_perusahaan, id_user, nama_posisi, status;

  Kerjas({
    this.id = '',
    this.id_lowongan = '',
    this.id_perusahaan = '',
    this.id_user = '',
    this.nama_posisi = '',
    this.status = '',
  });

  factory Kerjas.fromJson(Map<String, dynamic> json) {
    return Kerjas(
      id: json['id'],
      id_lowongan: json['id_lowongan'],
      id_perusahaan: json['id_perusahaan'],
      id_user: json['id_user'],
      nama_posisi: json['nama_posisi'],
      status: json['status'],
    );
  }

  static Future<List<Kerjas>> connectAPI(String id,
      {String? id_perusahaan}) async {
    Uri url = Uri.parse(
        "https://bekerjain-production.up.railway.app/api/user/lowonganstatus/" +
            id);
    var hasil = await http.get(url);
    var data = jsonDecode(hasil.body);
    print(data);
    List<Kerjas> kerjasList = [];

    for (var item in data) {
      Kerjas kerjas = Kerjas(
        id: item['id'],
        id_lowongan: item['id_lowongan'],
        id_perusahaan: item['id_perusahaan'],
        id_user: item['id_user'],
        nama_posisi: item['nama_posisi'],
        status: item['status'],
      );

      // Check if id_perusahaan is provided and matches the current item
      if (id_perusahaan == null || kerjas.id_perusahaan == id_perusahaan) {
        kerjasList.add(kerjas);
      }
    }

    return kerjasList;
  }
}
