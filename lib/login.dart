import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'register.dart';
import 'home.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // List of roles
  final List<String> roles = [
    "Captain",
    "Deck Crew",
    "Engineer",
    "Cook",
    "Medic",
    "Navigator",
  ];

  // Current selected role
  String selectedRole = "Captain";

  // Function to get the appropriate profile icon based on the role
  IconData getRoleIcon(String role) {
    switch (role) {
      case "Captain":
        return Icons.anchor; // Icon for Captain
      case "Deck Crew":
        return Icons.deck; // Icon for Deck Crew
      case "Engineer":
        return Icons.engineering; // Icon for Engineer
      case "Cook":
        return Icons.restaurant; // Icon for Cook
      case "Medic":
        return Icons.local_hospital; // Icon for Medic
      case "Navigator":
        return Icons.navigation; // Icon for Navigator
      default:
        return Icons.help_outline; // Default icon for unknown roles
    }
  }

  // Controllers for text fields
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool _isPasswordVisible = false; // To toggle password visibility

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
                    height: 250,
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
                          // Circle Avatar with fade-in-up animation
                          CircleAvatar(
                            radius: 60,
                            backgroundColor: Colors.blue.shade900,
                            child: Icon(
                              getRoleIcon(selectedRole),
                              size: 60,
                              color: Colors.white,
                            ),
                          ).animate().fadeIn(duration: 800.ms).move(begin: Offset(0, -50), end: Offset(0, 0), duration: 800.ms),
                          const SizedBox(height: 10),

                          // Dropdown for role selection with fade-in-up animation
                          IntrinsicWidth(
                            child: DropdownButtonHideUnderline(
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: screenWidth * 0.1, // Adjust padding based on screen width
                                ),
                                child: DropdownButton<String>(
                                  value: selectedRole,
                                  dropdownColor: Colors.white,
                                  iconEnabledColor: Colors.blue.shade900,
                                  isExpanded: true, // Dynamically adjust to text length
                                  items: roles
                                      .map((role) => DropdownMenuItem(
                                    value: role,
                                    alignment: Alignment.center,
                                    child: Text(
                                      role,
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.blue.shade900,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ))
                                      .toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      selectedRole = value!;
                                    });
                                  },
                                ),
                              ),
                            ),
                          ).animate().fadeIn(duration: 800.ms).move(begin: Offset(0, 50), end: Offset(0, 0), duration: 800.ms),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Login Section with fade-in-up animation
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 00),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Fade-in-up for Login text
                  Text(
                    "Login",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 56,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue.shade900, // Use color directly here
                    ),
                  ).animate().fadeIn(duration: 800.ms).move(begin: Offset(0, 50), end: Offset(0, 0), duration: 800.ms),
                  const SizedBox(height: 0),
                  const Text(
                    "Sign in to continue",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.blueGrey,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Name Field with fade-in-up animation (Phone Number)
                  Container(
                    height: 56, // Set a fixed height for text fields
                    child: TextField(
                      controller: phoneController,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        hintText: "Phone Number",
                        filled: true,
                        fillColor: Colors.blue.shade100,
                        prefixIcon: Icon(Icons.phone, color: Colors.blue.shade900),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ).animate().fadeIn(duration: 800.ms).move(begin: Offset(0, 50), end: Offset(0, 0), duration: 800.ms),
                  ),
                  const SizedBox(height: 15),

                  // Password Field with fade-in-up animation
                  Container(
                    height: 56, // Set a fixed height for text fields
                    child: TextField(
                      controller: passwordController,
                      obscureText: !_isPasswordVisible,
                      decoration: InputDecoration(
                        hintText: "Password",
                        filled: true,
                        fillColor: Colors.blue.shade100,
                        prefixIcon: Icon(Icons.lock, color: Colors.blue.shade900),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Colors.blue.shade900,
                          ),
                          onPressed: () {
                            setState(() {
                              _isPasswordVisible = !_isPasswordVisible;
                            });
                          },
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ).animate().fadeIn(duration: 800.ms).move(begin: Offset(0, 50), end: Offset(0, 0), duration: 800.ms),
                  ),
                  const SizedBox(height: 20),

                  // Login Button with fade-in-up animation
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue.shade900,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  onPressed: () {
                    // Navigate to the HomePage
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HomePage()),
                    );
                  },
                  child: const Text(
                    "Log In",
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
                          "Forgot Password",
                          style: TextStyle(
                            fontSize: 14,
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
                            "Don't have an account?, sign up",
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
