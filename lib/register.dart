import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'login.dart';
import 'login_without_top.dart';
import 'register_verification.dart';

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
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool _isPasswordVisible = false; // To toggle password visibility

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Set background color to white
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Top Section with Logo
            Padding(
              padding: const EdgeInsets.only(top: 70.0),
              child: Column(
                children: [
                  Image.asset(
                    "assets/logo.png",
                    height: 55,
                    width: 240,
                  )
                      .animate()
                      .fadeIn(duration: 800.ms)
                      .moveY(begin: -50, end: 0, duration: 800.ms),
                ],
              ),
            ),

            // Register Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    "Register",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue.shade900,
                    ),
                  )
                      .animate()
                      .fadeIn(duration: 800.ms)
                      .moveY(begin: 50, end: 0, duration: 800.ms),

                  const SizedBox(height: 5),

                  const Text(
                    "Create an account to continue",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.blueGrey,
                    ),
                  )
                      .animate()
                      .fadeIn(duration: 800.ms)
                      .moveY(begin: 50, end: 0, duration: 800.ms),

                  const SizedBox(height: 30),

                  // First Name
                  TextField(
                    controller: usernameController,
                    decoration: InputDecoration(
                      hintText: "First Name",
                      filled: true,
                      fillColor: Colors.blue.shade100,
                      prefixIcon: Icon(Icons.person, color: Colors.blue.shade900),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                    ),
                  )
                      .animate()
                      .fadeIn(duration: 800.ms)
                      .moveY(begin: 50, end: 0, duration: 800.ms),

                  const SizedBox(height: 15),

                  // Last Name
                  TextField(
                    controller: lastNameController,
                    decoration: InputDecoration(
                      hintText: "Last Name",
                      filled: true,
                      fillColor: Colors.blue.shade100,
                      prefixIcon: Icon(Icons.person, color: Colors.blue.shade900),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                    ),
                  )
                      .animate()
                      .fadeIn(duration: 800.ms)
                      .moveY(begin: 50, end: 0, duration: 800.ms),

                  const SizedBox(height: 15),

                  // Role Dropdown
                  DropdownButtonFormField<String>(
                    value: selectedRole,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedRole = newValue!;
                      });
                    },
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.blue.shade100,
                      prefixIcon: Icon(Icons.people, color: Colors.blue.shade900),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                    ),
                    items: roles.map<DropdownMenuItem<String>>((String role) {
                      return DropdownMenuItem<String>(
                        value: role,
                        child: Text(role),
                      );
                    }).toList(),
                  )
                      .animate()
                      .fadeIn(duration: 800.ms)
                      .moveY(begin: 50, end: 0, duration: 800.ms),

                  const SizedBox(height: 15),

                  // Phone Number
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
                      contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                    ),
                  )
                      .animate()
                      .fadeIn(duration: 800.ms)
                      .moveY(begin: 50, end: 0, duration: 800.ms),

                  const SizedBox(height: 15),

                  // Password
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
                          _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
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
                      contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                    ),
                  )
                      .animate()
                      .fadeIn(duration: 800.ms)
                      .moveY(begin: 50, end: 0, duration: 800.ms),

                  const SizedBox(height: 20),

                  // Register Button
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue.shade900,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => RegisterVerificationPage()),
                      );
                    },
                    child: const Text(
                      "Register",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  )
                      .animate()
                      .fadeIn(duration: 800.ms)
                      .moveY(begin: 50, end: 0, duration: 800.ms),

                  const SizedBox(height: 15),

                  // Already have an account? Log in
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => LoginNoTop()));
                      },
                      child: const Text(
                        "Already have an account? Log in",
                        style: TextStyle(fontSize: 14, color: Colors.blueGrey),
                      ),
                    ),
                  )
                      .animate()
                      .fadeIn(duration: 800.ms)
                      .moveY(begin: 50, end: 0, duration: 800.ms),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
