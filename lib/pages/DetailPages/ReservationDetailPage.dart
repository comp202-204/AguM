  import 'package:flutter/material.dart';
  import 'package:comp202/pages/DetailPages/CampusMapDetailPage.dart';

  class ReservationDetailPage extends StatefulWidget {
    @override
    _ReservationDetailPageState createState() => _ReservationDetailPageState();
  }

  class _ReservationDetailPageState extends State<ReservationDetailPage> {
    DateTime? selectedDate;
    TimeOfDay? selectedTime;

    Future<void> _selectClasses(BuildContext context) async {

       Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CampusMapDetailPage(),
            ),
          );
      }
    Future<void> _selectDate(BuildContext context) async {
      final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 365)),
      );
      if (picked != null && picked != selectedDate) {
        setState(() {
          selectedDate = picked;
        });
      }
    }

    Future<void> _selectTime(BuildContext context) async {
      final TimeOfDay? picked = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );
      if (picked != null && picked != selectedTime) {
        setState(() {
          selectedTime = picked;
        });
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
              image: AssetImage('assets/photos/rezervation.jpg'),
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      'Select the date and time you want to make a reservation',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 20.0),
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
                              backgroundColor: Color.fromRGBO(174, 32, 41, 1), // Buton rengi
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                          ),
                          SizedBox(height: 20.0),
                          selectedDate == null
                              ? Container(height: 18.0)
                              : SizedBox(
                            height: 24.0,
                            child: Text(
                              'Selected Date: ${selectedDate.toString().split(' ')[0]}',
                              style: TextStyle(fontSize: 18.0, color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
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
                          selectedTime == null
                              ? Container(height: 18.0)
                              : SizedBox(
                            height: 24.0,
                            child: Text(
                              'Selected Time: ${selectedTime!.format(context)}',
                              style: TextStyle(fontSize: 18.0, color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container( //Select Available Classes..
                      margin: EdgeInsets.only(bottom: 20.0),
                      padding: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Column(
                        children: [
                          Text(
                            'Select a Classes',
                            style: TextStyle(fontSize: 20.0, color: Colors.white),
                          ),
                          ElevatedButton(
                            onPressed: () => _selectClasses(context), // _selectClasses
                            child: Text('Select Classes', style: TextStyle(fontSize: 18.0, color: Colors.white)),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color.fromRGBO(174, 32, 41, 1), // Buton rengi
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                          ),
                          SizedBox(height: 20.0),
                          selectedDate == null
                              ? Container(height: 18.0)
                              : SizedBox(
                            height: 24.0,
                            child: Text(
                              'Selected Classes: ${selectedDate.toString().split(' ')[0]}',
                              style: TextStyle(fontSize: 18.0, color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 1,
                      ),
                      child: TextButton(
                        onPressed: () {
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
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
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(174, 32, 41, 1),
                            borderRadius: BorderRadius.circular(10.0),
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
