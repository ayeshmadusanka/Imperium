import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // For date formatting
import 'package:file_picker/file_picker.dart'; // Import for file picking functionality

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Certifications Form',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: 'Inter', // Assuming 'Inter' font is available or default system font
      ),
      home: const CertificatesPage(),
    );
  }
}

class CertificatesPage extends StatefulWidget {
  const CertificatesPage({super.key});

  @override
  State<CertificatesPage> createState() => _CertificatesPageState();
}

class _CertificatesPageState extends State<CertificatesPage> {
  // List to hold multiple certificate entries
  final List<Map<String, dynamic>> _certificateEntries = [];

  @override
  void initState() {
    super.initState();
    // Add the first certificate entry when the page initializes
    _addAnotherCertificateEntry();
  }

  // Method to add a new, empty certificate entry
  void _addAnotherCertificateEntry() {
    setState(() {
      _certificateEntries.add({
        'certificateCourseController': TextEditingController(),
        'numberController': TextEditingController(),
        'issuedPlaceController': TextEditingController(),
        'issuedByController': TextEditingController(),
        'dateOfIssueController': TextEditingController(),
        'dateOfExpiryController': TextEditingController(),
        'fileName': 'No file chosen',
      });
    });
  }

  // Method to remove a certificate entry by index
  void _removeCertificateEntry(int index) {
    setState(() {
      // Dispose controllers before removing to prevent memory leaks
      _certificateEntries[index]['certificateCourseController']?.dispose();
      _certificateEntries[index]['numberController']?.dispose();
      _certificateEntries[index]['issuedPlaceController']?.dispose();
      _certificateEntries[index]['issuedByController']?.dispose();
      _certificateEntries[index]['dateOfIssueController']?.dispose();
      _certificateEntries[index]['dateOfExpiryController']?.dispose();
      _certificateEntries.removeAt(index);
    });
  }

  Future<void> _selectDate(BuildContext context, TextEditingController controller) async {
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
      allowedExtensions: ['pdf'], // Only allow PDF files
    );

    if (result != null && result.files.single.name != null) {
      setState(() {
        _certificateEntries[index]['fileName'] = result.files.single.name!;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Selected file: ${_certificateEntries[index]['fileName']}')),
      );
    } else {
      setState(() {
        _certificateEntries[index]['fileName'] = 'No file chosen';
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('File selection canceled or failed.')),
      );
    }
  }

  // Method to handle saving all changes
  void _saveChanges() {
    print('Saving changes for all certificates:');
    for (var entry in _certificateEntries) {
      print('  Certificate/Course: ${entry['certificateCourseController'].text}');
      print('  Number: ${entry['numberController'].text}');
      print('  Issued Place: ${entry['issuedPlaceController'].text}');
      print('  Issued By: ${entry['issuedByController'].text}');
      print('  Date of Issue: ${entry['dateOfIssueController'].text}');
      print('  Date of Expiry: ${entry['dateOfExpiryController'].text}');
      print('  File Name: ${entry['fileName']}');
      print('---');
    }
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Changes saved successfully! (Simulated)')),
    );
  }

  @override
  void dispose() {
    for (var entry in _certificateEntries) {
      entry['certificateCourseController']?.dispose();
      entry['numberController']?.dispose();
      entry['issuedPlaceController']?.dispose();
      entry['issuedByController']?.dispose();
      entry['dateOfIssueController']?.dispose();
      entry['dateOfExpiryController']?.dispose();
    }
    super.dispose();
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
          'Certifications', // App bar title
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
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Dynamically generate certificate cards
            ..._certificateEntries.asMap().entries.map((entry) {
              final int index = entry.key;
              final Map<String, dynamic> certificate = entry.value;

              return Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: Card(
                  color: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                    side: BorderSide.none, // Removed card border
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
                              'Certificate/Course #${index + 1}', // Dynamic title
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                            if (_certificateEntries.length > 1)
                              IconButton(
                                icon: const Icon(Icons.close, color: Colors.red),
                                onPressed: () => _removeCertificateEntry(index),
                              ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        _buildLabeledTextField(
                          label: 'Certificate/Course (Optional)',
                          hintText: 'e.g., STCW Basic Safety Training, GMDSS, etc.',
                          controller: certificate['certificateCourseController'],
                        ),
                        const SizedBox(height: 16),
                        _buildLabeledTextField(
                          label: 'Number (Optional)',
                          hintText: 'Certificate number',
                          controller: certificate['numberController'],
                          keyboardType: TextInputType.text,
                        ),
                        const SizedBox(height: 16),
                        _buildLabeledTextField(
                          label: 'Issued Place (Optional)',
                          hintText: 'Place where certificate was issued',
                          controller: certificate['issuedPlaceController'],
                        ),
                        const SizedBox(height: 16),
                        _buildLabeledTextField(
                          label: 'Issued By (Institute) (Optional)',
                          hintText: 'Issuing institute or authority',
                          controller: certificate['issuedByController'],
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              child: _buildLabeledTextField(
                                label: 'Date of Issue (Optional)',
                                hintText: 'yyyy-mm-dd',
                                controller: certificate['dateOfIssueController'],
                                suffixIcon: Icons.calendar_today,
                                onSuffixIconTap: () => _selectDate(context, certificate['dateOfIssueController']),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: _buildLabeledTextField(
                                label: 'Date of Expiry (Optional)',
                                hintText: 'yyyy-mm-dd',
                                controller: certificate['dateOfExpiryController'],
                                suffixIcon: Icons.calendar_today,
                                onSuffixIconTap: () => _selectDate(context, certificate['dateOfExpiryController']),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        _buildFileUploadSection(index, certificate['fileName']),
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),

            Center(
              child: SizedBox( // Use SizedBox to control width
                width: buttonWidth,
                child: OutlinedButton.icon(
                  onPressed: _addAnotherCertificateEntry,
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.black87,
                    side: BorderSide(color: Colors.grey.shade300),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  ),
                  icon: const Icon(Icons.add, size: 20),
                  label: const Text(
                    'Add Another Certification',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Center(
              child: SizedBox( // Use SizedBox to control width
                width: buttonWidth,
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
            const SizedBox(height: 20),
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

  // This dropdown is not used in the certificates page based on the image,
  // but kept for completeness if needed elsewhere or for future changes.
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
          'Upload Certificate (PDF)', // Label as per image
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
          padding: const EdgeInsets.all(1.0),
          child: Row(
            children: [
              TextButton(
                onPressed: () => _chooseFile(index),
                style: TextButton.styleFrom(
                  backgroundColor: Colors.blue.shade50,
                  foregroundColor: Colors.blue.shade700,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                ),
                child: const Text('Choose file'),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  fileName,
                  style: TextStyle(color: Colors.grey.shade600),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
