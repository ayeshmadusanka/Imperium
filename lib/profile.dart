import 'package:flutter/material.dart';
// Removed unused 'package:intl/intl.dart' import as it's not directly used in this file
import 'personnel_details.dart'; // Corrected import path for PersonnelInformationPage
import 'family_details.dart'; // Import the FamilyDetailsPage
import 'academic_qualifications.dart'; // Import the AcademicQualificationPage
import 'travel_document.dart'; // Import the TravelDocumentsPage
import 'certifications.dart'; // Import the CertificatesPage
import 'emergency_contact.dart'; // Import the EmergencyContactPage

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Profile Completion',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: 'Inter', // Assuming 'Inter' font is available or default system font
      ),
      home: const ProfilePage(), // Changed from ProfileCompletionPage
    );
  }
}

class ProfilePage extends StatelessWidget { // Changed class name
  const ProfilePage({super.key}); // Changed constructor name

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade900, // Changed background color
        elevation: 0,
        title: const Text(
          'Profile', // Changed title text
          style: TextStyle(
            color: Colors.white, // Changed title color
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
        leading: IconButton( // Added back button
          icon: const Icon(Icons.arrow_back, color: Colors.white), // Set back button color to white
          onPressed: () {
            // Implement navigation back functionality here
            print('Back button pressed');
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            // Profile Photo Section
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 24.0),
              child: Column(
                children: [
                  Stack(
                    children: [
                      const CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.grey,
                        child: Icon(
                          Icons.person,
                          size: 60,
                          color: Colors.white,
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.blueAccent,
                            borderRadius: BorderRadius.circular(100),
                            border: Border.all(
                              color: Colors.white,
                              width: 2,
                            ),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.all(4.0),
                            child: Icon(
                              Icons.camera_alt,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Ayesh Madusanka', // Changed text to Ayesh Madusanka
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 8), // Reduced from 8 to 4
                  // Replaced "Click camera icon to upload" with "Generate CV"
                  Text(
                    'Generate CV',
                    style: TextStyle(
                      fontSize: 18, // Increased font size to 14
                      fontWeight: FontWeight.bold, // Make it bold
                      color: Colors.blue.shade900, // Set color to blue.shade900
                    ),
                  ),
                ],
              ),
            ),
            // Removed the first Divider here

            // List of Profile Sections
            ProfileSectionTile(
              icon: Icons.person_outline,
              title: 'Personnel Details',
              subtitle: 'Basic personal information',
              isCompleted: false,
              onTap: () {
                // Navigate to PersonnelInformationPage
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const PersonnelInformationPage()),
                );
              },
            ),
            // Removed Divider between list items
            ProfileSectionTile(
              icon: Icons.group_outlined,
              title: 'Family Details',
              subtitle: 'Spouse and family information',
              isCompleted: false,
              onTap: () {
                // Navigate to FamilyDetailsPage
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const FamilyDetailsPage()),
                );
              },
            ),
            // Removed Divider between list items
            ProfileSectionTile(
              icon: Icons.phone_outlined,
              title: 'Emergency Contact',
              subtitle: 'Next of kin details',
              isCompleted: false,
              onTap: () {
                // Navigate to EmergencyContactPage
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const EmergencyContactPage()),
                );
              },
            ),
            // Removed Divider between list items
            ProfileSectionTile(
              icon: Icons.school_outlined,
              title: 'Academic Qualification',
              subtitle: 'Pre-sea training details',
              isCompleted: false,
              onTap: () {
                // Navigate to AcademicQualificationPage
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AcademicQualificationPage()),
                );
              },
            ),
            // Removed Divider between list items
            ProfileSectionTile(
              icon: Icons.description_outlined,
              title: 'Travel Documents',
              subtitle: 'Identity and travel documents',
              isCompleted: false,
              onTap: () {
                // Navigate to TravelDocumentsPage
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const TravelDocumentsPage()),
                );
              },
            ),
            // Removed Divider between list items
            ProfileSectionTile(
              icon: Icons.receipt_long_outlined,
              title: 'Certifications',
              subtitle: 'STCW & value added certificates',
              isCompleted: false,
              onTap: () {
                // Navigate to CertificatesPage
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CertificatesPage()),
                );
              },
            ),
            // Removed Divider between list items
            ProfileSectionTile(
              icon: Icons.info_outline,
              title: 'Additional Info',
              subtitle: 'Experience and references',
              isCompleted: false,
            ),
            const SizedBox(height: 20), // Padding at the bottom
          ],
        ),
      ),
    );
  }
}

class ProfileSectionTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final bool isCompleted;
  final VoidCallback? onTap; // Added onTap callback

  const ProfileSectionTile({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.isCompleted,
    this.onTap, // Initialize onTap
  });

  @override
  Widget build(BuildContext context) {
    return Container( // Replaced Card with Container
      margin: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.0),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 0.0), // Reduced vertical padding
        leading: Container(
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Colors.blue.withOpacity(0.1), // Light blue background for icon
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icon,
            color: Colors.blue,
            size: 24,
          ),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 15,
            color: Colors.black87,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.grey,
          ),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Dot indicator for completion status
            Icon(
              Icons.circle,
              size: 8,
              color: isCompleted ? Colors.green : Colors.blue.shade900, // Green if completed, changed grey to blue.shade900
            ),
            const SizedBox(width: 8),
            const Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: Colors.blue, // Changed arrow color to blue
            ),
          ],
        ),
        onTap: onTap, // Used the provided onTap callback
      ),
    );
  }
}
