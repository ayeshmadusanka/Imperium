import 'package:flutter/material.dart';

class JobListPage extends StatefulWidget {
  const JobListPage({Key? key}) : super(key: key);

  @override
  _JobListPageState createState() => _JobListPageState();
}

class _JobListPageState extends State<JobListPage> {
  String? selectedRank;
  String? selectedVesselType;
  String? selectedMonth;

  final List<String> ranks = ['Captain', 'Deck Crew', 'Engineer', 'Cook', 'Medic'];
  final List<String> vesselTypes = ['Cargo Ship', 'Cruise Ship', 'Oil Tanker', 'Fishing Vessel', 'Research Vessel'];
  final List<String> months = ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Job Listings",
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
                  // Rank Filter
                  Container(
                    width: 90, // Reduced width
                    child: DropdownButton<String>(
                      value: selectedRank,
                      hint: const Text('Rank'),
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedRank = newValue;
                        });
                      },
                      items: ranks.map<DropdownMenuItem<String>>((String value) {
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
                  const SizedBox(width: 16),  // Adjusted space between filters

                  // Vessel Type Filter
                  Container(
                    width: 140, // Increased width to fix overflow
                    child: DropdownButton<String>(
                      value: selectedVesselType,
                      hint: const Text('Vessel Type'),
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedVesselType = newValue;
                        });
                      },
                      items: vesselTypes.map<DropdownMenuItem<String>>((String value) {
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
                  const SizedBox(width: 32),  // Increased space between Vessel Type and Month

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

            // Job Tiles
            Expanded(
              child: ListView(
                children: [
                  // Job 1
                  JobTile(
                    rank: 'Captain',
                    vesselType: 'Cargo Ship',
                    joiningDate: '01/05/2020',
                  ),
                  // Job 2
                  JobTile(
                    rank: 'Deck Crew',
                    vesselType: 'Cruise Ship',
                    joiningDate: '15/07/2021',
                  ),
                  // Job 3
                  JobTile(
                    rank: 'Engineer',
                    vesselType: 'Oil Tanker',
                    joiningDate: '20/11/2019',
                  ),
                  // Job 4
                  JobTile(
                    rank: 'Cook',
                    vesselType: 'Fishing Vessel',
                    joiningDate: '02/03/2022',
                  ),
                  // Job 5
                  JobTile(
                    rank: 'Medic',
                    vesselType: 'Research Vessel',
                    joiningDate: '10/01/2018',
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

class JobTile extends StatelessWidget {
  final String rank;
  final String vesselType;
  final String joiningDate;

  const JobTile({
    Key? key,
    required this.rank,
    required this.vesselType,
    required this.joiningDate,
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
          rank,
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
              'Vessel Type: $vesselType',
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black87,
              ),
            ),
            Text(
              'Date of Joining: $joiningDate',
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
