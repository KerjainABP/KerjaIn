import 'dart:convert';

import 'package:http/http.dart' as http;

class Lowongan {
  String id;
  String namaPosisi;
  String deskripsiPekerjaan;
  String kualifikasi;
  String lokasi;
  int open;
  int slotPosisi;
  int gajiDari;
  int gajiHingga;
  String idPerusahaan;

  Lowongan({
    this.id = "",
    this.namaPosisi = "",
    this.deskripsiPekerjaan = "",
    this.kualifikasi = "",
    this.lokasi = "",
    this.open = 0,
    this.slotPosisi = 0,
    this.gajiDari = 0,
    this.gajiHingga = 0,
    this.idPerusahaan = "",
  });

  factory Lowongan.fromJson(Map<String, dynamic> json) {
    return Lowongan(
      id: json['id'],
      namaPosisi: json['nama_posisi'],
      deskripsiPekerjaan: json['deskripsi_pekerjaan'],
      kualifikasi: json['kualifikasi'],
      lokasi: json['lokasi'],
      open: json['open'],
      slotPosisi: json['slot_posisi'],
      gajiDari: json['gaji_dari'],
      gajiHingga: json['gaji_hingga'],
      idPerusahaan: json['id_perusahaan'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nama_posisi': namaPosisi,
      'deskripsi_pekerjaan': deskripsiPekerjaan,
      'kualifikasi': kualifikasi,
      'lokasi': lokasi,
      'open': open,
      'slot_posisi': slotPosisi,
      'gaji_dari': gajiDari,
      'gaji_hingga': gajiHingga,
      'id_perusahaan': idPerusahaan,
    };
  }

  static Future<Lowongan> connectAPI(String id) async {
    Uri url = Uri.parse(
        "https://bekerjain-production.up.railway.app/api/user/lowongan/" + id);
    var hasil = await http.get(url);
    var data = jsonDecode(hasil.body);
    print(data.body);
    return Lowongan(
      id: data['id'].toString(),
      namaPosisi: data['nama_posisi'].toString(),
      deskripsiPekerjaan: data['deskripsi_pekerjaan'].toString(),
      kualifikasi: data['kualifikasi'].toString(),
      lokasi: data['lokasi'].toString(),
      open: data['open'],
      slotPosisi: data['slot_posisi'],
      gajiDari: data['gaji_dari'],
      gajiHingga: data['gaji_hingga'],
      idPerusahaan: data['data_perusahaan'],
    );
  }
}
