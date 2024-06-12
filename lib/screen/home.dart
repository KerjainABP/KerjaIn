import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kerjain/Widget/kartu.dart';
import 'package:kerjain/screen/DetailJob/DetailJobUser.dart';

class HomePekerja extends StatefulWidget {
  const HomePekerja({Key? key}) : super(key: key);

  @override
  _HomePekerjaState createState() => _HomePekerjaState();
}

class _HomePekerjaState extends State<HomePekerja> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4, // Specify the number of tabs
      child: Scaffold(
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
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>  JobDetailScreen()),
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
                children: [
                  GridView(
                    shrinkWrap: true,
                    physics:
                        NeverScrollableScrollPhysics(), // Disable GridView's own scrolling
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                    ),
                    children: [
                      Kartu(pekerjaan: 'BackEnd', onPressed: () {}),
                      Kartu(pekerjaan: 'BackEnd', onPressed: () {}),
                      Kartu(pekerjaan: 'BackEnd', onPressed: () {}),
                      Kartu(pekerjaan: 'BackEnd', onPressed: () {}),
                      Kartu(pekerjaan: 'BackEnd', onPressed: () {}),
                      Kartu(pekerjaan: 'BackEnd', onPressed: () {}),
                    ],
                  ),
                ],
              ),
            ),
            // Content of Tab 3
            Center(child: Text('Bookmark Content')),
            // Content of Tab 4
            Center(child: Text('Profile Content')),
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
