import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'register.dart';
import 'home.dart';
import 'login_without_top.dart';

class RegisterVerificationPage extends StatefulWidget {
  const RegisterVerificationPage({Key? key}) : super(key: key);

  @override
  State<RegisterVerificationPage> createState() => _RegisterVerificationPageState();
}

class _RegisterVerificationPageState extends State<RegisterVerificationPage> {
  // Controllers for text fields
  final TextEditingController otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Get screen width to adjust padding dynamically
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white, // Set background color to white
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Top Section with padding
            Padding(
              padding: const EdgeInsets.only(top: 40.0), // Adjust top padding as needed
              child: Stack(
                children: [
                  Container(
                    height: 200,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.white, Colors.white],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                  ),
                  Positioned.fill(
                    child: Align(
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Add logo.png directly
                          Image.asset(
                            'assets/logo.png', // Use logo image
                            width: 240, // Set width for the logo
                            height: 50, // Set height for the logo
                          ).animate().fadeIn(duration: 800.ms).move(begin: Offset(0, -50), end: Offset(0, 0), duration: 800.ms),
                          const SizedBox(height: 00),

                          // Text for OTP (One Time Password)

                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Register Verification Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 00),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Title text with fade-in-up animation
                  Text(
                    "Verify",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 56,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue.shade900,
                    ),
                  ).animate().fadeIn(duration: 800.ms).move(begin: Offset(0, 50), end: Offset(0, 0), duration: 800.ms),
                  const SizedBox(height: 0),
                  const Text(
                    "Enter the OTP sent to your phone",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.blueGrey,
                    ),
                  ).animate().fadeIn(duration: 800.ms).move(begin: Offset(0, 50), end: Offset(0, 0), duration: 800.ms),
                  const SizedBox(height: 20),

                  // OTP Field with fade-in-up animation
                  Container(
                    height: 56, // Set a fixed height for the OTP text field
                    child: TextField(
                      controller: otpController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: "One Time Password",
                        filled: true,
                        fillColor: Colors.blue.shade100,
                        prefixIcon: Icon(Icons.security, color: Colors.blue.shade900),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ).animate().fadeIn(duration: 800.ms).move(begin: Offset(0, 50), end: Offset(0, 0), duration: 800.ms),
                  ),
                  const SizedBox(height: 20),

                  // Verify Button with fade-in-up animation
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue.shade900,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    onPressed: () {
                      // Navigate to the HomePage upon successful OTP verification
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginNoTop()),
                      );
                    },
                    child: const Text(
                      "Verify",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ).animate().fadeIn(duration: 800.ms).move(begin: Offset(0, 50), end: Offset(0, 0), duration: 800.ms),

                  const SizedBox(height: 15),

                  // Forgot Password Section with fade-in-up animation
                  Center(
                    child: Column(
                      children: [
                        const Text(
                          "Resend OTP",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.blueGrey,
                          ),
                        ),
                        const SizedBox(height: 15),
                        GestureDetector(
                          onTap: () {
                            // Navigate to the RegisterPage when tapped
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => RegisterPage()),
                            );
                          },
                          child: const Text(
                            "   ",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.blueGrey,
                              decoration: TextDecoration.underline, // Optionally underline the text
                            ),
                          ),
                        ),
                      ],
                    ),
                  ).animate().fadeIn(duration: 800.ms).move(begin: Offset(0, 50), end: Offset(0, 0), duration: 800.ms),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
