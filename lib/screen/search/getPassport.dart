import 'package:flutter/material.dart';
import 'package:mainalihr/utility/ApiPassportController.dart';
import 'package:mainalihr/model/record.dart'; // Ensure this imports the correct Record model

class RecordView extends StatefulWidget {
  const RecordView({super.key});

  @override
  _RecordViewState createState() => _RecordViewState();
}

class _RecordViewState extends State<RecordView> {
  final TextEditingController _passportController = TextEditingController();
  final ApiPassportController _apiController = ApiPassportController();
  Record? _record;
  String? _message;

  void _fetchRecord() async {
    final passportNumber = _passportController.text.trim();
    if (passportNumber.isEmpty) {
      setState(() {
        _message = 'Please enter a passport number.';
        _record = null;
      });
      return;
    }

    final response = await _apiController.searchByPassportNumber(passportNumber);
    
    setState(() {
      if (response['message'] != null) {
        _message = response['message'];
        _record = null;
      } else {
        _record = Record.fromJson(response); // Assuming you have a method to create a Record from JSON
        _message = null; // Clear any previous messages
      }
    });
  }

  String _getValueOrMessage(String? value) {
    return value ?? 'No data found';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Record Viewer')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _passportController,
              decoration: InputDecoration(labelText: 'Enter Passport Number'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _fetchRecord,
              child: Text('Fetch Record'),
            ),
            SizedBox(height: 20),
            if (_message != null) // Show message if any
              Text(
                _message!,
                style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
              ),
            if (_record != null) // Show record details
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Name: ${_getValueOrMessage(_record!.name)}'),
                  Text('Passport Number: ${_getValueOrMessage(_record!.passportNumber)}'),
                     Text('Country: ${_getValueOrMessage(_record!.country)}'),
                  Text('Project: ${_getValueOrMessage(_record!.project)}'),
                  Text('Interview Date: ${_getValueOrMessage(_record!.interviewDate)}'),
                  Text('Offer Letter: ${_getValueOrMessage(_record!.offerLetter)}'),
                  Text('Remark: ${_getValueOrMessage(_record!.remark)}'),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
