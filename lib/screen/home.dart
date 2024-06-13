import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:kerjain/Widget/kartu.dart';
<<<<<<< HEAD
import 'package:kerjain/models/user.dart';
import 'package:kerjain/services/user_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
=======

import 'package:kerjain/Widget/kartuHome.dart';

>>>>>>> 4c06ca892cd9956313b807330570338c98fcface

class HomePekerja extends StatefulWidget {
  const HomePekerja({Key? key}) : super(key: key);

  @override
  _HomePekerjaState createState() => _HomePekerjaState();
}

class _HomePekerjaState extends State<HomePekerja> {
  late String idUser;

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
      });
    });
  }

  Future<String?> getIdUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('idUser');
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4, // Specify the number of tabs
      child: Scaffold(
<<<<<<< HEAD
        body: TabBarView(
          children: [
            // Content of Tab 1
            SingleChildScrollView(
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
                              crossAxisAlignment: CrossAxisAlignment.start,
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
=======
        body: Builder(
          builder: (BuildContext context) {
            final TabController tabController = DefaultTabController.of(context);
            return TabBarView(
              children: [
                // Content of Tab 1
                SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 24,
                      ),
                      // Existing content of Tab 1
                      Container(
                        margin: const EdgeInsets.only(left: 20),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 20,
                            ),
                            const Row(
                              children: [
                                CircleAvatar(
                                  radius: 40,
                                  backgroundImage: AssetImage('assets/kerjain.png'),
                                ),
                                SizedBox(width: 30),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Hello Willy',
                                      style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.w700,
                                        fontFamily: 'Poppins',
                                      ),
                                      softWrap: true,
                                      overflow: TextOverflow.visible,
                                    ),
                                    Text(
                                      'Pekerja', // Add your subtitle text here
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.grey,
                                        fontFamily: 'Poppins',
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  'VIP10',
                                ),
                              ],
                            ),
                            Container(
                              margin: const EdgeInsets.only(left: 10),
                              child: const Row(
                                children: [
                                  SizedBox(
                                    height: 100,
                                  ),
                                  Text(
                                    'Jelajahi Berbagai\nPeluang Kerja',
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontFamily: 'Popins',
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 15),
                        child: TextField(
                          decoration: InputDecoration(
                            suffixIcon: InkWell(
                              onTap: () {
                                tabController.animateTo(1);
                              },
                              child: Container(
                                padding: EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Color.fromRGBO(5, 26, 73, 1), // Change the background color here
                                ),
                                child: Icon(
                                  Icons.search,
                                  color: Colors.white, // Set the icon color to white
>>>>>>> 4c06ca892cd9956313b807330570338c98fcface
                                ),
                              ),
                            ),
                            hintText: 'Search...',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Container(
                              child: const Text(
                                'Lowongan Baru',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: Container(
                              child: ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const HomePekerja()),
                                  );
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
                          ),
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 15, right: 15),
                        child: GridView(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(), // Disable GridView's own scrolling
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 8,
                            mainAxisSpacing: 8,
                          ),
                          children: [
                            KartuHome(pekerjaan: 'BackEnd', onPressed: () {}),
                            KartuHome(pekerjaan: 'FrontEnd', onPressed: () {}),
                            KartuHome(pekerjaan: 'BackEnd', onPressed: () {}),
                            KartuHome(pekerjaan: 'FrontEnd', onPressed: () {}),
                            // Add more Kartu widgets as needed
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                // Content of Tab 2
                SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 64, bottom: 10),
                        child: Container(
                          child: Text('Search',style: TextStyle(
                            fontSize: 28,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w700,
                          ),),
                        ),
                      ),
                      Container(
                        color: Color.fromRGBO(217,217,217,1),
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
                                    padding: EdgeInsets.all(20), // Set padding to zero
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Color.fromRGBO(5, 26, 73, 1), // Change the background color here
                                    ),
                                    child: Icon(Icons.search,
                                        color: Colors.white), // Set the icon color to white
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
                              margin: EdgeInsets.symmetric(horizontal: 5, vertical: 1),
                              width: MediaQuery.of(context).size.width * 0.9, // Set the width to 80% of the screen width
                              child: GridView(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(), // Disable GridView's own scrolling
                                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 1, // Number of columns
                                  crossAxisSpacing: 12, // Horizontal spacing between columns
                                  mainAxisSpacing: 12, // Vertical spacing between rows
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
                Container(
                  color: Colors.black,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 60,
                        ),
                        Text(
                          'Lamaranku',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Container(
                          color: Colors.blueGrey, // Set your desired background color here
                          width: double.infinity, // Ensure the container takes the full width
                          padding: EdgeInsets.all(16), // Add padding if necessary
                          child: Column(
                            children: [
                              // Add your content under 'Lamaranku' text here
                              // Example content
                              Text(
                                'Your additional content goes here...',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                              // Add more widgets as needed
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
<<<<<<< HEAD
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 35, vertical: 15),
                    child: TextField(
                      decoration: InputDecoration(
                        suffixIcon: Container(
                          padding: EdgeInsets.all(20), // Set padding to zero
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Color.fromRGBO(5, 26, 73,
                                1), // Change the background color here
                          ),
                          child: Icon(Icons.search,
                              color:
                                  Colors.white), // Set the icon color to white
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
                                MaterialStateProperty.all<Color>(Colors.white),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
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
                    margin: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    child: GridView(
                      shrinkWrap: true,
                      physics:
                          NeverScrollableScrollPhysics(), // Disable GridView's own scrolling
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, // Number of columns
                        crossAxisSpacing:
                            12, // Horizontal spacing between columns
                        mainAxisSpacing: 12, // Vertical spacing between rows
                      ),
                      children: [
                        Kartu(pekerjaan: 'BackEnd', onPressed: () {}),
                        Kartu(pekerjaan: 'FrontEnd', onPressed: () {}),
                        Kartu(pekerjaan: 'BackEnd', onPressed: () {}),
                        Kartu(pekerjaan: 'FrontEnd', onPressed: () {}),
                        Kartu(pekerjaan: 'BackEnd', onPressed: () {}),
                        Kartu(pekerjaan: 'FrontEnd', onPressed: () {}),
                        // Add more Kartu widgets as needed
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // Content of Tab 2
            SingleChildScrollView(
              child: Column(
                children: [],
              ),
            ),
            // Content of Tab 3
            Center(child: Text('Bookmark Content')),
            // Content of Tab 4
            Center(child: Text('Profile Content')),
          ],
=======
                ),
                // Content of Tab 4
                Center(child: Text('Profile Content')),
              ],
            );
          },
>>>>>>> 4c06ca892cd9956313b807330570338c98fcface
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
              Tab(icon: Icon(Icons.bookmark), text: "Lamaran"), // Icon for Tab 3
              Tab(icon: Icon(Icons.person), text: "Profile"), // Icon for Tab 4
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
