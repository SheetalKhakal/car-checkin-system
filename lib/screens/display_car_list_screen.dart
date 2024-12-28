// ignore_for_file: prefer_const_constructors, library_private_types_in_public_api, use_key_in_widget_constructors

import 'package:car_checkin_system/database/database_helper.dart';
import 'package:flutter/material.dart';

class CarsListScreen extends StatefulWidget {
  @override
  _CarsListScreenState createState() => _CarsListScreenState();
}

class _CarsListScreenState extends State<CarsListScreen> {
  late Future<List<Map<String, dynamic>>> _carsFuture;
  bool _isAscending = true;

  @override
  void initState() {
    super.initState();
    _fetchCars();
  }

  void _fetchCars() {
    _carsFuture =
        DatabaseHelper().getUncheckedOutCarsSorted(ascending: _isAscending);
  }

  void _sortAscending() {
    setState(() {
      _isAscending = true;
      _fetchCars();
    });
  }

  void _sortDescending() {
    setState(() {
      _isAscending = false;
      _fetchCars();
    });
  }

  void _checkOutCar(String carNumber) async {
    await DatabaseHelper().checkOutCar(carNumber, DateTime.now());
    setState(() {
      _fetchCars();
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Car checked out successfully!',
          style: TextStyle(fontSize: 16.0, color: Colors.green),
        ),
        backgroundColor: Colors.blue[50],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cars Not Checked Out'),
        actions: [
          PopupMenuButton<String>(
            onSelected: (String value) {
              if (value == 'Ascending') {
                _sortAscending();
              } else if (value == 'Descending') {
                _sortDescending();
              }
            },
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem(
                  value: 'Ascending',
                  child: Text('Sort Ascending'),
                ),
                PopupMenuItem(
                  value: 'Descending',
                  child: Text('Sort Descending'),
                ),
              ];
            },
          ),
        ],
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _carsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.data == null || snapshot.data!.isEmpty) {
            return Center(child: Text('No cars found.'));
          } else {
            final cars = snapshot.data!;
            return ListView.builder(
              itemCount: cars.length,
              itemBuilder: (context, index) {
                final car = cars[index];
                return Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 0.5),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                  child: ListTile(
                    title: Text(car['carNumber']),
                    subtitle: Text('Checked in at: ${car['checkInTime']}'),
                    trailing: ElevatedButton(
                      onPressed: () => _checkOutCar(car['carNumber']),
                      child: Text('Check Out'),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
