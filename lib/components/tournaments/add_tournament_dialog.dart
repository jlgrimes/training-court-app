import 'package:flutter/material.dart';
import 'package:supabase_auth_ui/supabase_auth_ui.dart';
import 'package:trainingcourt/components/archetype/double_archetype_selector.dart';

class AddTournamentDialog extends StatefulWidget {
  @override
  _AddTournamentDialogState createState() => _AddTournamentDialogState();
}

class _AddTournamentDialogState extends State<AddTournamentDialog> {
    // Text input state
  String? tournamentName;

  // Date picker state
  DateTime? selectedDate;

  List<String?> selectedArchetype = [null, null];

    // Define the list of values (powers of 2 from 1024 to 1, with "t" prefix except Champion and Finalist)
  final List<String> _dropdownValues = [
    't1024',
    't512',
    't256',
    't128',
    't64',
    't32',
    't16',
    't8',
    't4',
    'finalist',  // For 2nd place, we use "finalist"
    'Champion',  // This corresponds to 1st place
  ];

  // Initially selected value
  String? _placement = null;

  void handlePokemonSelect(String message, int idx) {
    selectedArchetype[idx] = message;
  }

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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            onChanged: (text) {
              tournamentName = text;
            },
            decoration: InputDecoration(
              labelText: 'Tournament name',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: Text(
                  selectedDate != null ? 'Date: ${selectedDate!.toLocal()}' : 'Select a date',
                  style: const TextStyle(fontSize: 18),
                ),
              ),
              ElevatedButton(
                onPressed: () => _selectDate(context),
                child: const Text('Select Date'),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
              'My deck', // Label for the group
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,),
            ),
          DoubleArchetypeSelector(handlePokemonSelect),
                    const SizedBox(height: 16),
          DropdownButton<String>(
  value: _placement,  // This can be null initially
  hint: Text("Select a placement"),
  items: _dropdownValues.map((String value) {
    // Prepend "Top" to all values except for "Champion" and "finalist"
    String displayValue;
    if (value == 'Champion') {
      displayValue = 'Champion';
    } else if (value == 'finalist') {
      displayValue = 'Finalist';
    } else {
      // For values with "t" prefix, extract the number after "t" and prepend "Top"
      displayValue = 'Top ${value.substring(1)}';
    }

    return DropdownMenuItem<String>(
      value: value,
      child: Text(displayValue),
    );
  }).toList(),
  onChanged: (String? newValue) {
    setState(() {
      _placement = newValue!;
    });
  },
)
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
              if (tournamentName == null || selectedDate == null || selectedArchetype[0] == null) {
                return;
              }
              
              Supabase.instance.client.from('tournaments').insert({
                'user': Supabase.instance.client.auth.currentUser?.id,
                'name': tournamentName,
                'deck': selectedArchetype.where((item) => item != null).join(','),
                'date_from': selectedDate.toString(),
                'date_to': selectedDate.toString(),
                'placement': _placement,
              }).then((result) {
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(result)),
              );
              });
            },
          ),
        ],
      ),
    ),
  ),
);
  }
}