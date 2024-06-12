import 'package:flutter/material.dart';


class JobDetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Detail Job',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        ),
        leading: CircleAvatar(
          backgroundColor: Colors.black, // Warna latar belakang lingkaran
          radius: 10, // Ukuran radius lingkaran
          child: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white), // Ikon panah dengan warna putih
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
                          child: Text('      Detail      '),
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
                          child: Text('   Perusahaan   '),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Backend Developer',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      'Tokopedia',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(Icons.location_on, color: Colors.white),
                              SizedBox(width: 5),
                              Text(
                                'Medan',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(Icons.money_sharp, color: Colors.white),
                              Text(
                                ' Rp 10.000.000 - Rp 12.000.000',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Deskripsi Pekerjaan',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        // Tambahkan widget lain di sebelah kanan teks jika diperlukan
                      ],
                    ),
                    SizedBox(height: 15),
                    Text(
                      'Kami sedang mencari Pengembang Backend yang berpengalaman dan bersemangat untuk bergabung dengan tim teknis kami. Pengembang Backend akan bertanggung jawab dalam merancang, mengembangkan, dan memelihara komponen-komponen inti dari aplikasi kami. Kandidat yang ideal adalah seseorang yang memiliki pemahaman yang kuat tentang teknologi backend, basis data, dan pengelolaan infrastruktur untuk mendukung kebutuhan sistem yang kompleks dan skala besar.',
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.start,
                    ),
                    SizedBox(height: 20),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Kualifikasi',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        // Tambahkan widget lain di sebelah kanan teks jika diperlukan
                      ],
                    ),
                    SizedBox(height: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '• Mengembangkan dan memelihara backend aplikasi menggunakan bahasa pemrograman seperti Python, Java, Node.js, atau lainnya.',
                          style: TextStyle(color: Colors.white, fontSize: 10),
                        ),
                        Text(
                          '• Merancang dan mengimplementasikan API (Application Programming Interface) yang efisien dan aman untuk komunikasi antar komponen.',
                          style: TextStyle(color: Colors.white, fontSize: 10),
                        ),
                        Text(
                          '• Mengelola dan mengoptimalkan basis data, termasuk desain skema, query, dan indeks untuk kinerja yang optimal.',
                          style: TextStyle(color: Colors.white, fontSize: 10),
                        ),
                        Text(
                          '• Menjaga keamanan sistem dan data dengan menerapkan praktik-praktik terbaik dalam pengembangan keamanan.',
                          style: TextStyle(color: Colors.white, fontSize: 10),
                        ),
                        Text(
                          '• Berkolaborasi dengan tim frontend dan pengembang lainnya untuk memastikan integrasi yang mulus antara frontend dan backend.',
                          style: TextStyle(color: Colors.white, fontSize: 10),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),

                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor:  Color(0xFF2949F1),
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(horizontal: 120, vertical: 10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text('Lamar Pekerjaan'),
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
