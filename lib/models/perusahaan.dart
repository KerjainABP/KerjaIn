import 'dart:convert';

import 'package:http/http.dart' as http;

class Perusahaan {
  String id, nama, email, password, deskripsi, tahun_berdiri;
  Perusahaan({
    this.id = '',
    this.nama = "",
    this.email = '',
    this.password = '',
    this.deskripsi = '',
    this.tahun_berdiri = '',
  });
  static Future<Perusahaan> connectAPI(String id) async {
    Uri url = Uri.parse("http://127.0.0.1:8000/api/pt/" + id);
    var hasil = await http.get(url);
    var data = jsonDecode(hasil.body);
    print(data);
    return Perusahaan(
        id: data['id'],
        nama: data['nama'],
        email: data['email'],
        deskripsi: data['deskripsi'],
        tahun_berdiri: data['tahun_berdiri']);
  }
}
