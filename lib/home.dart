import 'package:flutter/material.dart';
import 'profile.dart';
import 'jobs.dart';
import 'courses.dart';// Import the JobListPage

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    Center(child: Text('Home Page Content')),
    Center(child: Text('Search Page Content')),
    Center(child: Text('Settings Page Content')),
    Center(child: Text('Exclusive Offers Page Content')),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(24.0, 40.0, 24.0, 24.0), // Added top padding
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildProfileHeader(), // Profile header
            SizedBox(height: 32),
            _buildTile(
              icon: Icons.work,
              title: 'Job Finder',
              onTap: () {
                // Navigate to the JobListPage
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => JobListPage()), // Navigate to JobListPage
                );
              },
            ),
            SizedBox(height: 24),
            _buildTile(
              icon: Icons.school,
              title: 'Marie Training Coordinator',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CourseListPage()), // Navigate to JobListPage
                );
              },
            ),
            SizedBox(height: 24),
            _buildTile(
              icon: Icons.local_offer,
              title: 'Exclusive Offers',
              onTap: () {
                // Handle navigation to Exclusive Offers
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: Colors.white, // Set selected icon and text color to white
        unselectedItemColor: Colors.white, // Set unselected icon and text color to white
        backgroundColor: Colors.blue.shade900, // Set the background color of the bottom navigation bar to blue.shade900
        type: BottomNavigationBarType.fixed, // Ensure fixed type for consistent background color
        onTap: (index) {

          setState(() {
            _currentIndex = index;
          });
          if (index == 1) { // Profile tab index
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ProfilePage()),
            );
          }
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],

      ),
    );
  }

  Widget _buildProfileHeader() {
    return Padding(
      padding: const EdgeInsets.all(12.0), // Added padding to the profile header
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome to Seaminds',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey.shade600,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Mr AAA',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue.shade900,
                  ),
                ),
                SizedBox(height: 4),
                Row(
                  children: [
                    Icon(Icons.anchor, size: 16, color: Colors.blue.shade900),
                    SizedBox(width: 4),
                    Text(
                      'Captain',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.blue.shade900,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          CircleAvatar(
            radius: 30,
            backgroundImage: AssetImage('assets/profile.jpg'), // Replace with your asset path
          ),
        ],
      ),
    );
  }

  Widget _buildTile({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        padding: const EdgeInsets.all(16.0),
        height: 120, // Increased height by 50%
        child: Row(
          children: [
            Icon(icon, size: 36, color: Colors.blue.shade900),
            SizedBox(width: 16),
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.blue.shade900,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
