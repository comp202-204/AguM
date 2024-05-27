import 'package:comp202/pages/homescreen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';

class EventCreatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Events App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: EventControllerPage(),
      debugShowCheckedModeBanner: false, // This line removes the debug banner
    );
  }
}

class EventControllerPage extends StatefulWidget {
  @override
  _EventControllerPageState createState() => _EventControllerPageState();
}

class _EventControllerPageState extends State<EventControllerPage> {
  final String createEventUrl = 'http://10.31.19.70/localconnect/create_event.php';
  final String getEventsUrl = 'http://10.31.19.70/localconnect/get_events.php';

  final TextEditingController _eventNameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _dateTimeController = TextEditingController();

  List _events = [];

  final format = DateFormat("yyyy-MM-dd HH:mm:ss");

  @override
  void initState() {
    super.initState();
    _fetchEvents();
  }

  Future<void> _fetchEvents() async {
    final response = await http.get(Uri.parse(getEventsUrl));
    if (response.statusCode == 200) {
      setState(() {
        _events = json.decode(response.body);
      });
    } else {
      throw Exception('Failed to load events');
    }
  }

  Future<void> addEvent() async {
    final String eventName = _eventNameController.text;
    final String description = _descriptionController.text;
    final String dateTime = _dateTimeController.text;

    final response = await http.post(
      Uri.parse(createEventUrl),
      body: {
        'event_name': eventName,
        'description': description,
        'data_time': dateTime,
      },
    );

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      if (responseData['success']) {
        _fetchEvents();
        _eventNameController.clear();
        _descriptionController.clear();
        _dateTimeController.clear();
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Event created successfully')));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(responseData['message'])));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to create event')));
      throw Exception('Failed to create event');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Event Controller'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => HomeScreen()),
                  (route) => false,
            );
          },
        ),
      ),
      body: Row(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              padding: EdgeInsets.all(16.0),
              color: Colors.grey[200],
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Create New Event',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  TextField(
                    controller: _eventNameController,
                    decoration: InputDecoration(labelText: 'Event Name'),
                  ),
                  TextField(
                    controller: _descriptionController,
                    decoration: InputDecoration(labelText: 'Description'),
                  ),
                  DateTimeField(
                    controller: _dateTimeController,
                    format: format,
                    decoration: InputDecoration(labelText: 'Date Time'),
                    onShowPicker: (context, currentValue) async {
                      final date = await showDatePicker(
                        context: context,
                        firstDate: DateTime(1900),
                        initialDate: currentValue ?? DateTime.now(),
                        lastDate: DateTime(2100),
                      );
                      if (date != null) {
                        final time = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.fromDateTime(
                              currentValue ?? DateTime.now()),
                        );
                        return DateTimeField.combine(date, time);
                      } else {
                        return currentValue;
                      }
                    },
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: addEvent,
                    child: Text('Create Event'),
                  ),
                ],
              ),
            ),
          ),
          VerticalDivider(width: 1),
          Expanded(
            flex: 2,
            child: Container(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Recorded Events',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                Expanded(
                  child: ListView.builder(
                    itemCount: _events.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(_events[index]['event_name'], style: TextStyle(fontWeight: FontWeight.bold)),
                            Text(_events[index]['description']),
                            Text(_events[index]['data_time'], style: TextStyle(color: Colors.grey)),
                          ],
                        ),
                      );
                    },
                  ),
                )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
