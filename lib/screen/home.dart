import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:kerjain/Widget/kartu.dart';
import 'package:kerjain/models/lowongan.dart';
import 'package:kerjain/models/user.dart';
import 'package:kerjain/screen/Testing.dart';
import 'package:kerjain/services/lowongan_service.dart';
import 'package:kerjain/services/user_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:kerjain/Widget/kartuHome.dart';
import 'package:kerjain/Widget/kartuLamaran.dart';
import 'package:kerjain/Widget/kartuProfile.dart';
import 'package:kerjain/screen/splash.dart';
import 'package:kerjain/screen/splash.dart';

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
  final UserService _userService = UserService();
  User user = User();

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
                            height: 24,
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
                                          user.nama ?? "",
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
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
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
                              Container(
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.white),
                                    shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                    ),
                                  ),
                                  onPressed: () {
                                    // Navigasi ke halaman yang sesuai
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(vertical: 10),
                                    child: Text(
                                      "Lihat Semua",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w700,
                                        fontFamily: 'Poppins',
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: 12, vertical: 8),
                            child: GridView.builder(
                              shrinkWrap: true,

                              physics:
                                  NeverScrollableScrollPhysics(), // Disable GridView's own scrolling
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2, // Number of columns
                                crossAxisSpacing:
                                    12, // Horizontal spacing between columns
                                mainAxisSpacing:
                                    12, // Vertical spacing between rows
                              ),
                              itemCount: lowonganList.length,
                              itemBuilder: (context, index) {
                                final lowong = lowonganList[index];
                                return Card(
                                  child: KartuHome(
                                      pekerjaan: lowong.namaPosisi,
                                      lokasi: lowong.lokasi,
                                      gajiDari: lowong.gajiDari.toString(),
                                      gajiHingga: lowong.gajiHingga.toString(),
                                      slot: lowong.slotPosisi.toString(),
                                      onPressed: () {}),
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
            SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 64, bottom: 10),
                    child: Container(
                      child: Text(
                        'Search',
                        style: TextStyle(
                          fontSize: 28,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    color: Color.fromRGBO(217, 217, 217, 1),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 25),
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
                        Padding(
                          padding: const EdgeInsets.only(top: 2, left: 30),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 170),
                          child: Text(
                            'Hasil Pencarian',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontFamily: 'Poppins',
                              fontSize: 20,
                            ),
                          ),
                        ),
                        Container(
                          margin:
                              EdgeInsets.symmetric(horizontal: 5, vertical: 1),
                          width: MediaQuery.of(context).size.width *
                              0.9, // Set the width to 80% of the screen width
                          child: GridView(
                            shrinkWrap: true,
                            physics:
                                NeverScrollableScrollPhysics(), // Disable GridView's own scrolling
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 1, // Number of columns
                              crossAxisSpacing:
                                  12, // Horizontal spacing between columns
                              mainAxisSpacing:
                                  12, // Vertical spacing between rows
                              childAspectRatio: 2,
                            ),
                            children: [
                              Kartu(pekerjaan: 'BackEnd', onPressed: () {}),
                              Kartu(pekerjaan: 'FrontEnd', onPressed: () {}),
                              Kartu(pekerjaan: 'BackEnd', onPressed: () {}),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // Content of Tab 3
            Testing(),
            // Content of Tab 4
            SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 250, top: 80),
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => kerjaSplash()),
                        );
                      },
                      icon: Icon(Icons.logout_outlined),
                      label: Text('Logout'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromRGBO(
                            5, 26, 73, 1), // Button background color
                        foregroundColor: Colors.white, // Icon and text color
                        padding: EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10), // Button padding
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(12), // Rounded corners
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 100),
                    child: Row(
                      children: [
                        Text(
                          'Willy Ngoceh',
                          style: TextStyle(
                            fontSize: 28,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Icon(Icons.edit_outlined),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 60,
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 220),
                    child: Text(
                      'Deskripsi',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      Container(
                        width: 300,
                        child: TextField(
                          maxLines: 5,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.blue, width: 0.7),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Container(
                        width: 300,
                        height: 50,
                        child: TextField(
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.email_outlined),
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Container(
                        width: 300,
                        height: 50,
                        child: TextField(
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.cake_outlined),
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        child: Text(
                          'Riwayat pekerjaan',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 20, right: 20),
                        child: GridView(
                          shrinkWrap: true,
                          physics:
                              NeverScrollableScrollPhysics(), // Disable GridView's own scrolling
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 8,
                            mainAxisSpacing: 8,
                            childAspectRatio: 1.5,
                          ),
                          children: [
                            KartuProfile(
                                pekerjaan: 'BackEnd', onPressed: () {}),
                            KartuProfile(
                                pekerjaan: 'FrontEnd', onPressed: () {}),
                            KartuProfile(
                                pekerjaan: 'BackEnd', onPressed: () {}),
                            KartuProfile(
                                pekerjaan: 'FrontEnd', onPressed: () {}),
                            // Add more Kartu widgets as needed
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                    ],
                  ),
                ],
              ),
            ),
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
