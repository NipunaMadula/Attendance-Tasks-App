import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AttendanceScreen extends StatefulWidget {
  @override
  _AttendanceScreenState createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  String? _name;
  String? _checkInTime;
  String? _checkOutTime;
  String? _status;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _name = prefs.getString('user_name');
      _checkInTime = prefs.getString('checkin_${_todayKey()}');
      _checkOutTime = prefs.getString('checkout_${_todayKey()}');
    });
    _updateStatus();
  }

  String _todayKey() {
    final now = DateTime.now();
    return DateFormat('yyyyMMdd').format(now);
  }

  void _updateStatus() {
    if (_checkInTime != null && _checkOutTime != null) {
      _status = 'Present';
    } else if (_checkInTime != null || _checkOutTime != null) {
      _status = 'Incomplete';
    } else {
      _status = 'Absent';
    }
  }

  Future<void> _setName(String name) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_name', name);
    setState(() {
      _name = name;
    });
  }

  Future<void> _checkIn() async {
    final now = DateFormat('HH:mm').format(DateTime.now());
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('checkin_${_todayKey()}', now);
    setState(() {
      _checkInTime = now;
    });
    _updateStatus();
  }

  Future<void> _checkOut() async {
    final now = DateFormat('HH:mm').format(DateTime.now());
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('checkout_${_todayKey()}', now);
    setState(() {
      _checkOutTime = now;
    });
    _updateStatus();
  }

  String _timeSpent() {
    try {
      if (_checkInTime == null || _checkOutTime == null) return '-';
      final inTime = DateFormat('HH:mm').parse(_checkInTime!);
      final outTime = DateFormat('HH:mm').parse(_checkOutTime!);
      final diff = outTime.difference(inTime);
      return diff.inHours.toString().padLeft(2, '0') + ':' +
          (diff.inMinutes % 60).toString().padLeft(2, '0');
    } catch (e) {
      return '-';
    }
  }

  @override
  Widget build(BuildContext context) {
    final today = DateTime.now();
    final dateStr = DateFormat('MM/dd/yyyy').format(today);
    final dayStr = DateFormat('EEEE').format(today);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: _name == null
          ? Column(
              children: [
                Text("Enter your name:"),
                TextField(
                  onSubmitted: _setName,
                  decoration: InputDecoration(hintText: 'Your Name'),
                ),
              ],
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Welcome, $_name!", style: TextStyle(fontSize: 18)),
                SizedBox(height: 16),
                Text("Date: $dateStr"),
                Text("Day: $dayStr"),
                SizedBox(height: 16),
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: _checkIn,
                      child: Text('Check In'),
                    ),
                    SizedBox(width: 16),
                    ElevatedButton(
                      onPressed: _checkOut,
                      child: Text('Check Out'),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Text("Check-In Time: ${_checkInTime ?? '-'}"),
                Text("Check-Out Time: ${_checkOutTime ?? '-'}"),
                Text("Time Spent: ${_timeSpent()}"),
                Text("Status: $_status"),
              ],
            ),
    );
  }
}
