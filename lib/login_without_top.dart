import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'register.dart';
import 'home.dart';

class LoginNoTop extends StatefulWidget {
  const LoginNoTop({Key? key}) : super(key: key);

  @override
  State<LoginNoTop> createState() => _LoginNoTopState();
}

class _LoginNoTopState extends State<LoginNoTop> {
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
            // Ship Icon at the top
            // Ship Icon at the top (Replaced with logo.png)
            Padding(
              padding: const EdgeInsets.only(top: 100.0),
              child: Image.asset(
                "assets/logo.png", // Ensure logo.png is in the assets folder
                width: 240,
                height: 60,
              ).animate().fadeIn(duration: 800.ms).move(begin: Offset(0, -50), end: Offset(0, 0), duration: 800.ms),
            ),


            // Login Section with fade-in-up animation
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Fade-in-up for Login text
                  Text(
                    "Login",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue.shade900, // Use color directly here
                    ),
                  ).animate().fadeIn(duration: 800.ms).move(begin: Offset(0, 50), end: Offset(0, 0), duration: 800.ms),
                  const SizedBox(height: 05),
                  const Text(
                    "Sign in to continue",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.blueGrey,
                    ),
                  ).animate().fadeIn(duration: 800.ms).move(begin: Offset(0, 50), end: Offset(0, 0), duration: 800.ms),
                  const SizedBox(height: 30),

                  // Name Field with fade-in-up animation (Phone Number)
                  TextField(
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
                    style: TextStyle(height: 0.8), // Adjust text field height
                  ).animate().fadeIn(duration: 800.ms).move(begin: Offset(0, 50), end: Offset(0, 0), duration: 800.ms),
                  const SizedBox(height: 15),

                  // Password Field with fade-in-up animation
                  TextField(
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
                    style: TextStyle(height: 0.8), // Adjust text field height
                  ).animate().fadeIn(duration: 800.ms).move(begin: Offset(0, 50), end: Offset(0, 0), duration: 800.ms),
                  const SizedBox(height: 20),

                  // Login Button with fade-in-up animation
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue.shade900,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 14),
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
                              decoration: TextDecoration.none, // Optionally underline the text
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
