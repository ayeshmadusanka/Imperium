import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class CourseDetailsPage extends StatelessWidget {
  const CourseDetailsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Course Details"),
        backgroundColor: Colors.blue.shade900,
        centerTitle: true,
        foregroundColor: Colors.white,  // Set the AppBar text and back button color to white
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Institute Logo (if available)
            Center(
              child: Image.asset(
                "assets/logo.png",  // You can replace this with the logo of the institute
                height: 60,
              )
                  .animate()
                  .fadeIn(duration: 800.ms)
                  .moveY(begin: 50, end: 0, duration: 800.ms),
            ),

            const SizedBox(height: 20),

            // Course Details Card
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildDetailRow("Institute", "XYZ University"),
                    _buildDetailRow("Course Name", "Flutter Development"),
                    _buildDetailRow("Course Duration", "3 Months"),
                    _buildDetailRow("Course Start Date", "April 10, 2025"),
                    _buildDetailRow("Course Fee", "\$1,200"),

                    // Minimum Requirements as a description
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Row(
                        children: [
                          Text(
                            "Minimum Requirements:",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue.shade900,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Text(
                        "• Basic knowledge of programming\n"
                            "• Experience with Dart or JavaScript\n"
                            "• Interest in mobile app development",
                        style: const TextStyle(fontSize: 16, color: Colors.black87),
                      ),
                    ),
                  ],
                )
                    .animate()
                    .fadeIn(duration: 800.ms)
                    .moveY(begin: 50, end: 0, duration: 800.ms),
              ),
            ),

            // Enroll Now Button
            Padding(
              padding: const EdgeInsets.only(top: 25),
              child: ElevatedButton(
                onPressed: () {
                  // Add your action for the enroll button here
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Enrollment Submitted!")),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue.shade900, // Button color
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 100),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text(
                  "Enroll Now",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget to build a detail row
  Widget _buildDetailRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Text(
            "$title:",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.blue.shade900),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontSize: 16, color: Colors.black87),
            ),
          ),
        ],
      ),
    );
  }
}
