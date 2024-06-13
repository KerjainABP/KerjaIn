import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: JobDetailScreen(),
    );
  }
}

class JobDetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Buat Iklan',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        ),
        leading: CircleAvatar(
          backgroundColor: Colors.black, // Warna latar belakang lingkaran
          radius: 10, // Ukuran radius lingkaran
          child: IconButton(
            icon: Icon(Icons.arrow_back,
                color: Colors.white), // Ikon panah dengan warna putih
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 20),
              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(
                  'https://avatars.githubusercontent.com/u/91422614?v=4',
                ),
              ),
              SizedBox(height: 20),
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Color(0xFF081127),
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(20),
                  ),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Text('     Detail     '),
                        ),
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Text(' Perusahaan '),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Backend Developer',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      'Tokopedia',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Deskripsi Perusahaan',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'PT Tokopedia merupakan perusahaan teknologi Indonesia '
                      'dengan misi pemerataan ekonomi secara digital di Indonesia. '
                      'Visi perusahaan adalah untuk menciptakan ekosistem di mana '
                      'siapa pun bisa memulai dan menemukan apa pun. Hingga saat ini, '
                      'Tokopedia termasuk marketplace yang paling banyak dikunjungi '
                      'oleh masyarakat Indonesia.\n\n'
                      'Tokopedia turut mendukung para pelaku Usaha Mikro Kecil dan '
                      'Menengah (UMKM) dan perorangan untuk mengembangkan usaha mereka '
                      'dengan memasarkan produk secara daring dengan Pemerintah dan '
                      'pihak-pihak lainnya. Salah satu program kolaborasi yang diinisiasi '
                      'oleh Tokopedia adalah acara tahunan MAKERFEST yang diadakan sejak '
                      'bulan Maret 2018.',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF2949F1),
                        foregroundColor: Colors.white,
                        padding:
                            EdgeInsets.symmetric(horizontal: 140, vertical: 10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text('Buat Iklan'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
