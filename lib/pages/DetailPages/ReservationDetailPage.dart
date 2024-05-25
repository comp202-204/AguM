import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ReservationDetailPage extends StatefulWidget {
  @override
  _ReservationDetailPageState createState() => _ReservationDetailPageState();
}

class _ReservationDetailPageState extends State<ReservationDetailPage> {
  DateTime? selectedDate;
  TimeOfDay? startTime;
  TimeOfDay? endTime;
  List<String> availableClasses = [];
  bool isLoading = false;
  String? selectedClassName;

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

    final String formattedDate = "${selectedDate!.year}-${selectedDate!.month}-${selectedDate!.day}";
    final String formattedStartTime = "${startTime!.hour}:${startTime!.minute}";
    final String formattedEndTime = "${endTime!.hour}:${endTime!.minute}";

    try {
      var response = await http.get(
        Uri.parse('http://10.32.1.15/localconnect/getAvailableClasses.php?date=$formattedDate&start_time=$formattedStartTime&end_time=$formattedEndTime'),
      );

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        availableClasses = List<String>.from(data.map((item) => item.toString()));
        if (availableClasses.isEmpty) {
          throw Exception('No available classes');
        }
        final selectedClasses = await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AvailableClassesPage(availableClasses: availableClasses),
          ),
        );
        if (selectedClasses != null && selectedClasses.isNotEmpty) {
          setState(() {
            selectedClassName = selectedClasses.join(', ');
          });
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
    if (selectedDate != null &&
        startTime != null &&
        endTime != null) {
      try {
        final formattedDate =
            "${selectedDate!.year}-${selectedDate!.month.toString().padLeft(2, '0')}-${selectedDate!.day.toString().padLeft(2, '0')}";
        final formattedStartTime =
            "${startTime!.hour.toString().padLeft(2, '0')}:${startTime!.minute.toString().padLeft(2, '0')}:00";
        final formattedEndTime =
            "${endTime!.hour.toString().padLeft(2, '0')}:${endTime!.minute.toString().padLeft(2, '0')}:00";

        print('Formatted Date: $formattedDate');
        print('Formatted Start Time: $formattedStartTime');
        print('Formatted End Time: $formattedEndTime');

        var response = await http.put(
          Uri.parse('http://10.32.1.15/localconnect/updateClassStatus.php'),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({
            'date': formattedDate,
            'start_time': formattedStartTime,
            'end_time': formattedEndTime
          }),
        );

        print('Response status code: ${response.statusCode}');
        print('Response body: ${response.body}');

        if (response.statusCode == 200) {
          // Başarılı yanıt durumunda
          setState(() {});
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Class status updated successfully')),
          );
        } else {
          // Hatalı yanıt durumunda
          throw Exception('Failed to update class status');
        }
      } catch (e) {
        // Hata durumunda
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    } else {
      // Eksik bilgi durumunda
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please select date, start time, and end time first!')),
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
                  // Class selection button and display selected class
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
                          onPressed: () => _fetchAvailableClasses(),
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
                          selectedClassName == null ? 'No Class Selected' : 'Selected Class: $selectedClassName',
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
  final List<String> availableClasses;

  AvailableClassesPage({Key? key, required this.availableClasses}) : super(key: key);

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
          Expanded(
            child: ListView.builder(
              itemCount: widget.availableClasses.length,
              itemBuilder: (context, index) {
                final className = widget.availableClasses[index];
                return ListTile(
                  title: Text(className),
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
                  child: Text('Confirm Selection'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple.shade100,
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
