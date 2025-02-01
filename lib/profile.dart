import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ProfilePage(),
    );
  }
}



class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue.shade900,
        title: Text(
          'Profile',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
            );
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/profile_picture.png'),
            ),
            SizedBox(height: 10),
            Text(
              'Jonathan Patterson',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.blue.shade900,
              ),
            ),
            SizedBox(height: 5),
            Text(
              'Captain',
              style: TextStyle(
                color: Colors.blue.shade900,
                fontSize: 14,
              ),
            ),
            SizedBox(height: 5),
            Text(
              'Generate CV',
              style: TextStyle(
                color: Colors.blue.shade900,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            Divider(thickness: 1, color: Colors.white),
            _buildSectionTitle('General Settings'),
            _buildListTile(
              icon: Icons.key,
              title: 'Change Password',
              trailing: Icon(Icons.arrow_forward_ios, color: Colors.blue.shade900),
            ),
            _buildListTile(
              icon: Icons.logout,
              title: 'Logout',
              trailing: Icon(Icons.arrow_forward_ios, color: Colors.blue.shade900),
            ),
            Divider(thickness: 1, color: Colors.white),
            _buildSectionTitle('General Information'),
            _buildListTile(
              icon: Icons.upload_file,
              title: 'CDC (Upload Medical Report)',
              trailing: Icon(Icons.arrow_forward_ios, color: Colors.blue.shade900),
            ),
            _buildListTile(
              icon: Icons.person,
              title: 'Last Name*',
              trailing: Icon(Icons.edit, color: Colors.blue.shade900),
            ),
            _buildListTile(
              icon: Icons.person,
              title: 'First Name*',
              trailing: Icon(Icons.edit, color: Colors.blue.shade900),
            ),
            _buildListTile(
              icon: Icons.phone,
              title: 'Mobile 1*',
              trailing: Icon(Icons.edit, color: Colors.blue.shade900),
            ),
            _buildListTile(
              icon: Icons.settings_phone_outlined,
              title: 'Mobile 2 (WhatsApp)',
              trailing: Icon(Icons.edit, color: Colors.blue.shade900),
            ),
            _buildListTile(
              icon: Icons.phone_in_talk,
              title: 'Mobile 3 / Land Line',
              trailing: Icon(Icons.edit, color: Colors.blue.shade900),
            ),
            _buildListTile(
              icon: Icons.upload_file,
              title: 'Certificate (Upload)',
              trailing: Icon(Icons.arrow_forward_ios, color: Colors.blue.shade900),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Container(
      width: double.infinity,
      color: Colors.blue.shade900,
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      child: Text(
        title,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildListTile({
    required IconData icon,
    required String title,
    String? subtitle,
    Widget? trailing,
  }) {
    return ListTile(
      leading: Icon(icon, color: Colors.blue.shade900),
      title: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.blue.shade900,
        ),
      ),
      subtitle: subtitle != null
          ? Text(
        subtitle,
        style: TextStyle(color: Colors.blue.shade900),
      )
          : null,
      trailing: trailing,
    );
  }
}
