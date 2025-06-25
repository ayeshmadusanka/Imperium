import 'dart:ui';
import 'package:flutter/material.dart';
import 'login_without_top.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.asset(
              'assets/onboarding.png',
              fit: BoxFit.cover,
            ),
          ),

          // Blurred Circle using ImageFiltered
          Positioned(
            bottom: -600,
            left: screenWidth / 2 - 425,
            child: ImageFiltered(
              imageFilter: ImageFilter.blur(sigmaX: 80, sigmaY: 30),
              child: Container(
                width: 850,
                height: 850,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFF12769A).withOpacity(1),
                ),
              ),
            ),
          ),

          // Content
          SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Logo
                Padding(
                  padding: const EdgeInsets.only(top: 60.0),
                  child: Center(
                    child: Image.asset(
                      'assets/logo.png',
                      height: 50,
                    ),
                  ),
                ),

                // Get Started Button
                Padding(
                  padding: const EdgeInsets.all(96.0),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => LoginNoTop()),
                        );
                      }
                      ,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black,
                        padding: const EdgeInsets.symmetric(vertical: 18),
                        textStyle: const TextStyle(fontSize: 18),
                      ).copyWith(
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20), // Adjust this value to reduce the radius
                          ),
                        ),
                      ),
                      child: const Text('GET STARTED'),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
