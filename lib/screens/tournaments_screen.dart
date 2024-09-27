import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:trainingcourt/models/generated_classes.dart';

class TournamentsScreen extends StatelessWidget {
  List<Tournaments> tournaments;

  TournamentsScreen(this.tournaments, {super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: tournaments.length,
        itemBuilder: ((context, index) {
          return Card(
            child: Column(
              children: [
                Text(tournaments[index].name),
                Text(DateFormat('MM/dd/yyyy')
                    .format(tournaments[index].createdAt!)),
              ],
            ),
          );
        }));
  }
}
