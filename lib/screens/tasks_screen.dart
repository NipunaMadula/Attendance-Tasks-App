import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class TasksScreen extends StatefulWidget {
  @override
  _TasksScreenState createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  List<Map<String, dynamic>> _tasks = [];

  @override
  void initState() {
    super.initState();
    _loadTasks();
  }

  Future<void> _loadTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString('tasks');
    if (data != null) {
      setState(() {
        _tasks = List<Map<String, dynamic>>.from(json.decode(data));
      });
    }
  }

  Future<void> _saveTasks() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('tasks', json.encode(_tasks));
  }

  void _addTask() {
    final _nameController = TextEditingController();
    DateTime? _dueDate;
    String _priority = 'Low';
    String _status = 'Not Started';

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Add Task'),
        content: StatefulBuilder(
          builder: (context, setState) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  TextField(
                    controller: _nameController,
                    decoration: InputDecoration(labelText: 'Task Name'),
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Text(_dueDate == null
                          ? 'No date chosen'
                          : 'Due: ${_dueDate!.toLocal().toString().split(' ')[0]}'),
                      TextButton(
                        child: Text('Pick Date'),
                        onPressed: () async {
                          final picked = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2020),
                            lastDate: DateTime(2030),
                          );
                          if (picked != null) {
                            setState(() {
                              _dueDate = picked;
                            });
                          }
                        },
                      ),
                    ],
                  ),
                  DropdownButton<String>(
                    value: _priority,
                    onChanged: (value) => setState(() => _priority = value!),
                    items: ['Low', 'Medium', 'High']
                        .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                        .toList(),
                  ),
                  DropdownButton<String>(
                    value: _status,
                    onChanged: (value) => setState(() => _status = value!),
                    items: ['Not Started', 'In Progress', 'Done']
                        .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                        .toList(),
                  ),
                ],
              ),
            );
          },
        ),
        actions: [
          TextButton(
            onPressed: () {
              if (_nameController.text.isNotEmpty && _dueDate != null) {
                setState(() {
                  _tasks.add({
                    'name': _nameController.text,
                    'dueDate': _dueDate!.toIso8601String(),
                    'priority': _priority,
                    'status': _status,
                  });
                });
                _saveTasks();
                Navigator.pop(context);
              }
            },
            child: Text('Add'),
          ),
        ],
      ),
    );
  }

  void _updateStatus(int index, String newStatus) {
    setState(() {
      _tasks[index]['status'] = newStatus;
    });
    _saveTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _tasks.isEmpty
          ? Center(child: Text('No tasks added yet.'))
          : ListView.builder(
              itemCount: _tasks.length,
              itemBuilder: (context, index) {
                final task = _tasks[index];
                return Card(
                  margin: EdgeInsets.all(8),
                  child: ListTile(
                    title: Text(task['name']),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Due: ${task['dueDate'].split('T')[0]}"),
                        Text("Priority: ${task['priority']}"),
                      ],
                    ),
                    trailing: DropdownButton<String>(
                      value: task['status'],
                      onChanged: (value) =>
                          _updateStatus(index, value ?? 'Not Started'),
                      items: ['Not Started', 'In Progress', 'Done']
                          .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                          .toList(),
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addTask,
        child: Icon(Icons.add),
      ),
    );
  }
}
