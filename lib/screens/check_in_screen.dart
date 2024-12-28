// ignore_for_file: prefer_const_constructors, library_private_types_in_public_api, use_key_in_widget_constructors

import 'package:car_checkin_system/database/database_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CheckInScreen extends StatefulWidget {
  @override
  _CheckInScreenState createState() => _CheckInScreenState();
}

class _CheckInScreenState extends State<CheckInScreen> {
  final _carNumberController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void _checkInCar() async {
    if (_formKey.currentState?.validate() ?? false) {
      try {
        String carNumber = _carNumberController.text.trim().toUpperCase();
        await DatabaseHelper().checkInCar(carNumber, DateTime.now());

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Car checked in successfully!',
              style: TextStyle(fontSize: 16.0, color: Colors.green),
            ),
            backgroundColor: Colors.blue[50],
          ),
        );
        _carNumberController.clear();
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Error: $e',
              style: TextStyle(fontSize: 16.0, color: Colors.red),
            ),
            backgroundColor: Colors.blue[50],
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Car Check-In')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(
                height: 50,
              ),
              TextFormField(
                controller: _carNumberController,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9]')),
                ],
                decoration: InputDecoration(
                  labelText: 'Car Number (e.g., AN01AB0123)',
                  labelStyle:
                      TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  errorStyle: TextStyle(fontSize: 16.0, color: Colors.red),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Car number cannot be empty';
                  }

                  if (!RegExp(r'^[a-zA-Z]{2}[0-9]{2}[a-zA-Z0-9]{1,6}$')
                      .hasMatch(value.trim())) {
                    return 'Enter a valid car number (e.g., AN01AB0123)';
                  }
                  return null;
                },
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: _checkInCar,
                child: Text('Check In'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
