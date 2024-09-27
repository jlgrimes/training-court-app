import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:trainingcourt/components/sprites/pokemon_sprites.dart';
import 'package:trainingcourt/components/sprites/sprite.dart';
import 'package:trainingcourt/models/generated_classes.dart';
import 'package:trainingcourt/screens/tournament_detail_screen.dart';

class TournamentPreview extends StatelessWidget {
  Tournaments tournament;

  TournamentPreview(this.tournament, {super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => TournamentDetailScreen(
                      tournamentId: tournament.id,
                    )));
      },
      child: Card(
        child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Row(children: [
              PokemonSprites(tournament.deck),
              Padding(
                  padding: EdgeInsets.only(left: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        tournament.name,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(DateFormat('MM/dd/yyyy')
                          .format(tournament.dateFrom!)),
                    ],
                  ))
            ])),
      ),
    );
  }
}
