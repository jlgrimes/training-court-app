import 'package:flutter/material.dart';
import 'package:trainingcourt/components/sprites/pokemon_sprites.dart';
import 'package:trainingcourt/components/sprites/sprite.dart';
import 'package:trainingcourt/components/tournaments/rounds/rounds.utils.dart';
import 'package:trainingcourt/models/generated_classes.dart';

class TournamentRound extends StatelessWidget {
  Tournament_rounds round;

  TournamentRound(this.round, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: getResultBackgroundColor(determineRoundResult(round.result)),
      child: Padding(
          padding: EdgeInsets.all(16.0),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(
              round.roundNum!.toString(),
              style: TextStyle(fontWeight: FontWeight.w900, color: getResultForegroundColor(determineRoundResult(round.result))),
            ),
            PokemonSprites(round.deck),
            Text(
              round.result.join(''),
              style: TextStyle(fontWeight: FontWeight.w900, fontSize: 16, color: getResultForegroundColor(determineRoundResult(round.result))),
            )
          ])),
    );
  }
}
