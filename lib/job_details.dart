import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class JobDetailsPage extends StatelessWidget {
  const JobDetailsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Job Details"),
        backgroundColor: Colors.blue.shade900,
        centerTitle: true,
        foregroundColor: Colors.white,  // Set the AppBar text and back button color to white
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Company Logo
            Center(
              child: Image.asset(
                "assets/logo.png",
                height: 60,
              )
                  .animate()
                  .fadeIn(duration: 800.ms)
                  .moveY(begin: 50, end: 0, duration: 800.ms),
            ),

            const SizedBox(height: 20),

            // Job Details Card
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
                    _buildDetailRow("Rank", "Chief Officer"),
                    _buildDetailRow("Salary", "\$5,000 per month"),
                    _buildDetailRow("Vessel Type", "Oil Tanker"),
                    _buildDetailRow("Date of Joining", "March 15, 2025"),
                    _buildDetailRow("Contract Duration", "6 Months"),

                    // Special Requirements as a description
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Row(
                        children: [
                          Text(
                            "Special Requirements:",
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
                        "• Valid STCW Certification\n"
                            "• 5+ years experience in similar roles\n"
                            "• Ability to work in harsh conditions",
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

            // Apply Now Button
            Padding(
              padding: const EdgeInsets.only(top: 25),
              child: ElevatedButton(
                onPressed: () {
                  // Add your action for the apply button here
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Application Submitted!")),
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
                  "Apply Now",
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
