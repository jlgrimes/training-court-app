import 'package:flutter/material.dart';
import 'package:trainingcourt/components/logs/logs.utils.dart';
import 'package:trainingcourt/components/sprites/pokemon_sprites.dart';

class LogPreview extends StatelessWidget {
  BattleLog battleLog;

  LogPreview(this.battleLog, {super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // onTap: () {
      //   Navigator.push(
      //       context,
      //       MaterialPageRoute(
      //           builder: (context) => TournamentDetailScreen(
      //                 tournament: tournament,
      //               )));
      // },
      child: Card(
        child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              PokemonSprites(battleLog.players[0].deck),
              Text(battleLog.players[0].result, style: TextStyle(fontWeight: FontWeight.bold)),
              PokemonSprites(battleLog.players[1].deck)
            ])),
      ),
    );
  }
}
