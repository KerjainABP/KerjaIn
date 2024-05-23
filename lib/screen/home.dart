import 'package:flutter/cupertino.dart';import 'package:flutter/material.dart';import 'package:flutter/widgets.dart';import 'package:kerjain/Widget/kartu.dart';class HomePekerja extends StatefulWidget {  const HomePekerja({Key? key}) : super(key: key);  @override  _HomePekerjaState createState() => _HomePekerjaState();}class _HomePekerjaState extends State<HomePekerja> {  @override  Widget build(BuildContext context) {    return DefaultTabController(      length: 4, // Specify the number of tabs      child: Scaffold(        appBar: AppBar(),        body: TabBarView(          children: [            // Content of Tab 1            SingleChildScrollView(              child: Column(                crossAxisAlignment: CrossAxisAlignment.start,                children: [                  // Existing content of Tab 1                  Container(                    margin: EdgeInsets.only(left: 30),                    child: Column(                      children: [                        Row(                          children: [                            CircleAvatar(                              radius: 40,                              backgroundImage: AssetImage('assets/kerjain.png'),                            ),                            SizedBox(width: 30),                            Column(                              crossAxisAlignment: CrossAxisAlignment.start,                              children: [                                const Text(                                  'Hellow kontol',                                  style: TextStyle(                                    fontSize: 24,                                    fontWeight: FontWeight.w700,                                    fontFamily: 'Poppins',                                  ),                                ),                                Text(                                  'Pekerja', // Add your subtitle text here                                  style: TextStyle(                                    fontSize: 16,                                    color: Colors.grey,                                    fontFamily: 'Poppins',                                  ),                                ),                              ],                            ),                            const Text(                              'VIP10',                            ),                          ],                        ),                        Container(                          margin: EdgeInsets.only(left: 5),                          child: Row(                            children: [                              const SizedBox(                                height: 100,                              ),                              const Text(                                'Jelajahi Berbagai\nPeluang Kerja',                                style: TextStyle(                                  fontSize: 24,                                  fontFamily: 'Popins',                                ),                              ),                            ],                          ),                        ),                      ],                    ),                  ),                  Padding(                    padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 15),                    child: TextField(                      decoration: InputDecoration(                        suffixIcon: Container(                          padding: EdgeInsets.all(20), // Set padding to zero                          decoration: BoxDecoration(                            borderRadius: BorderRadius.circular(20),                            color: Color.fromRGBO(5, 26, 73, 1), // Change the background color here                          ),                          child: Icon(Icons.search, color: Colors.white), // Set the icon color to white                        ),                        hintText: 'Search...',                        border: OutlineInputBorder(                          borderRadius: BorderRadius.circular(20),                        ),                      ),                    ),                  ),                  const SizedBox(                    height: 30,                  ),                  Row(                    children: [                      Container(                        margin: EdgeInsets.only(left: 35),                        child: const Text(                          'Lowongan Baru',                          style: TextStyle(                            fontSize: 18,                            fontFamily: 'Poppins',                            fontWeight: FontWeight.w600,                          ),                        ),                      ),                      const SizedBox(                        width: 40,                      ),                      Container(                        child: ElevatedButton(                          style: ButtonStyle(                            backgroundColor: MaterialStateProperty.all<Color>(                                Colors.white),                            shape:                            MaterialStateProperty.all<RoundedRectangleBorder>(                              RoundedRectangleBorder(                                borderRadius: BorderRadius.circular(10.0),                              ),                            ),                          ),                          onPressed: () {                            Navigator.push(                              context,                              MaterialPageRoute(                                  builder: (context) => const HomePekerja()),                            );                          },                          child: Container(                            padding: EdgeInsets.symmetric(vertical: 10),                            child: Text(                              "Lihat Semua",                              style: TextStyle(                                color: Colors.black,                                fontSize: 15, fontWeight: FontWeight.w700,                                fontFamily: 'Poppins',                              ),                            ),                          ),                        ),                      ),                    ],                  ),                  Container(                    padding: EdgeInsets.symmetric(horizontal: 16,vertical: 0),                    child: Row(                      children: [                        kartu(pekerjaan: 'BackEnd', onPressed: (){}),                        const SizedBox(                          width: 12,                        ),                        kartu(pekerjaan: 'kontol', onPressed: (){}),                      ],                    ),                  ),                  Container(                    padding: EdgeInsets.symmetric(horizontal: 16,vertical: 30),                    child: Row(                      children: [                        kartu(pekerjaan: 'BackEnd', onPressed: (){}),                        const SizedBox(                          width: 12,                        ),                        kartu(pekerjaan: 'kontol', onPressed: (){}),                      ],                    ),                  ),                ],              ),            ),            // Content of Tab 2            GridView(                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(                    crossAxisCount: 2,                  ),                  children: [                    kartu(pekerjaan: 'BackEnd', onPressed: (){}),                    kartu(pekerjaan: 'BackEnd', onPressed: (){}),                    kartu(pekerjaan: 'BackEnd', onPressed: (){}),                    kartu(pekerjaan: 'BackEnd', onPressed: (){}),                    kartu(pekerjaan: 'BackEnd', onPressed: (){}),                    kartu(pekerjaan: 'BackEnd', onPressed: (){}),                  ],            ),            // Content of Tab 3            Center(child: Text('Bookmark Content')),            // Content of Tab 4            Center(child: Text('Profile Content')),          ],        ),        bottomNavigationBar: Container(          decoration: BoxDecoration(            color: Colors.white,            borderRadius: BorderRadius.vertical(top: Radius.circular(7.0)),            border: Border(              top: BorderSide(color: Color.fromRGBO(5, 26, 73, 1), width: 2.0), // Add outline to the top border            ),          ),          child: TabBar(            indicatorColor: Color.fromRGBO(5, 26, 73, 1),            labelColor: Color.fromRGBO(5, 26, 73, 1),            unselectedLabelColor: Colors.grey,            tabs: [              Tab(icon: Icon(Icons.home)), // Icon for Tab 1              Tab(icon: Icon(Icons.search)), // Icon for Tab 2              Tab(icon: Icon(Icons.bookmark)), // Icon for Tab 3              Tab(icon: Icon(Icons.person)), // Icon for Tab 4            ],          ),        ),      ),    );  }}void main() => runApp(MaterialApp(  home: HomePekerja(),  debugShowCheckedModeBanner: false,));