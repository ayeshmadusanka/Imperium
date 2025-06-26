import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // For date formatting, though not directly used in this specific form, kept for consistency

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Emergency Contact Form',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: 'Inter', // Assuming 'Inter' font is available or default system font
      ),
      home: const EmergencyContactPage(),
    );
  }
}

class EmergencyContactPage extends StatefulWidget {
  const EmergencyContactPage({super.key});

  @override
  State<EmergencyContactPage> createState() => _EmergencyContactPageState();
}

class _EmergencyContactPageState extends State<EmergencyContactPage> {
  final TextEditingController _nameNextOfKinController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _relationshipController = TextEditingController();
  final TextEditingController _mobileNoController = TextEditingController();
  final TextEditingController _homeNoController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  // No date picker needed for this form based on the image

  @override
  void dispose() {
    _nameNextOfKinController.dispose();
    _addressController.dispose();
    _relationshipController.dispose();
    _mobileNoController.dispose();
    _homeNoController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  // Method to handle saving all changes
  void _saveChanges() {
    print('Saving emergency contact details:');
    print('  Name of Next of Kin: ${_nameNextOfKinController.text}');
    print('  Address: ${_addressController.text}');
    print('  Relationship: ${_relationshipController.text}');
    print('  Mobile No.: ${_mobileNoController.text}');
    print('  Home No.: ${_homeNoController.text}');
    print('  E-Mail: ${_emailController.text}');
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Emergency contact details saved successfully! (Simulated)')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double buttonWidth = MediaQuery.of(context).size.width * 0.7; // Consistent button width

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue.shade900,
        elevation: 0,
        title: const Text(
          'Emergency Contact', // App bar title
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(32.0), // Consistent padding
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _buildLabeledTextField(
              label: 'Name of Next of Kin *',
              hintText: 'Full name of next of kin',
              controller: _nameNextOfKinController,
            ),
            const SizedBox(height: 16),
            _buildLabeledTextField(
              label: 'Address *',
              hintText: 'Complete address of next of kin',
              controller: _addressController,
              maxLines: 3, // For multi-line address
            ),
            const SizedBox(height: 16),
            _buildLabeledTextField(
              label: 'Relationship *',
              hintText: 'e.g., Father, Mother, Spouse, Brother, Sister',
              controller: _relationshipController,
            ),
            const SizedBox(height: 16),
            _buildLabeledTextField(
              label: 'Mobile No. *',
              hintText: 'Mobile number',
              controller: _mobileNoController,
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 16),
            _buildLabeledTextField(
              label: 'Home No. (Optional)',
              hintText: 'Home phone number',
              controller: _homeNoController,
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 16),
            _buildLabeledTextField(
              label: 'E-Mail (Optional)',
              hintText: 'email@example.com',
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 20), // Padding before the button

            // Save Changes Button
            Center(
              child: SizedBox(
                width: buttonWidth, // Apply consistent width
                child: ElevatedButton(
                  onPressed: _saveChanges,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue.shade900,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  ),
                  child: const Text(
                    'Save Changes',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20), // Padding after the button
          ],
        ),
      ),
    );
  }

  Widget _buildLabeledTextField({
    required String label,
    required String hintText,
    TextEditingController? controller,
    TextInputType? keyboardType,
    int maxLines = 1,
    IconData? suffixIcon,
    VoidCallback? onSuffixIconTap,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          maxLines: maxLines,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(color: Colors.grey.shade500),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.blue, width: 2),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            suffixIcon: suffixIcon != null
                ? GestureDetector(
              onTap: onSuffixIconTap,
              child: Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Icon(suffixIcon, color: Colors.grey.shade600),
              ),
            )
                : null,
          ),
        ),
      ],
    );
  }
// No _buildLabeledDropdown needed for this form based on the image
}
