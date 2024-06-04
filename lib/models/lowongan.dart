class Lowongan {
  final String id;
  final String namaPosisi;
  final String deskripsiPekerjaan;
  final String kualifikasi;
  final String lokasi;
  final int open;
  final int slotPosisi;
  final int gajiDari;
  final int gajiHingga;
  final String idPerusahaan;
  final String createdAt;
  final String updatedAt;

  Lowongan({
    required this.id,
    required this.namaPosisi,
    required this.deskripsiPekerjaan,
    required this.kualifikasi,
    required this.lokasi,
    required this.open,
    required this.slotPosisi,
    required this.gajiDari,
    required this.gajiHingga,
    required this.idPerusahaan,
    required this.createdAt,
    required this.updatedAt,
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
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
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
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}
