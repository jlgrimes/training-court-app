import 'package:flutter/material.dart';
import 'package:trainingcourt/components/archetype/archetype_autocomplete.dart';

class AddRoundDialog extends StatefulWidget {
  @override
  _AddRoundDialogState createState() => _AddRoundDialogState();
}

class _AddRoundDialogState extends State<AddRoundDialog> {
  // Initialize the selection state for each toggle button
  List<bool> isSelected = [false, false, false];
  List<String> selectedArchetype = ['', ''];
    // Text input state
  String textInput = '';

  // Labels for the toggle options
  final List<String> toggleOptions = ['W', 'L', 'T'];

  void handlePokemonSelect(String message, int idx) {
    selectedArchetype[idx] = message;
  }

  @override
  Widget build(BuildContext context) {
return AlertDialog(
          title: const Text('Add round'),
          content: Column(
            children: [
              ArchetypeAutocomplete(handlePokemonSelect: (p0) => handlePokemonSelect(p0, 0)),
              ArchetypeAutocomplete(handlePokemonSelect: (p0) => handlePokemonSelect(p0, 1)),
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