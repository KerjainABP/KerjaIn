import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kerjain/Widget/kartu.dart';
import 'package:kerjain/models/lowongan.dart';
import 'package:kerjain/models/user.dart';
import 'package:kerjain/screen/User/Lamaranku.dart';
import 'package:kerjain/screen/User/ProfileUser.dart';
import 'package:kerjain/screen/User/Search.dart';
import 'package:kerjain/services/lowongan_service.dart';
import 'package:kerjain/services/user_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:kerjain/Widget/kartuHome.dart';
import 'package:kerjain/Widget/kartuLamaran.dart';
import 'package:kerjain/Widget/kartuProfile.dart';
import 'package:kerjain/screen/splash.dart';
import 'package:kerjain/screen/splash.dart';
import 'package:intl/intl.dart';

class HomePekerja extends StatefulWidget {
  const HomePekerja({Key? key}) : super(key: key);

  @override
  _HomePekerjaState createState() => _HomePekerjaState();
}

class _HomePekerjaState extends State<HomePekerja> {
  late String idUser;
  late Future<List<Lowongan>> futureLowongan = LowonganService.fetchLowongan();
  List<Lowongan> _lowonganList = [];

  // Buat instance dari UserService
  User user = User();
  String formatRupiah(int number) {
    final formatCurrency = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp ',
      decimalDigits: 2,
    );
    return formatCurrency.format(number);
  }

  @override
  void initState() {
    super.initState();
    getIdUser().then((value) {
      setState(() {
        idUser = value!;
        // Panggil API setelah mendapatkan idUser
        User.connectAPI(idUser).then((value) {
          setState(() {
            user = value;
          });
        });
        futureLowongan.then((value) {
          setState(() {
            _lowonganList.addAll(value);
          });
        });
      });
    });
  }

  Future<String?> getIdUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('idUser');
  }

  Future<void> _fetchLowongan() async {
    try {
      List<Lowongan> lowongan = await LowonganService.fetchLowongan();
      setState(() {
        _lowonganList = lowongan;
      });
    } catch (e) {
      print('Error fetching lowongan: $e');
      // Handle error fetching lowongan
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4, // Specify the number of tabs
      child: Scaffold(
        body: TabBarView(
          children: [
            // Content of Tab 1
            FutureBuilder<List<Lowongan>>(
                future: futureLowongan,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(child: Text('No data available'));
                  } else {
                    List<Lowongan> lowonganList = snapshot.data!;
                    return SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 60,
                          ),
                          // Existing content of Tab 1
                          Container(
                            margin: const EdgeInsets.only(left: 30),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Hai, ${user.nama}" ?? "",
                                          style: const TextStyle(
                                            fontSize: 24,
                                            fontWeight: FontWeight.w700,
                                            fontFamily: 'Poppins',
                                          ),
                                          softWrap: true,
                                          overflow: TextOverflow.visible,
                                        ),
                                        const Text(
                                          'Pekerja', // Add your subtitle text here
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.grey,
                                            fontFamily: 'Poppins',
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Container(
                                  margin: const EdgeInsets.only(left: 5),
                                  child: const Row(
                                    children: [
                                      SizedBox(
                                        height: 100,
                                      ),
                                      Text(
                                        'Jelajahi Berbagai\nPeluang Kerja',
                                        style: TextStyle(
                                          fontSize: 24,
                                          fontFamily: 'Poppins',
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 35, vertical: 15),
                            child: TextField(
                              decoration: InputDecoration(
                                suffixIcon: Container(
                                  padding:
                                      EdgeInsets.all(20), // Set padding to zero
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Color.fromRGBO(5, 26, 73,
                                        1), // Change the background color here
                                  ),
                                  child: Icon(Icons.search,
                                      color: Colors
                                          .white), // Set the icon color to white
                                ),
                                hintText: 'Search...',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Row(
                            children: [
                              Container(
                                margin: EdgeInsets.only(left: 16),
                                child: const Text(
                                  'Lowongan Baru',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 40,
                              ),
                              // Container(
                              //   child: ElevatedButton(
                              //     style: ButtonStyle(
                              //       backgroundColor:
                              //           MaterialStateProperty.all<Color>(
                              //               Colors.white),
                              //       shape: MaterialStateProperty.all<
                              //           RoundedRectangleBorder>(
                              //         RoundedRectangleBorder(
                              //           borderRadius:
                              //               BorderRadius.circular(10.0),
                              //         ),
                              //       ),
                              //     ),
                              //     onPressed: () {
                              //       // Navigasi ke halaman yang sesuai
                              //     },
                              //     child: Container(
                              //       padding: EdgeInsets.symmetric(vertical: 10),
                              //       child: Text(
                              //         "Lihat Semua",
                              //         style: TextStyle(
                              //           color: Colors.black,
                              //           fontSize: 15,
                              //           fontWeight: FontWeight.w700,
                              //           fontFamily: 'Poppins',
                              //         ),
                              //       ),
                              //     ),
                              //   ),
                              // ),
                            ],
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: 8, vertical: 8),
                            child: GridView.builder(
                              shrinkWrap: true,

                              physics:
                                  NeverScrollableScrollPhysics(), // Disable GridView's own scrolling
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2, // Number of columns
                                crossAxisSpacing:
                                    8, // Horizontal spacing between columns
                                mainAxisSpacing:
                                    8, // Vertical spacing between rows
                              ),
                              itemCount: lowonganList.length,
                              itemBuilder: (context, index) {
                                final lowong = lowonganList[index];
                                return Card(
                                  child: KartuHome(
                                      pekerjaan: lowong.namaPosisi,
                                      lokasi: lowong.lokasi,
                                      gajiDari: formatRupiah(lowong.gajiDari),
                                      gajiHingga:
                                          formatRupiah(lowong.gajiHingga),
                                      slot: lowong.slotPosisi.toString(),
                                      perusahaan: lowong.idPerusahaan,
                                      idLowongan: lowong.id,
                                      onPressed: () => Get.toNamed(
                                          '/detailPage/${lowong.id}')),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                }),
            // Content of Tab 2
            SearchPage(),
            // Content of Tab 3
            LamarankuPage(),
            // Content of Tab 4
            ProfileUserPage()
          ],
        ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(7.0)),
            border: Border(
              top: BorderSide(
                  color: Color.fromRGBO(5, 26, 73, 1),
                  width: 2.0), // Add outline to the top border
            ),
          ),
          child: TabBar(
            indicator: BoxDecoration(
                border: Border.all(
                  color: Color.fromRGBO(5, 26, 73, 1),
                  width: 1.0,
                ),
                color: Color.fromRGBO(
                    5, 26, 73, 1), // This will remove the indicator line
                borderRadius: BorderRadius.all(Radius.circular(8))),
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
              ), // Icon for Tab 1
              Tab(icon: Icon(Icons.search), text: "Search"), // Icon for Tab 2
              Tab(
                  icon: Icon(Icons.bookmark),
                  text: "Lamaran"), // Icon for Tab 3
              Tab(
                icon: Icon(Icons.person),
                text: "Profile",
              ), // Icon for Tab 4
            ],
          ),
        ),
      ),
    );
  }
}

void main() => runApp(MaterialApp(
      home: HomePekerja(),
      debugShowCheckedModeBanner: false,
    ));
