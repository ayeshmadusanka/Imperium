import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:file_picker/file_picker.dart'; // Import the file_picker package

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Academic Qualification Form',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: 'Inter',
      ),
      home: const AcademicQualificationPage(),
    );
  }
}

class AcademicQualificationPage extends StatefulWidget {
  const AcademicQualificationPage({super.key});

  @override
  State<AcademicQualificationPage> createState() => _AcademicQualificationPageState();
}

class _AcademicQualificationPageState extends State<AcademicQualificationPage> {
  // List to hold multiple qualification entries
  final List<Map<String, dynamic>> _qualificationEntries = [];

  @override
  void initState() {
    super.initState();
    // Add the first qualification entry when the page initializes
    _addAnotherQualificationEntry();
  }

  // Method to add a new, empty qualification entry
  void _addAnotherQualificationEntry() {
    setState(() {
      _qualificationEntries.add({
        'townPlaceController': TextEditingController(),
        'fromDateController': TextEditingController(),
        'toDateController': TextEditingController(),
        'instituteCollegeController': TextEditingController(),
        'selectedDegreeType': null, // String?
        'fileName': 'No file chosen', // String
      });
    });
  }

  // Method to remove a qualification entry by index
  void _removeQualificationEntry(int index) {
    setState(() {
      // Dispose controllers before removing to prevent memory leaks
      _qualificationEntries[index]['townPlaceController']?.dispose();
      _qualificationEntries[index]['fromDateController']?.dispose();
      _qualificationEntries[index]['toDateController']?.dispose();
      _qualificationEntries[index]['instituteCollegeController']?.dispose();
      _qualificationEntries.removeAt(index);
    });
  }

