import 'package:flutter/material.dart';
import 'course_details.dart';

class CourseListPage extends StatefulWidget {
  const CourseListPage({Key? key}) : super(key: key);

  @override
  _CourseListPageState createState() => _CourseListPageState();
}

class _CourseListPageState extends State<CourseListPage> {
  String? selectedInstitute;
  String? selectedDuration;
  String? selectedMonth;

  final List<String> institutes = ['Institute A', 'Institute B', 'Institute C', 'Institute D', 'Institute E'];
  final List<String> durations = ['3 months', '6 months', '1 year', '2 years'];
  final List<String> months = ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Course Listings",
          style: TextStyle(
            color: Colors.white, // Set the text color to white
          ),
        ),
        backgroundColor: Colors.blue.shade900,
        foregroundColor: Colors.white, // Set the icon color to white
        centerTitle: true, // Center the title
      ),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Filter Section
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  // Institute Filter
                  Container(
                    width: 130, // Adjust the width to fit longer text
                    child: DropdownButton<String>(
                      value: selectedInstitute,
                      hint: const Text('Institute'),
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedInstitute = newValue;
                        });
                      },
                      items: institutes.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: TextStyle(fontSize: 12), // Reduced text size
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  const SizedBox(width: 16),  // Space between filters

                  // Duration Filter
                  Container(
                    width: 120, // Adjusted width
                    child: DropdownButton<String>(
                      value: selectedDuration,
                      hint: const Text('Duration'),
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedDuration = newValue;
                        });
                      },
                      items: durations.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: TextStyle(fontSize: 12), // Reduced text size
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  const SizedBox(width: 32),  // Space between Duration and Month

                  // Month Filter
                  Container(
                    width: 90, // Reduced width
                    child: DropdownButton<String>(
                      value: selectedMonth,
                      hint: const Text('Month'),
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedMonth = newValue;
                        });
                      },
                      items: months.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: TextStyle(fontSize: 12), // Reduced text size
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Course Tiles
            Expanded(
              child: ListView(
                children: [
                  // Course 1
                  CourseTile(
                    courseName: 'Course 1',
                    institute: 'Institute A',
                    duration: '1 year',
                    startingDate: '01/05/2025',
                  ),
                  // Course 2
                  CourseTile(
                    courseName: 'Course 2',
                    institute: 'Institute B',
                    duration: '6 months',
                    startingDate: '15/07/2025',
                  ),
                  // Course 3
                  CourseTile(
                    courseName: 'Course 3',
                    institute: 'Institute C',
                    duration: '2 years',
                    startingDate: '20/11/2025',
                  ),
                  // Course 4
                  CourseTile(
                    courseName: 'Course 4',
                    institute: 'Institute D',
                    duration: '6 months',
                    startingDate: '02/03/2025',
                  ),
                  // Course 5
                  CourseTile(
                    courseName: 'Course 5',
                    institute: 'Institute E',
                    duration: '1 year',
                    startingDate: '10/01/2025',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CourseTile extends StatelessWidget {
  final String courseName;
  final String institute;
  final String duration;
  final String startingDate;

  const CourseTile({
    Key? key,
    required this.courseName,
    required this.institute,
    required this.duration,
    required this.startingDate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16.0),
      elevation: 5.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      color: Colors.white, // Set the background color to white
      child: ListTile(
        contentPadding: const EdgeInsets.all(16.0),
        title: Text(
          courseName,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Institute: $institute',
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black87,
              ),
            ),
            Text(
              'Duration: $duration',
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black87,
              ),
            ),
            Text(
              'Starting Date: $startingDate',
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black87,
              ),
            ),
          ],
        ),
        onTap: () {
          // Navigate to CourseDetailsPage
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CourseDetailsPage(),),
          );
        },
      ),
    );
  }
}
