import 'dart:convert';

import 'package:http/http.dart' as http;

class User {
  String id, nama, email, password, deskripsi, tanggal_lahir;
  User({
    this.id = '',
    this.nama = "",
    this.email = '',
    this.password = '',
    this.deskripsi = '',
    this.tanggal_lahir = '',
  });
  static Future<User> connectAPI(String id) async {
    Uri url = Uri.parse("https://bekerjain-production.up.railway.app/api/user/" + id);
    var hasil = await http.get(url);
    var data = jsonDecode(hasil.body);
    print(data);
    return User(
        id: data['id'],
        nama: data['nama'],
        email: data['email'],
        deskripsi: data['deskripsi'],
        tanggal_lahir: data['tanggal_lahir']);
  }
}
