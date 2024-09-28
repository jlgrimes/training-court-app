import 'package:flutter/material.dart';
import 'package:trainingcourt/components/tournaments/add_tournament_dialog.dart';
import 'package:trainingcourt/components/tournaments/tournament_preview.dart';
import 'package:trainingcourt/models/generated_classes.dart';

Future<void> _dialogBuilder(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AddTournamentDialog();
      },
    );
}
class TournamentsScreen extends StatelessWidget {
  List<Tournaments> tournaments;
  List<Tournament_rounds> tournamentRounds;

  TournamentsScreen(this.tournaments, this.tournamentRounds, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: tournaments.length,
        itemBuilder: ((context, index) {
          List<Tournament_rounds> rounds = tournamentRounds.where((round) => round.tournament == tournaments[index].id).toList();

          return TournamentPreview(tournaments[index], rounds);
        })),
                          floatingActionButton: FloatingActionButton(onPressed: (){
                            _dialogBuilder(context);
                          }, child: const Icon(Icons.add)),
    );
  }
}
