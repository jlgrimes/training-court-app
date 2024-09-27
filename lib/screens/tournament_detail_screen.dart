import 'package:flutter/material.dart';
import 'package:supabase_auth_ui/supabase_auth_ui.dart';
import 'package:trainingcourt/components/tournaments/rounds/tournament_round.dart';
import 'package:trainingcourt/models/generated_classes.dart';

class TournamentDetailScreen extends StatefulWidget {
  String tournamentId;

  TournamentDetailScreen({super.key, required this.tournamentId});

  @override
  State<TournamentDetailScreen> createState() =>
      _TournamentDetailScreenState(tournamentId);
}

class _TournamentDetailScreenState extends State<TournamentDetailScreen> {
  dynamic _tournamentDetailsFuture;

  _TournamentDetailScreenState(tournamentId) {
    _tournamentDetailsFuture = Supabase.instance.client
        .from('tournament rounds')
        .select('*')
        .eq('tournament', tournamentId)
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
          final tournamentRounds = snapshot.data!;

          return ListView.builder(
              itemCount: tournamentRounds.length,
              itemBuilder: ((context, index) {
                return TournamentRound(tournamentRounds[index]);
              }));
        });
  }
}
