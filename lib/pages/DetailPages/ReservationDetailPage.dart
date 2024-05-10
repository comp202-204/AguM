import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ReservationDetailPage extends StatefulWidget {
  @override
  _ReservationDetailPageState createState() => _ReservationDetailPageState();
}

class _ReservationDetailPageState extends State<ReservationDetailPage> {
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  List<String> availableClasses = [];
  bool isLoading = false; // To indicate loading status
  String? selectedClassName;  // For storing the selected class name

  Future<void> _fetchAvailableClasses() async {
    if (selectedDate == null || selectedTime == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please select both date and time first!')),
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    final String formattedDate = "${selectedDate!.year}-${selectedDate!.month}-${selectedDate!.day}";
    final String formattedTime = "${selectedTime!.hour}:${selectedTime!.minute}";

    try {
      var response = await http.get(
        Uri.parse('http://10.34.15.110/localconnect/getAvailableClasses.php?date=$formattedDate&time=$formattedTime'),
      );

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        availableClasses = List<String>.from(data.map((item) => item.toString()));
        final selectedClass = await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AvailableClassesPage(availableClasses: availableClasses),
          ),
        );
        if (selectedClass != null) {
          setState(() {
            selectedClassName = selectedClass;  // Store the selected class
          });
        }
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('No Available Classes')),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime ?? TimeOfDay.now(),
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child!,
        );
      },
    );
    if (picked != null && picked != selectedTime) {
      // Check if the selected time is a full hour (minute is 0)
      if (picked.minute == 0) {
        setState(() {
          selectedTime = picked;
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
    if (selectedClassName != null && selectedDate != null && selectedTime != null) {
      try {
        final formattedDate = "${selectedDate!.year}-${selectedDate!.month}-${selectedDate!.day}";
        final formattedTime = "${selectedTime!.hour}:${selectedTime!.minute}";

        var response = await http.put(
          Uri.parse('http://10.34.15.110/localconnect/updateClassStatus.php'),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({'class_name': selectedClassName, 'class_status': 'NotAvailable', 'date': formattedDate, 'time': formattedTime}),
        );

        if (response.statusCode == 200) {
          setState(() {
            selectedClassName = selectedClassName!.replaceFirst('Available', 'NotAvailable');
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Reservation made for class: $selectedClassName')),
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
        SnackBar(content: Text('Please select a class, date, and time first!')),
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
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
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
                    // Time selection widget
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
                            'Select a Time',
                            style: TextStyle(fontSize: 20.0, color: Colors.white),
                          ),
                          ElevatedButton(
                            onPressed: () => _selectTime(context),
                            child: Text('Select Time', style: TextStyle(fontSize: 18.0, color: Colors.white)),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color.fromRGBO(174, 32, 41, 1),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                          ),
                          SizedBox(height: 20.0),
                          Text(
                            selectedTime == null ? 'No Time Chosen' : 'Selected Time: ${selectedTime!.format(context)}',
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
      ),
    );
  }
}

class AvailableClassesPage extends StatelessWidget {
  final List<String> availableClasses;

  AvailableClassesPage({Key? key, required this.availableClasses}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Available Classes'),
        backgroundColor: Colors.deepPurple,
      ),
      body: ListView.builder(
        itemCount: availableClasses.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              title: Text(availableClasses[index]),
              onTap: () {
                // When tapped, pop back with the selected class
                Navigator.pop(context, availableClasses[index]);
              },
            ),
          );
        },
      ),
    );
  }
}
