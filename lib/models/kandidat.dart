class Kandidat {
  final String id;
  final String nama;
  final String email;
  final String deskripsi;
  final String tanggalLahir;
  final String createdAt;
  final String updatedAt;

  Kandidat({
    required this.id,
    required this.nama,
    required this.email,
    required this.deskripsi,
    required this.tanggalLahir,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Kandidat.fromJson(Map<String, dynamic> json) {
    return Kandidat(
      id: json['id'],
      nama: json['nama'],
      email: json['email'],
      deskripsi: json['deskripsi'],
      tanggalLahir: json['tanggal_lahir'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}
