import 'package:flutter/material.dart';

class HomePerusahaan extends StatefulWidget {
  const HomePerusahaan({Key? key}) : super(key: key);

  @override
  _HomePerusahaan createState() => _HomePerusahaan();
}

class _HomePerusahaan extends State<HomePerusahaan> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 4,
        child: Scaffold(
          body: TabBarView(
            children: [
              // Content of Tab 1
              Center(child: Text('asd')),

              // Content of Tab 2
              Center(child: Text('Tab 2 Content')),

              // Content of Tab 3
              Center(child: Text('Tab 3 Content')),

              // Content of Tab 4
              Center(child: Text('Tab 4 Content')),
            ],
          ),
          bottomNavigationBar: TabBar(
            indicatorColor: Colors.grey, // Optional: Change the indicator color
            tabs: [
              Tab(icon: Icon(Icons.home)), // Icon for Tab 1
              Tab(icon: Icon(Icons.search)), // Icon for Tab 2
              Tab(icon: Icon(Icons.bookmark)), // Icon for Tab 3
              Tab(icon: Icon(Icons.person)), // Icon for Tab 4
            ],
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(const HomePerusahaan());
}
