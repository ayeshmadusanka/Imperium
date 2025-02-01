import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'login.dart';
import 'login_without_top.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
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

  // Controllers for text fields
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool _isPasswordVisible = false; // To toggle password visibility
  bool _isConfirmPasswordVisible = false; // To toggle confirm password visibility

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
              padding: const EdgeInsets.only(top: 0.0), // Adjust top padding as needed
              child: Stack(
                children: [
                  Container(
                    height: 160,
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
                          // Removed profile icon and role dropdown section
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Register Section with fade-in-up animation
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 00),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Fade-in-up for Register text
                  Text(
                    "Register",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue.shade900, // Use color directly here
                    ),
                  ).animate().fadeIn(duration: 800.ms).move(begin: Offset(0, 50), end: Offset(0, 0), duration: 800.ms),
                  const SizedBox(height: 5),
                  const Text(
                    "Create an account to continue",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.blueGrey,
                    ),
                  ),
                  const SizedBox(height: 30),

                  // Username Field with fade-in-up animation
                  TextField(
                    controller: usernameController,
                    decoration: InputDecoration(
                      hintText: "First Name",
                      filled: true,
                      fillColor: Colors.blue.shade100,
                      prefixIcon: Icon(Icons.person, color: Colors.blue.shade900),
                      contentPadding: EdgeInsets.symmetric(vertical: 14, horizontal: 16), // Adjust padding to reduce height
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ).animate().fadeIn(duration: 800.ms).move(begin: Offset(0, 50), end: Offset(0, 0), duration: 800.ms),
                  const SizedBox(height: 15),

                  TextField(
                    controller: usernameController,
                    decoration: InputDecoration(
                      hintText: "Last Name",
                      filled: true,
                      fillColor: Colors.blue.shade100,
                      prefixIcon: Icon(Icons.person, color: Colors.blue.shade900),
                      contentPadding: EdgeInsets.symmetric(vertical: 14, horizontal: 16), // Adjust padding to reduce height
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ).animate().fadeIn(duration: 800.ms).move(begin: Offset(0, 50), end: Offset(0, 0), duration: 800.ms),
                  const SizedBox(height: 15),

                  // Role Field as Dropdown
                  DropdownButtonFormField<String>(
                    value: selectedRole,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedRole = newValue!;
                      });
                    },
                    decoration: InputDecoration(
                      hintText: "Select Role",
                      filled: true,
                      fillColor: Colors.blue.shade100,
                      prefixIcon: Icon(Icons.people, color: Colors.blue.shade900),
                      contentPadding: EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    items: roles.map<DropdownMenuItem<String>>((String role) {
                      return DropdownMenuItem<String>(
                        value: role,
                        child: Text(role),
                      );
                    }).toList(),
                  ).animate().fadeIn(duration: 800.ms).move(begin: Offset(0, 50), end: Offset(0, 0), duration: 800.ms),
                  const SizedBox(height: 15),

                  // Phone Number Field with fade-in-up animation
                  TextField(
                    controller: phoneController,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      hintText: "Phone Number",
                      filled: true,
                      fillColor: Colors.blue.shade100,
                      prefixIcon: Icon(Icons.phone, color: Colors.blue.shade900),
                      contentPadding: EdgeInsets.symmetric(vertical: 14, horizontal: 16), // Adjust padding to reduce height
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide.none,
                      ),
                    ),
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
                      contentPadding: EdgeInsets.symmetric(vertical: 14, horizontal: 16), // Adjust padding to reduce height
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ).animate().fadeIn(duration: 800.ms).move(begin: Offset(0, 50), end: Offset(0, 0), duration: 800.ms),
                  const SizedBox(height: 20),

                  // Register Button with fade-in-up animation
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue.shade900,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 14), // Adjust padding to match field height
                    ),
                    onPressed: () {
                      // Handle registration functionality
                    },
                    child: const Text(
                      "Register",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ).animate().fadeIn(duration: 800.ms).move(begin: Offset(0, 50), end: Offset(0, 0), duration: 800.ms),
                  const SizedBox(height: 15),

                  // Already have an account section with fade-in-up animation
                  Center(
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            // Navigate to LoginPage when tapped
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => LoginNoTop()),
                            );
                          },
                          child: const Text(
                            "Already have an account? Log in",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.blueGrey,
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