  Future<void> _selectDate(BuildContext context, int index, TextEditingController controller) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        controller.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  Future<void> _chooseFile(int index) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'], // Only allow PDF files as per "Transcript (PDF)"
    );

    if (result != null && result.files.single.name != null) {
      setState(() {
        _qualificationEntries[index]['fileName'] = result.files.single.name!;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Selected file: ${_qualificationEntries[index]['fileName']}')),
      );
    } else {
      // User canceled the picker or no file was selected
      setState(() {
        _qualificationEntries[index]['fileName'] = 'No file chosen';
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('File selection canceled or failed.')),
      );
    }
  }

  // Method to handle saving all changes
  void _saveChanges() {
    // Here you would typically gather all data from _qualificationEntries
    // and send it to your backend or save it locally.
    // For this example, we'll just print the data and show a SnackBar.
    print('Saving changes for all qualifications:');
    for (var entry in _qualificationEntries) {
      print('  Town/Place: ${entry['townPlaceController'].text}');
      print('  From Date: ${entry['fromDateController'].text}');
      print('  To Date: ${entry['toDateController'].text}');
      print('  Institute/College: ${entry['instituteCollegeController'].text}');
      print('  Degree/Course Type: ${entry['selectedDegreeType']}');
      print('  File Name: ${entry['fileName']}');
      print('---');
    }
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Changes saved successfully! (Simulated)')),
    );
  }

  @override
  void dispose() {
    // Dispose all controllers in all entries
    for (var entry in _qualificationEntries) {
      entry['townPlaceController']?.dispose();
      entry['fromDateController']?.dispose();
      entry['toDateController']?.dispose();
      entry['instituteCollegeController']?.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Define a consistent width for both buttons
    final double buttonWidth = MediaQuery.of(context).size.width * 0.7; // Example: 70% of screen width

    return Scaffold(
      backgroundColor: Colors.white, // Changed background to white
      appBar: AppBar(
        backgroundColor: Colors.blue.shade900, // App bar color blue.shade900
        elevation: 0,
        title: const Text(
          'Academic Qualification', // Title text
          style: TextStyle(
            color: Colors.white, // Text color white
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        leading: IconButton( // Back button
          icon: const Icon(Icons.arrow_back, color: Colors.white), // Button color white
          onPressed: () {
            Navigator.pop(context); // Navigates back to the previous screen
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Dynamically generate qualification cards
            ..._qualificationEntries.asMap().entries.map((entry) {
              final int index = entry.key;
              final Map<String, dynamic> qualification = entry.value;

              return Padding(
                padding: const EdgeInsets.only(bottom: 16.0), // Space between cards
                child: Card(
                  color: Colors.white, // Explicitly set card background to white
                  elevation: 0, // No shadow
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                    side: BorderSide.none, // Removed the card border
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Academic Qualification #${index + 1}', // Changed title to reflect index
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                            if (_qualificationEntries.length > 1) // Only show remove if more than one entry
                              IconButton(
                                icon: const Icon(Icons.close, color: Colors.red),
                                onPressed: () => _removeQualificationEntry(index),
                              ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        _buildLabeledTextField(
                          label: 'Town/Place *',
                          hintText: 'Town or place of study',
                          controller: qualification['townPlaceController'],
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              child: _buildLabeledTextField(
                                label: 'From Date *',
                                hintText: 'yyyy-mm-dd',
                                controller: qualification['fromDateController'],
                                suffixIcon: Icons.calendar_today,
                                onSuffixIconTap: () => _selectDate(context, index, qualification['fromDateController']),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: _buildLabeledTextField(
                                label: 'To Date *',
                                hintText: 'yyyy-mm-dd',
                                controller: qualification['toDateController'],
                                suffixIcon: Icons.calendar_today,
                                onSuffixIconTap: () => _selectDate(context, index, qualification['toDateController']),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        _buildLabeledTextField(
                          label: 'Name of Institute/College *',
                          hintText: 'Institute or college name',
                          controller: qualification['instituteCollegeController'],
                        ),
                        const SizedBox(height: 16),
                        _buildLabeledDropdown(
                          label: 'Type of Degree/Course *',
                          hintText: 'Select degree/course type',
                          value: qualification['selectedDegreeType'],
                          items: const ['Bachelor', 'Master', 'Diploma', 'Certificate', 'Other'], // Example items
                          onChanged: (String? newValue) {
                            setState(() {
                              qualification['selectedDegreeType'] = newValue;
                            });
                          },
                        ),
                        const SizedBox(height: 16),
                        _buildFileUploadSection(index, qualification['fileName']),
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),

            // "Add Another Qualification" button
            Center(
              child: SizedBox(
                width: buttonWidth, // Apply consistent width
                child: OutlinedButton.icon(
                  onPressed: _addAnotherQualificationEntry, // Call the new method
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.black87, // Text color
                    side: BorderSide(color: Colors.grey.shade300), // Border color
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12), // Padding for consistent size
                  ),
                  icon: const Icon(Icons.add, size: 20),
                  label: const Text(
                    'Add Another Qualification',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12), // Space before the Save Changes button
            // Save Changes Button
            Center(
              child: SizedBox(
                width: buttonWidth, // Apply consistent width
                child: ElevatedButton(
                  onPressed: _saveChanges, // Call the save changes method
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue.shade900, // Background color for the button
                    foregroundColor: Colors.white, // Text color for the button
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12), // Adjusted padding for consistent size
                  ),
                  child: const Text(
                    'Save Changes',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
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
    required TextEditingController controller, // Now required as it's from the list
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
            fontWeight: FontWeight.w600,
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

  Widget _buildFileUploadSection(int index, String fileName) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Upload Certificate/Transcript (PDF)',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.all(1.0), // Padding to make the inner content visible
          child: Row(
            children: [
              TextButton(
                onPressed: () => _chooseFile(index),
                style: TextButton.styleFrom(
                  backgroundColor: Colors.blue.shade50, // Light blue background
                  foregroundColor: Colors.blue.shade700, // Darker blue text
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6), // Slightly less rounded than container
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                ),
                child: const Text('Choose file'),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  fileName, // Use the fileName passed for this index
                  style: TextStyle(color: Colors.grey.shade600),
                  overflow: TextOverflow.ellipsis, // Handle long file names
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
