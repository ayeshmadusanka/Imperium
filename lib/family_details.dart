import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // For date formatting

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Family Details Form',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: 'Inter', // Assuming 'Inter' font is available or default system font
      ),
      home: const FamilyDetailsPage(),
    );
  }
}

class FamilyDetailsPage extends StatefulWidget {
  const FamilyDetailsPage({super.key});

  @override
  State<FamilyDetailsPage> createState() => _FamilyDetailsPageState();
}

class _FamilyDetailsPageState extends State<FamilyDetailsPage> {
  // Initially leave the marital status unselected
  String? _maritalStatus;
  final TextEditingController _spouseSurnameController = TextEditingController();
  final TextEditingController _spouseOtherNamesController = TextEditingController();
  final TextEditingController _numberOfChildrenController = TextEditingController();
  final TextEditingController _spousePlaceOfBirthController = TextEditingController();
  final TextEditingController _spouseDateOfBirthController = TextEditingController();
  final TextEditingController _spouseHomeAddressController = TextEditingController();
  final TextEditingController _fatherFullNameController = TextEditingController();
  final TextEditingController _motherFullNameController = TextEditingController();

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
    _spouseSurnameController.dispose();
    _spouseOtherNamesController.dispose();
    _numberOfChildrenController.dispose();
    _spousePlaceOfBirthController.dispose();
    _spouseDateOfBirthController.dispose();
    _spouseHomeAddressController.dispose();
    _fatherFullNameController.dispose();
    _motherFullNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Changed background to white
      appBar: AppBar(
        backgroundColor: Colors.blue.shade900, // App bar color blue.shade900
        elevation: 0, // No shadow
        title: const Text(
          'Family Details',
          style: TextStyle(
            color: Colors.white, // Text color white
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        leading: IconButton( // Added back button
          icon: const Icon(Icons.arrow_back, color: Colors.white), // Button color white
          onPressed: () {
            // Implement navigation back functionality here
            Navigator.pop(context); // Navigates back to the previous screen
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Marital Information Section

            const SizedBox(height: 16),
            _buildLabeledDropdown(
              label: 'Marital Status *',
              hintText: 'Select marital status',
              value: _maritalStatus,
              items: const ['Married', 'Unmarried'],
              onChanged: (String? newValue) {
                setState(() {
                  _maritalStatus = newValue;
                  // Clear spouse details if status changes to Unmarried
                  if (newValue == 'Unmarried') {
                    _spouseSurnameController.clear();
                    _spouseOtherNamesController.clear();
                    _numberOfChildrenController.clear();
                    _spousePlaceOfBirthController.clear();
                    _spouseDateOfBirthController.clear();
                    _spouseHomeAddressController.clear();
                  }
                });
              },
            ),
            if (_maritalStatus == 'Married') ...[
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: _buildLabeledTextField(
                      label: 'Surname of Spouse (Optional)',
                      hintText: 'Spouse surname',
                      controller: _spouseSurnameController,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildLabeledTextField(
                      label: 'Other Names of Spouse (Optional)',
                      hintText: 'Spouse other names',
                      controller: _spouseOtherNamesController,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              _buildLabeledTextField(
                label: 'No. of Children (Optional)',
                hintText: 'Number of children',
                keyboardType: TextInputType.number,
                controller: _numberOfChildrenController,
              ),
              const SizedBox(height: 16),
              _buildLabeledTextField(
                label: 'Place of Birth of Spouse (Optional)',
                hintText: 'Spouse place of birth',
                controller: _spousePlaceOfBirthController,
              ),
              const SizedBox(height: 16),
              _buildLabeledTextField(
                label: 'Date of Birth of Spouse (Optional)',
                hintText: 'dd/mm/yyyy',
                controller: _spouseDateOfBirthController,
                suffixIcon: Icons.calendar_today,
                onSuffixIconTap: () => _selectDate(context, _spouseDateOfBirthController),
              ),
              const SizedBox(height: 16),
              _buildLabeledTextField(
                label: 'Home Address of Spouse (If different from permanent address)',
                hintText: 'Spouse home address if different',
                maxLines: 3,
                controller: _spouseHomeAddressController,
              ),
            ],
            const SizedBox(height: 24), // Space before Parents Information

            // Parents Information Section
            const Text(
              'Parents Information',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 16),
            _buildLabeledTextField(
              label: 'Full Name of the Father (Optional)',
              hintText: "Father's full name",
              controller: _fatherFullNameController,
            ),
            const SizedBox(height: 16),
            _buildLabeledTextField(
              label: 'Full Name of the Mother (Optional)',
              hintText: "Mother's full name",
              controller: _motherFullNameController,
            ),
            const SizedBox(height: 20), // Padding at the bottom
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
            fontWeight: FontWeight.w600, // Slightly bolder for labels
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

  Widget _buildLabeledDropdown({
    required String label,
    required String hintText,
    required List<String> items,
    String? value,
    required ValueChanged<String?> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600, // Slightly bolder for labels
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: value,
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
          ),
          icon: Icon(Icons.keyboard_arrow_down, color: Colors.grey.shade600),
          isExpanded: true,
          onChanged: onChanged,
          items: items.map<DropdownMenuItem<String>>((String item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Text(item),
            );
          }).toList(),
        ),
      ],
    );
  }
}
