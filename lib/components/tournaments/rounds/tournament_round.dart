import 'package:flutter/material.dart';
import 'package:trainingcourt/components/sprites/pokemon_sprites.dart';
import 'package:trainingcourt/components/sprites/sprite.dart';
import 'package:trainingcourt/models/generated_classes.dart';

class TournamentRound extends StatelessWidget {
  Tournament_rounds round;

  TournamentRound(this.round, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
          padding: EdgeInsets.all(16.0),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            Text(
              round.roundNum!.toString(),
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            PokemonSprites(round.deck),
            Text(
              round.result.join(''),
              style: TextStyle(fontWeight: FontWeight.bold),
            )
          ])),
    );
  }
}
