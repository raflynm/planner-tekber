import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/plan_model.dart';
import '../models/todo_model.dart';
import '../providers/app_provider.dart';

class AddItemScreen extends StatefulWidget {
  @override
  _AddItemScreenState createState() => _AddItemScreenState();
}

class _AddItemScreenState extends State<AddItemScreen> {
  final _formKey = GlobalKey<FormState>();
  String _name = '';
  DateTime _date = DateTime.now();  // Default to the current date
  String _startTime = '';
  String _endTime = '';
  String _location = '';
  String _description = '';
  String _priority = 'Medium';
  bool _isPlan = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Item")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              SwitchListTile(
                title: Text("Is this a Plan?"),
                value: _isPlan,
                onChanged: (value) => setState(() => _isPlan = value),
              ),
              TextFormField(
                decoration: InputDecoration(labelText: "Name"),
                onSaved: (value) => _name = value!,
              ),
              // Date Picker
              ListTile(
                title: Text("Date: ${_date.toLocal()}".split(' ')[0]), // Display date
                trailing: Icon(Icons.calendar_today),
                onTap: _selectDate,
              ),
              if (!_isPlan)
                DropdownButtonFormField(
                  value: _priority,
                  items: ["High", "Medium", "Low"]
                      .map((priority) => DropdownMenuItem(
                            value: priority,
                            child: Text(priority),
                          ))
                      .toList(),
                  onChanged: (value) => setState(() => _priority = value!),
                ),
              ElevatedButton(
                onPressed: _saveItem,
                child: Text("Save"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Function to open Date Picker with restriction on past dates
  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime.now(), // Restrict to today and future dates
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _date)
      setState(() {
        _date = picked; // Update the selected date
      });
  }

  void _saveItem() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final provider = Provider.of<AppProvider>(context, listen: false);
      if (_isPlan) {
        provider.addPlan(
          Plan(
            name: _name,
            date: _date,
            startTime: _startTime,
            endTime: _endTime,
            location: _location,
          ),
        );
      } else {
        provider.addToDo(
          ToDo(
            title: _name,
            description: _description,
            priority: _priority,
            date: _date,
          ),
        );
      }
      Navigator.pop(context);
    }
  }
}
