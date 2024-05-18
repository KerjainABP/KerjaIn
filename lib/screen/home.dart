import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 4, // Specify the number of tabs
        child: Scaffold(
          appBar: AppBar(
            title: Text('Flutter Tab Bar Example'),
            bottom: TabBar(
              indicatorColor: Colors.grey, // Optional: Change the indicator color
              tabs: [
                Tab(icon: Icon(Icons.home)), // Icon for Tab 1
                Tab(icon: Icon(Icons.search)), // Icon for Tab 2
                Tab(icon: Icon(Icons.bookmark)), // Icon for Tab 3
                Tab(icon: Icon(Icons.person)), // Icon for Tab 4
              ],
            ),
          ),
          body: TabBarView(
            children: [
              // Content of Tab 1
              Center(child: Text('Tab 1 Content')),

              // Content of Tab 2
              Center(child: Text('Tab 2 Content')),

              // Content of Tab 3
              Center(child: Text('Tab 3 Content')),

              // Content of Tab 4
              Center(child: Text('Tab 4 Content')),
            ],
          ),
        ),
      ),
    );
  }
}
