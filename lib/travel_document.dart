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
      title: 'Travel Documents Form', // Changed title
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: 'Inter', // Assuming 'Inter' font is available or default system font
      ),
      home: const TravelDocumentsPage(), // Changed home page
    );
  }
}

class TravelDocumentsPage extends StatefulWidget { // New class name
  const TravelDocumentsPage({super.key});

  @override
  State<TravelDocumentsPage> createState() => _TravelDocumentsPageState(); // New state class
}

class _TravelDocumentsPageState extends State<TravelDocumentsPage> { // New state class
  // List to hold multiple document entries
  final List<Map<String, dynamic>> _documentEntries = [];

  @override
  void initState() {
    super.initState();
    // Add the first document entry when the page initializes
    _addAnotherDocumentEntry();
  }

  // Method to add a new, empty document entry
  void _addAnotherDocumentEntry() {
    setState(() {
      _documentEntries.add({
        'documentType': null, // String? for dropdown
        'documentNumberController': TextEditingController(),
        'issuedCountry': null, // String? for dropdown
        'dateOfIssueController': TextEditingController(),
        'dateOfExpiryController': TextEditingController(),
        'fileName': 'No file chosen', // String for file upload
      });
    });
  }

  // Method to remove a document entry by index
  void _removeDocumentEntry(int index) {
    setState(() {
      // Dispose controllers before removing to prevent memory leaks
      _documentEntries[index]['documentNumberController']?.dispose();
      _documentEntries[index]['dateOfIssueController']?.dispose();
      _documentEntries[index]['dateOfExpiryController']?.dispose();
      _documentEntries.removeAt(index);
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
        _documentEntries[index]['fileName'] = result.files.single.name!;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Selected file: ${_documentEntries[index]['fileName']}')),
      );
    } else {
      setState(() {
        _documentEntries[index]['fileName'] = 'No file chosen';
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('File selection canceled or failed.')),
      );
    }
  }

  // Method to handle saving all changes
  void _saveChanges() {
    print('Saving changes for all documents:');
    for (var entry in _documentEntries) {
      print('  Document Type: ${entry['documentType']}');
      print('  Document Number: ${entry['documentNumberController'].text}');
      print('  Issued Country: ${entry['issuedCountry']}');
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
    for (var entry in _documentEntries) {
      entry['documentNumberController']?.dispose();
      entry['dateOfIssueController']?.dispose();
      entry['dateOfExpiryController']?.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double buttonWidth = MediaQuery.of(context).size.width * 0.7; // Define a consistent width for both buttons

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue.shade900,
        elevation: 0,
        title: const Text(
          'Travel Documents', // Changed app bar title
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
            // Dynamically generate document cards
            ..._documentEntries.asMap().entries.map((entry) {
              final int index = entry.key;
              final Map<String, dynamic> document = entry.value;

              return Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: Card(
                  color: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                    side: BorderSide.none,
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
                              'Document #${index + 1}',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                            if (_documentEntries.length > 1)
                              IconButton(
                                icon: const Icon(Icons.close, color: Colors.red),
                                onPressed: () => _removeDocumentEntry(index),
                              ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        _buildLabeledDropdown(
                          label: 'Document Type *',
                          hintText: 'Select document type',
                          value: document['documentType'],
                          items: const ['Passport', 'Visa', 'Seaman\'s Book', 'COC', 'COP', 'National ID'], // Example document types
                          onChanged: (String? newValue) {
                            setState(() {
                              document['documentType'] = newValue;
                            });
                          },
                        ),
                        const SizedBox(height: 16),
                        _buildLabeledTextField(
                          label: 'Number *',
                          hintText: 'Document number',
                          controller: document['documentNumberController'],
                          keyboardType: TextInputType.text,
                        ),
                        const SizedBox(height: 16),
                        _buildLabeledDropdown(
                          label: 'Issued Country *',
                          hintText: 'Select country',
                          value: document['issuedCountry'],
                          items: const ['USA', 'India', 'UK', 'Philippines', 'Other'], // Example countries
                          onChanged: (String? newValue) {
                            setState(() {
                              document['issuedCountry'] = newValue;
                            });
                          },
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              child: _buildLabeledTextField(
                                label: 'Date of Issue *',
                                hintText: 'yyyy-mm-dd',
                                controller: document['dateOfIssueController'],
                                suffixIcon: Icons.calendar_today,
                                onSuffixIconTap: () => _selectDate(context, document['dateOfIssueController']),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: _buildLabeledTextField(
                                label: 'Date of Expiry *',
                                hintText: 'yyyy-mm-dd',
                                controller: document['dateOfExpiryController'],
                                suffixIcon: Icons.calendar_today,
                                onSuffixIconTap: () => _selectDate(context, document['dateOfExpiryController']),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        _buildFileUploadSection(index, document['fileName']),
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),

            Center(
              child: SizedBox( // Added SizedBox to control width
                width: buttonWidth, // Apply consistent width
                child: OutlinedButton.icon(
                  onPressed: _addAnotherDocumentEntry,
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.black87,
                    side: BorderSide(color: Colors.grey.shade300),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12), // Consistent padding
                  ),
                  icon: const Icon(Icons.add, size: 20),
                  label: const Text(
                    'Add Another Document',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Center(
              child: SizedBox(
                width: buttonWidth, // Apply consistent width
                child: ElevatedButton(
                  onPressed: _saveChanges,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue.shade900,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12), // Consistent padding
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
          'Upload Document (PDF)', // Changed label
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
