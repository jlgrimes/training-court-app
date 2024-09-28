import 'package:flutter/material.dart';
import 'package:trainingcourt/components/tournaments/tournament_preview.dart';
import 'package:trainingcourt/models/generated_classes.dart';

Future<void> _dialogBuilder(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add tournament'),
          content: const Text(
            'A dialog is a type of modal window that\n'
            'appears in front of app content to\n'
            'provide critical information, or prompt\n'
            'for a decision to be made.',
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
      },
    );
}
class TournamentsScreen extends StatelessWidget {
  List<Tournaments> tournaments;

  TournamentsScreen(this.tournaments, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: tournaments.length,
        itemBuilder: ((context, index) {
          return TournamentPreview(tournaments[index]);
        })),
                          floatingActionButton: FloatingActionButton(onPressed: (){
                            _dialogBuilder(context);
                          }, child: const Icon(Icons.add)),
    );
  }
}
