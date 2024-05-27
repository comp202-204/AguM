import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Reservation Detail Page',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ReservationDetailPage(),
    );
  }
}

class ReservationDetailPage extends StatefulWidget {
  @override
  _ReservationDetailPageState createState() => _ReservationDetailPageState();
}

class _ReservationDetailPageState extends State<ReservationDetailPage> {
  DateTime? selectedDate;
  TimeOfDay? startTime;
  TimeOfDay? endTime;
  List<Map<String, String>> availableClasses = [];
  List<String> selectedClasses = [];
  bool isLoading = false;

  Future<void> _fetchAvailableClasses() async {
    if (selectedDate == null || startTime == null || endTime == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please select date, start time, and end time first!')),
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    final String formattedDate = "${selectedDate!.year}-${selectedDate!.month.toString().padLeft(2, '0')}-${selectedDate!.day.toString().padLeft(2, '0')}";
    final String formattedStartTime = "${startTime!.hour.toString().padLeft(2, '0')}:${startTime!.minute.toString().padLeft(2, '0')}:00";
    final String formattedEndTime = "${endTime!.hour.toString().padLeft(2, '0')}:${endTime!.minute.toString().padLeft(2, '0')}:00";

    try {
      var response = await http.get(
        Uri.parse('http://10.31.19.70/localconnect/getAvailableClasses.php?date=$formattedDate&start_time=$formattedStartTime&end_time=$formattedEndTime'),
      );

      if (response.statusCode == 200) {
        print(response.body); // Debug logging
        List<dynamic> data = json.decode(response.body);

        // Check if data is a list of strings or maps
        if (data.isNotEmpty && data.first is String) {
          // If data is a list of strings
          setState(() {
            availableClasses = data.map((item) => {'name': item.toString()}).toList();
          });
        } else {
          // If data is a list of maps
          setState(() {
            availableClasses = List<Map<String, String>>.from(data.map((item) => Map<String, String>.from(item)));
          });
        }

        if (availableClasses.isEmpty) {
          throw Exception('No available classes');
        }
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('$e')),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> _selectTime(BuildContext context, bool isStartTime) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: isStartTime ? (startTime ?? TimeOfDay.now()) : (endTime ?? TimeOfDay.now()),
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child!,
        );
      },
    );
    if (picked != null) {
      if (picked.minute == 0) {
        setState(() {
          if (isStartTime) {
            startTime = picked;
          } else {
            endTime = picked;
          }
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Please select a full hour (e.g., 12:00, 13:00, etc.)')),
        );
      }
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  Future<void> _makeReservation() async {
    if (selectedDate != null && startTime != null && endTime != null && selectedClasses.isNotEmpty) {
      try {
        final formattedDate =
            "${selectedDate!.year}-${selectedDate!.month.toString().padLeft(2, '0')}-${selectedDate!.day.toString().padLeft(2, '0')}";
        final formattedStartTime =
            "${startTime!.hour.toString().padLeft(2, '0')}:${startTime!.minute.toString().padLeft(2, '0')}:00";
        final formattedEndTime =
            "${endTime!.hour.toString().padLeft(2, '0')}:${endTime!.minute.toString().padLeft(2, '0')}:00";

        var response = await http.put(
          Uri.parse('http://10.31.19.70/localconnect/updateClassStatus.php'),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({
            'date': formattedDate,
            'start_time': formattedStartTime,
            'end_time': formattedEndTime,
            'classes': selectedClasses,
          }),
        );

        if (response.statusCode == 200) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Your reservation has been made successfully')),
          );
        } else {
          throw Exception('Failed to update class status');
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please select date, start time, end time, and at least one class!')),
      );
    }
  }

  Future<void> _navigateToAvailableClassesPage(BuildContext context) async {
    if (availableClasses.isNotEmpty) {
      final List<String>? selected = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AvailableClassesPage(
            availableClasses: availableClasses,
            selectedDate: selectedDate!,
            startTime: startTime!,
            endTime: endTime!,
          ),
        ),
      );
      if (selected != null && selected.isNotEmpty) {
        setState(() {
          selectedClasses = selected;
        });
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('No available classes to select!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Make a Reservation',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black12.withOpacity(0.81),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/photos/reservation.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.5),
                borderRadius: BorderRadius.circular(10.0),
              ),
              padding: EdgeInsets.all(20.0),
              child: ListView(
                children: <Widget>[
                  // Date selection widget
                  Container(
                    margin: EdgeInsets.only(bottom: 20.0),
                    padding: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Column(
                      children: [
                        Text(
                          'Select a Date',
                          style: TextStyle(fontSize: 20.0, color: Colors.white),
                        ),
                        ElevatedButton(
                          onPressed: () => _selectDate(context),
                          child: Text('Select Date', style: TextStyle(fontSize: 18.0, color: Colors.white)),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromRGBO(174, 32, 41, 1),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        ),
                        SizedBox(height: 20.0),
                        Text(
                          selectedDate == null ? 'No Date Chosen' : 'Selected Date: ${selectedDate!.toString().split(' ')[0]}',
                          style: TextStyle(fontSize: 18.0, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  // Start time selection widget
                  Container(
                    margin: EdgeInsets.only(bottom: 20.0),
                    padding: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Column(
                      children: [
                        Text(
                          'Select Start Time',
                          style: TextStyle(fontSize: 20.0, color: Colors.white),
                        ),
                        ElevatedButton(
                          onPressed: () => _selectTime(context, true),
                          child: Text('Select Start Time', style: TextStyle(fontSize: 18.0, color: Colors.white)),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromRGBO(174, 32, 41, 1),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        ),
                        SizedBox(height: 20.0),
                        Text(
                          startTime == null ? 'No Start Time Chosen' : 'Selected Start Time: ${startTime!.format(context)}',
                          style: TextStyle(fontSize: 18.0, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  // End time selection widget
                  Container(
                    margin: EdgeInsets.only(bottom: 20.0),
                    padding: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Column(
                      children: [
                        Text(
                          'Select End Time',
                          style: TextStyle(fontSize: 20.0, color: Colors.white),
                        ),
                        ElevatedButton(
                          onPressed: () => _selectTime(context, false),
                          child: Text('Select End Time', style: TextStyle(fontSize: 18.0, color: Colors.white)),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromRGBO(174, 32, 41, 1),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        ),
                        SizedBox(height: 20.0),
                        Text(
                          endTime == null ? 'No End Time Chosen' : 'Selected End Time: ${endTime!.format(context)}',
                          style: TextStyle(fontSize: 18.0, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  // Class selection button and display selected classes
                  Container(
                    margin: EdgeInsets.only(bottom: 20.0),
                    padding: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Column(
                      children: [
                        Text(
                          'Select a Class',
                          style: TextStyle(fontSize: 20.0, color: Colors.white),
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            await _fetchAvailableClasses();
                            await _navigateToAvailableClassesPage(context);
                          },
                          child: Text('Select Classes', style: TextStyle(fontSize: 18.0, color: Colors.white)),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromRGBO(174, 32, 41, 1),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        ),
                        SizedBox(height: 20.0),
                        Text(
                          selectedClasses.isEmpty ? 'No Classes Selected' : 'Selected Classes: ${selectedClasses.join(', ')}',
                          style: TextStyle(fontSize: 18.0, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  // Make reservation button
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 1,
                    ),
                    child: TextButton(
                      onPressed: _makeReservation,
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(174, 32, 41, 1),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Center(
                          child: Text(
                            'Make Reservation',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class AvailableClassesPage extends StatefulWidget {
  final List<Map<String, String>> availableClasses;
  final DateTime selectedDate;
  final TimeOfDay startTime;
  final TimeOfDay endTime;

  AvailableClassesPage({
    Key? key,
    required this.availableClasses,
    required this.selectedDate,
    required this.startTime,
    required this.endTime,
  }) : super(key: key);

  @override
  _AvailableClassesPageState createState() => _AvailableClassesPageState();
}

class _AvailableClassesPageState extends State<AvailableClassesPage> {
  List<String> selectedClasses = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Available Classes'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Selected Date: ${widget.selectedDate.toString().split(' ')[0]}',
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(height: 8),
                Text(
                  'Selected Time: ${widget.startTime.format(context)} - ${widget.endTime.format(context)}',
                  style: TextStyle(fontSize: 18),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: widget.availableClasses.length,
              itemBuilder: (context, index) {
                final classData = widget.availableClasses[index];
                final className = classData['name']!;
                final startTime = widget.startTime.format(context);
                final endTime = widget.endTime.format(context);
                return ListTile(
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(className),
                      SizedBox(height: 4),
                      Text("Start Time: $startTime, End Time: $endTime"),
                    ],
                  ),
                  trailing: Checkbox(
                    value: selectedClasses.contains(className),
                    onChanged: (bool? value) {
                      setState(() {
                        if (value == true) {
                          selectedClasses.add(className);
                        } else {
                          selectedClasses.remove(className);
                        }
                      });
                    },
                  ),
                );
              },
            ),
          ),
          Container(
            padding: EdgeInsets.all(16),
            color: Colors.grey[200],
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Selected Classes: ${selectedClasses.length}',
                  style: TextStyle(fontSize: 16),
                ),
                ElevatedButton(
                  onPressed: selectedClasses.isEmpty
                      ? null
                      : () {
                    Navigator.pop(context, selectedClasses);
                  },
                  child: Text('Confirm Selection', style: TextStyle(color: Colors.white)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: selectedClasses.isEmpty ? Colors.black54 : Colors.deepPurple,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

