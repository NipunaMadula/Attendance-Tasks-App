import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AboutScreen extends StatelessWidget {
  final String yourName = "Nipuna Madula";
  final String submittedDate = DateFormat('yyyy/MM/dd').format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "About",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text("Developer: $yourName", style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Text("Submission Date: $submittedDate", style: TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
