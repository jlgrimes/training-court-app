import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:trainingcourt/components/sprite.dart';
import 'package:trainingcourt/models/generated_classes.dart';

class TournamentPreview extends StatelessWidget {
  Tournaments tournament;

  TournamentPreview(this.tournament, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Row(children: [
            Row(children: [
              Sprite(tournament.deck?.split(',')[0]),
              Sprite(tournament.deck?.split(',')[1]),
            ]),
            Padding(
                padding: EdgeInsets.only(left: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      tournament.name,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(DateFormat('MM/dd/yyyy').format(tournament.dateFrom!)),
                  ],
                ))
          ])),
    );
  }
}
