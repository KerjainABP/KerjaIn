import 'package:flutter/material.dart';
import 'package:kerjain/models/lowongan.dart';
import 'package:kerjain/models/perusahaan.dart';
import 'package:kerjain/screen/BuatIklan/BuatIklan.dart';
import 'package:kerjain/screen/Perusahaan/Pekerjaku.dart';
import 'package:kerjain/screen/Perusahaan/Iklanku.dart';
import 'package:kerjain/screen/Perusahaan/ProfilePerusahaan.dart';
import 'package:kerjain/services/lowongan_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomePerusahaan(),
    );
  }
}

class HomePerusahaan extends StatefulWidget {
  const HomePerusahaan({Key? key}) : super(key: key);

  @override
  _HomePerusahaanState createState() => _HomePerusahaanState();
}

class _HomePerusahaanState extends State<HomePerusahaan> {
  late String idPerusahaan;
  late Future<List<Lowongan>> futureLowongan;
  Perusahaan _perusahaan = Perusahaan();
  List<Lowongan> _lowonganList = [];

  @override
  void initState() {
    super.initState();
    getIdUser().then((value) {
      setState(() {
        idPerusahaan = value!;
        // Panggil API setelah mendapatkan idUser
        Perusahaan.connectAPI(idPerusahaan).then((value) {
          setState(() {
            _perusahaan = value;
          });
        });
        futureLowongan = _fetchLowongan(idPerusahaan);
      });
    });
  }

  Future<List<Lowongan>> _fetchLowongan(String idPerusahaan) async {
    try {
      List<Lowongan> lowongan =
          await LowonganService.checkLowongan(idPerusahaan);
      return lowongan;
    } catch (e) {
      print('Error fetching lowongan: $e');
      throw e; // Rethrow error to handle it in FutureBuilder
    }
  }

  Future<String?> getIdUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('idPerusahaan');
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        body: TabBarView(
          children: [
            FutureBuilder<List<Lowongan>>(
              future: futureLowongan,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else {
                  List<Lowongan> lowonganList = snapshot.data ?? [];
                  return SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _perusahaan.nama ?? "",
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Temukan Individu yang sesuai',
                            style: TextStyle(fontSize: 24, color: Colors.black),
                          ),
                          SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => BuatIklanScreen(),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color.fromRGBO(5, 26, 73, 1),
                              minimumSize: Size(double.infinity, 50),
                            ),
                            child: Text(
                              'Buat Iklan Anda',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Iklan Pekerjaan',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'Lihat Semua',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 8),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: lowonganList.length,
                            itemBuilder: (context, index) {
                              Lowongan lowongan = lowonganList[index];
                              return JobCard(
                                title: lowongan.namaPosisi,
                                company: _perusahaan.nama,
                                rating: lowongan.slotPosisi,
                                location: lowongan.lokasi,
                                idLowongan: lowongan.id,
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                }
              },
            ),
            IklankuPage(),
            // Content of Tab 2

            // Content of Tab 3
            PekerjakuPage(),

            // Content of Tab 4
            ProfilePage(),
          ],
        ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(7.0)),
            border: Border(
              top: BorderSide(
                color: Color.fromRGBO(5, 26, 73, 1),
                width: 2.0,
              ),
            ),
          ),
          child: TabBar(
            indicator: BoxDecoration(
              border: Border.all(
                color: Color.fromRGBO(5, 26, 73, 1),
                width: 1.0,
              ),
              color: Color.fromRGBO(5, 26, 73, 1),
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
            indicatorColor: Colors.white,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.grey,
            indicatorPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            indicatorWeight: 12,
            indicatorSize: TabBarIndicatorSize.tab,
            tabs: [
              Tab(
                icon: Icon(Icons.home),
                text: "Home",
              ),
              Tab(
                icon: Icon(Icons.edit),
                text: "Iklanku",
              ),
              Tab(
                icon: Icon(Icons.people_alt_outlined),
                text: "Pekerjaku",
              ),
              Tab(
                icon: Icon(Icons.person),
                text: "Profile",
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class JobCard extends StatelessWidget {
  final String title;
  final String company;
  final int rating;
  final String location;
  final String idLowongan;

  JobCard({
    required this.title,
    required this.company,
    required this.rating,
    required this.location,
    required this.idLowongan,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Container(
        width: 220,
        child: Card(
          color: Color.fromRGBO(5, 26, 73, 1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  company,
                  style: TextStyle(color: Colors.white),
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Icons.person, color: Colors.white, size: 14),
                    SizedBox(width: 4),
                    Text(
                      '0 / $rating',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
                SizedBox(height: 4),
                Row(
                  children: [
                    Icon(Icons.location_on, color: Colors.white, size: 14),
                    SizedBox(width: 4),
                    Text(
                      location,
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                        ),
                        child: Text(
                          'Seleksi',
                          style: TextStyle(color: Colors.black, fontSize: 12),
                        ),
                      ),
                    ),
                    SizedBox(width: 8),
                    Flexible(
                      child: ElevatedButton(
                        onPressed: () =>
                            Get.toNamed('/kelolaPegawai/$idLowongan'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                        ),
                        child: Text(
                          'Kelola',
                          style: TextStyle(color: Colors.black, fontSize: 12),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
