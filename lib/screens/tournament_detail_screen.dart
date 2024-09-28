import 'package:flutter/material.dart';
import 'package:supabase_auth_ui/supabase_auth_ui.dart';
import 'package:trainingcourt/components/tournaments/rounds/tournament_round.dart';
import 'package:trainingcourt/models/generated_classes.dart';

class TournamentDetailScreen extends StatefulWidget {
  Tournaments tournament;

  TournamentDetailScreen({super.key, required this.tournament});

  @override
  State<TournamentDetailScreen> createState() =>
      _TournamentDetailScreenState(tournament);
}

class _TournamentDetailScreenState extends State<TournamentDetailScreen> {
  dynamic _tournamentDetailsFuture;
  Tournaments tournament;

  _TournamentDetailScreenState(this.tournament) {
    _tournamentDetailsFuture = Supabase.instance.client
        .from('tournament rounds')
        .select('*')
        .eq('tournament', tournament.id)
        .order('round_num', ascending: true)
        .withConverter(Tournament_rounds.converter);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _tournamentDetailsFuture,
        builder: (
          context,
          AsyncSnapshot<List<dynamic>> snapshot,
        ) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          final tournamentRounds = snapshot.data!;

          return Scaffold(
                appBar: AppBar(
                    // TRY THIS: Try changing the color here to a specific color (to
                    // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
                    // change color while the other colors stay the same.
                    backgroundColor:
                        Theme.of(context).colorScheme.inversePrimary,
                    // Here we take the value from the MyHomePage object that was created by
                    // the App.build method, and use it to set our appbar title.
                    title: Text(tournament.name),
                ),
                body: Center(child: snapshot.hasData ? ListView.builder(
              itemCount: tournamentRounds.length,
              itemBuilder: ((context, index) {
                return TournamentRound(tournamentRounds[index]);
              })) : CircularProgressIndicator())
              );
        });
  }
}
