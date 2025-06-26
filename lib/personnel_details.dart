import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Ensure intl package is imported for DateFormat

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personnel Information Form', // Changed title
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: 'Inter', // Assuming 'Inter' font is available or default system font
      ),
      home: const PersonnelInformationPage(), // Changed home to PersonnelInformationPage
    );
  }
}

class PersonnelInformationPage extends StatefulWidget { // Renamed class from BasicInformationPage
  const PersonnelInformationPage({super.key});

  @override
  State<PersonnelInformationPage> createState() => _PersonnelInformationPageState(); // Renamed state class
}

class _PersonnelInformationPageState extends State<PersonnelInformationPage> { // Renamed state class
  final TextEditingController _dateAvailableController = TextEditingController();
  final TextEditingController _dateOfBirthController = TextEditingController();

  Future<void> _selectDate(BuildContext context, TextEditingController controller) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        controller.text = DateFormat('dd/MM/yyyy').format(picked);
      });
    }
  }

  @override
  void dispose() {
    _dateAvailableController.dispose();
    _dateOfBirthController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Define a consistent width for the button, similar to the Academic Qualification page
    final double buttonWidth = MediaQuery.of(context).size.width * 0.7; // Example: 70% of screen width

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade900, // Changed app bar background color
        elevation: 0,
        title: const Text( // Title for the form
          'Basic Information', // Added const for TextStyle
          style: TextStyle(
            color: Colors.white, // Changed app bar title color
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: false, // Align title to left as per image
        leading: IconButton( // Added leading icon (back button)
          icon: const Icon(Icons.arrow_back, color: Colors.white), // Set icon color to white
          onPressed: () {
            Navigator.pop(context); // Example: navigate back
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(32.0), // Reverted padding to 16.0 for consistency with previous versions if it was 20.0
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // First Name and Surname (Order changed)
            Row(
              children: [
                Expanded(
                  child: _buildLabeledTextField(
                    label: 'First Name *',
                    hintText: 'First name',
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildLabeledTextField(
                    label: 'Surname *',
                    hintText: 'Last name',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Permanent Address (Moved after First Name and Surname)
            _buildLabeledTextField(
              label: 'Permanent Address *',
              hintText: 'Enter your permanent address',
              maxLines: 3,
            ),
            const SizedBox(height: 16),

            // Home No. (Optional)
            _buildLabeledTextField(
              label: 'Home No. (Optional)',
              hintText: 'Home phone number',
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 16),

            // Mobile No. *
            _buildLabeledTextField(
              label: 'Mobile No. *',
              hintText: 'Mobile number',
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 16),

            // Mobile No. (WhatsApp) *
            _buildLabeledTextField(
              label: 'Mobile No. (WhatsApp) *',
              hintText: 'WhatsApp number',
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 16),

            // E-Mail
            _buildLabeledTextField(
              label: 'E-Mail',
              hintText: 'your.email@example.com',
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 16),

            // City/Place of Birth *
            _buildLabeledTextField(
              label: 'City/Place of Birth *',
              hintText: 'City of birth',
            ),
            const SizedBox(height: 16),

            // Date of Birth and Nationality
            Row(
              children: [
                Expanded(
                  child: _buildLabeledTextField(
                    label: 'Date of Birth *',
                    hintText: 'dd/mm/yyyy',
                    controller: _dateOfBirthController,
                    keyboardType: TextInputType.datetime,
                    suffixIcon: Icons.calendar_today,
                    onSuffixIconTap: () => _selectDate(context, _dateOfBirthController),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildLabeledDropdown(
                    label: 'Nationality *',
                    hintText: 'Select nationality',
                    items: const ['Nationality 1', 'Nationality 2', 'Nationality 3'], // Example items
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Age, Height, Weight
            Row(
              children: [
                Expanded(
                  child: _buildLabeledTextField(
                    label: 'Age',
                    hintText: 'Age',
                    keyboardType: TextInputType.number,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildLabeledTextField(
                    label: 'Height (cm) *',
                    hintText: 'Height',
                    keyboardType: TextInputType.number,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildLabeledTextField(
                    label: 'Weight (kg) *',
                    hintText: 'Weight',
                    keyboardType: TextInputType.number,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Blood Group *
            _buildLabeledDropdown(
              label: 'Blood Group *',
              hintText: 'Select blood group',
              items: const ['A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-'], // Example items
            ),
            const SizedBox(height: 16),

            // Religion (Optional)
            _buildLabeledTextField(
              label: 'Religion (Optional)',
              hintText: 'Religion',
            ),
            const SizedBox(height: 16),

            // Safety Shoe Size and Boiler Suit Size
            Row(
              children: [
                Expanded(
                  child: _buildLabeledDropdown(
                    label: 'Safety Shoe Size *',
                    hintText: 'Size',
                    items: const ['6', '7', '8', '9', '10', '11', '12'], // Example sizes
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildLabeledDropdown(
                    label: 'Boiler Suit Size *',
                    hintText: 'Size',
                    items: const ['S', 'M', 'L', 'XL', 'XXL'], // Example sizes
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16), // Add a SizedBox before moving Date Available

            // Date Available (Moved to last)
            _buildLabeledTextField(
              label: 'Date Available *',
              hintText: 'dd/mm/yyyy',
              controller: _dateAvailableController,
              keyboardType: TextInputType.datetime,
              suffixIcon: Icons.calendar_today,
              onSuffixIconTap: () => _selectDate(context, _dateAvailableController),
            ),
            const SizedBox(height: 20), // Padding before the button

            // Save Changes Button
            Center(
              child: SizedBox(
                width: buttonWidth, // Apply the consistent width
                child: ElevatedButton(
                  onPressed: () {
                    // Implement save changes logic here
                    print('Save Changes button pressed!');
                    // You can collect data from controllers and dropdowns here
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue.shade900, // Button background color
                    foregroundColor: Colors.white, // Button text color
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12), // Match padding with other button
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8), // Rounded corners for button
                    ),
                  ),
                  child: const Text(
                    'Save Changes',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
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
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          maxLines: maxLines,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: const TextStyle(color: Colors.grey),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.grey),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.blue, width: 2),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            suffixIcon: suffixIcon != null
                ? GestureDetector(
              onTap: onSuffixIconTap,
              child: Icon(suffixIcon, color: Colors.grey),
            )
                : null,
          ),
        ),
      ],
    );
  }

  Widget _buildLabeledDropdown({
    required String label,
    required String hintText,
    required List<String> items,
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
        DropdownButtonFormField<String>(
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: const TextStyle(color: Colors.grey),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.grey),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.blue, width: 2),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          ),
          icon: const Icon(Icons.keyboard_arrow_down, color: Colors.grey),
          isExpanded: true,
          value: null, // No initial value selected
          onChanged: (String? newValue) {
            // Handle dropdown value change
            print('Selected: $newValue');
          },
          items: items.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
      ],
    );
  }
}
