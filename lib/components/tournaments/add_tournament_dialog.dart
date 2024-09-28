import 'package:flutter/material.dart';

class AddTournamentDialog extends StatefulWidget {
  @override
  _AddTournamentDialogState createState() => _AddTournamentDialogState();
}

class _AddTournamentDialogState extends State<AddTournamentDialog> {
    // Text input state
  String textInput = '';

  // Date picker state
  DateTime selectedDate = DateTime.now();

  // Labels for the toggle options
  final List<String> toggleOptions = ['W', 'L', 'T'];

    Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate, // Current selected date
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
return Dialog.fullscreen(
  child: Scaffold(
    appBar: AppBar(
      title: const Text('Add tournament'),
      leading: IconButton(
        icon: const Icon(Icons.close),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
    ),
    body: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextField(
            onChanged: (text) {
              // Handle text input here
            },
            decoration: InputDecoration(
              labelText: 'Enter text',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: Text(
                  'Selected Date: ${selectedDate.toLocal()}'.split(' ')[0],
                  style: const TextStyle(fontSize: 18),
                ),
              ),
              ElevatedButton(
                onPressed: () => _selectDate(context),
                child: const Text('Select Date'),
              ),
            ],
          ),
        ],
      ),
    ),
    bottomNavigationBar: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          TextButton(
            child: const Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          const SizedBox(width: 8),
          TextButton(
            child: const Text('Add'),
            onPressed: () {
              // Handle add action here
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    ),
  ),
);
  }
}