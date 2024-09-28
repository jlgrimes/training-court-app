import 'package:flutter/material.dart';
import 'package:supabase_auth_ui/supabase_auth_ui.dart';
import 'package:trainingcourt/components/sprites/pokemon_sprites.dart';
import 'package:trainingcourt/components/tournaments/rounds/add_round_dialog.dart';
import 'package:trainingcourt/components/tournaments/rounds/tournament_round.dart';
import 'package:trainingcourt/models/generated_classes.dart';

Future<void> _dialogBuilder(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AddRoundDialog();
      },
    );
}

class TournamentDetailScreen extends StatefulWidget {
  Tournaments tournament;
  List<Tournament_rounds> rounds;

  TournamentDetailScreen({super.key, required this.tournament, required this.rounds});

  @override
  State<TournamentDetailScreen> createState() =>
      _TournamentDetailScreenState(tournament, rounds);
}

class _TournamentDetailScreenState extends State<TournamentDetailScreen> {
  Tournaments tournament;
  List<Tournament_rounds> rounds;

  _TournamentDetailScreenState(this.tournament, this.rounds);

  @override
  Widget build(BuildContext context) {
          return Scaffold(
                appBar: AppBar(
                    // TRY THIS: Try changing the color here to a specific color (to
                    // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
                    // change color while the other colors stay the same.
                    backgroundColor:
                        Theme.of(context).colorScheme.inversePrimary,
                    // Here we take the value from the MyHomePage object that was created by
                    // the App.build method, and use it to set our appbar title.
                    title: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                      Text(tournament.name),
                      PokemonSprites(tournament.deck)
                    ],),
                ),
                floatingActionButton: FloatingActionButton(onPressed: (){
                            _dialogBuilder(context);
                          }, child: const Icon(Icons.add)),
                body: Center(child: ListView.builder(
              itemCount: rounds.length,
              itemBuilder: ((context, index) {
                return TournamentRound(rounds[index]);
              })))
              );
  }
}
