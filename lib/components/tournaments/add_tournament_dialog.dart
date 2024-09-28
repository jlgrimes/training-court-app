import 'package:flutter/material.dart';

class AddTournamentDialog extends StatefulWidget {
  @override
  _AddTournamentDialogState createState() => _AddTournamentDialogState();
}

class _AddTournamentDialogState extends State<AddTournamentDialog> {
  // Initialize the selection state for each toggle button
  List<bool> isSelected = [false, false, false];
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
return AlertDialog(
          title: const Text('Add tournament'),
          content: Column(
            children: [
                          TextField(
              onChanged: (text) {
                setState(() {
                  textInput = text;
                });
              },
              decoration: InputDecoration(
                labelText: 'Enter text',
                border: OutlineInputBorder(),
              ),
            ),
                        Row(
              children: [
                Expanded(
                  child: Text(
                    'Selected Date: ${selectedDate.toLocal()}'.split(' ')[0],
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                ElevatedButton(
                  onPressed: () => _selectDate(context),
                  child: Text('Select Date'),
                ),
              ],
            ),
              ToggleButtons(
          borderRadius: BorderRadius.circular(8.0),
          isSelected: isSelected,
          onPressed: (int index) {
            setState(() {
              // Set all selections to false
              for (int buttonIndex = 0;
                  buttonIndex < isSelected.length;
                  buttonIndex++) {
                isSelected[buttonIndex] = false;
              }
              // Set the selected index to true
              isSelected[index] = true;
            });
          },
          children: toggleOptions
              .map((option) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(option),
                  ))
              .toList(),
        )
            ],
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Add'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
  }
}