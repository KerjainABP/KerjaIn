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
    Uri url = Uri.parse("https://bekerjain-production.up.railway.app/api/pt/" + id);
    var hasil = await http.get(url);
    var data = jsonDecode(hasil.body);
    print(data);

    return Perusahaan(
      id: data['id'].toString(),
      nama: data['nama'].toString(),
      email: data['email'].toString(),
      deskripsi: data['deskripsi'].toString(),
      tahun_berdiri: data['tahun_berdiri'].toString(),
    );
  }
}
