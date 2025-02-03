import 'package:flutter/material.dart';

class JobApplicationPage extends StatefulWidget {
  const JobApplicationPage({Key? key}) : super(key: key);

  @override
  _JobApplicationPageState createState() => _JobApplicationPageState();
}

class _JobApplicationPageState extends State<JobApplicationPage> {
  final _formKey = GlobalKey<FormState>();

  // Controllers for form fields
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _rankController = TextEditingController();
  final TextEditingController _experienceController = TextEditingController();
  final TextEditingController _wagesController = TextEditingController();
  final TextEditingController _contactNumber1Controller = TextEditingController();
  final TextEditingController _contactNumber2Controller = TextEditingController();

  @override
  void dispose() {
    _fullNameController.dispose();
    _ageController.dispose();
    _rankController.dispose();
    _experienceController.dispose();
    _wagesController.dispose();
    _contactNumber1Controller.dispose();
    _contactNumber2Controller.dispose();
    super.dispose();
  }

  void _submitApplication() {
    if (_formKey.currentState?.validate() ?? false) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Submitting Application...')),
      );

      _fullNameController.clear();
      _ageController.clear();
      _rankController.clear();
      _experienceController.clear();
      _wagesController.clear();
      _contactNumber1Controller.clear();
      _contactNumber2Controller.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Job Application Form"),
        backgroundColor: Colors.blue.shade900,
        centerTitle: true,
        foregroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Card(
                elevation: 5,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        // Full Name
                        TextFormField(
                          controller: _fullNameController,
                          decoration: InputDecoration(
                            labelText: 'Full Name',
                            prefixIcon: Icon(Icons.person, color: Colors.blue.shade900),
                            labelStyle: TextStyle(color: Colors.blue.shade900),
                          ),
                          validator: (value) => value == null || value.isEmpty ? 'Please enter your full name' : null,
                        ),
                        const SizedBox(height: 10),

                        // Age
                        TextFormField(
                          controller: _ageController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: 'Age',
                            prefixIcon: Icon(Icons.calendar_today, color: Colors.blue.shade900),
                            labelStyle: TextStyle(color: Colors.blue.shade900),
                          ),
                          validator: (value) => value == null || value.isEmpty ? 'Please enter your age' : null,
                        ),
                        const SizedBox(height: 10),

                        // Rank Applied For
                        TextFormField(
                          controller: _rankController,
                          decoration: InputDecoration(
                            labelText: 'Rank Applied For',
                            prefixIcon: Icon(Icons.work, color: Colors.blue.shade900),
                            labelStyle: TextStyle(color: Colors.blue.shade900),
                          ),
                          validator: (value) => value == null || value.isEmpty ? 'Please enter the rank applied for' : null,
                        ),
                        const SizedBox(height: 10),

                        // Total Experience
                        TextFormField(
                          controller: _experienceController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: 'Total Experience',
                            prefixIcon: Icon(Icons.history, color: Colors.blue.shade900),
                            labelStyle: TextStyle(color: Colors.blue.shade900),
                          ),
                          validator: (value) => value == null || value.isEmpty ? 'Please enter your total experience in months' : null,
                        ),
                        const SizedBox(height: 10),

                        // Expected Wages
                        TextFormField(
                          controller: _wagesController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: 'Expected Wages (USD)',
                            prefixIcon: Icon(Icons.monetization_on, color: Colors.blue.shade900),
                            labelStyle: TextStyle(color: Colors.blue.shade900),
                          ),
                          validator: (value) => value == null || value.isEmpty ? 'Please enter your expected wages' : null,
                        ),
                        const SizedBox(height: 10),

                        // Contact Number 1
                        TextFormField(
                          controller: _contactNumber1Controller,
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            labelText: 'Contact Number 1',
                            prefixIcon: Icon(Icons.phone, color: Colors.blue.shade900),
                            labelStyle: TextStyle(color: Colors.blue.shade900),
                          ),
                          validator: (value) => value == null || value.isEmpty ? 'Please enter your contact number' : null,
                        ),
                        const SizedBox(height: 10),

                        // Contact Number 2
                        TextFormField(
                          controller: _contactNumber2Controller,
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            labelText: 'Contact Number 2',
                            prefixIcon: Icon(Icons.phone, color: Colors.blue.shade900),
                            labelStyle: TextStyle(color: Colors.blue.shade900),
                          ),
                          validator: (value) => value == null || value.isEmpty ? 'Please enter your second contact number' : null,
                        ),
                        const SizedBox(height: 15),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 30),

              // Submit Button
              ElevatedButton(
                onPressed: _submitApplication,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue.shade900,
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 100),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                ),
                child: const Text(
                  "Submit Application",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
