import 'package:flutter/material.dart';
import 'login_without_top.dart';
import 'login.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white, // Set the default background color to white
        textSelectionTheme: TextSelectionThemeData(
          selectionColor: Colors.blue.shade100, // Text highlight color
          cursorColor: Colors.blue.shade900, // Blinker color
          selectionHandleColor: Colors.blue.shade900, // Water drop color
        ),

      ),
      home: const LoginNoTop(),
    );
  }
}
