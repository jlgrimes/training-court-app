import 'package:flutter/material.dart';
import 'package:supabase_auth_ui/supabase_auth_ui.dart';
import 'package:trainingcourt/models/generated_classes.dart';
import 'package:trainingcourt/screens/logs_screen.dart';
import 'package:trainingcourt/screens/tournaments_screen.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomePageState();
}

class _HomePageState extends State<HomeScreen> {
  final _logsFuture = Supabase.instance.client
      .from('logs')
      .select()
      .eq('user', Supabase.instance.client.auth.currentUser!.id)
      .order('created_at', ascending: false)
      .withConverter(Logs.converter);

  final _tournamentsFuture = Supabase.instance.client
      .from('tournaments')
      .select()
      .eq('user', Supabase.instance.client.auth.currentUser!.id)
      .order('date_from', ascending: false)
      .withConverter(Tournaments.converter);

  final _tournamentRoundsFuture = Supabase.instance.client
      .from('tournament rounds')
      .select()
      .eq('user', Supabase.instance.client.auth.currentUser!.id)
      .order('round_num', ascending: true)
      .withConverter(Tournament_rounds.converter);

  final Future<dynamic> _pokedexFuture = http.get(Uri.parse('https://www.trainingcourt.app/api/pokedex'));

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Future.wait([_logsFuture, _tournamentsFuture, _tournamentRoundsFuture, _pokedexFuture]),
        builder: (
          context,
          AsyncSnapshot<List<dynamic>> snapshot,
        ) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }

          final _logs = snapshot.data![0];
          final _tournaments = snapshot.data![1];
          final _tournamentRounds = snapshot.data![2];
          final _pokedex = snapshot.data![3];

          return DefaultTabController(
              length: 3,
              child: Scaffold(
                appBar: AppBar(
                    // TRY THIS: Try changing the color here to a specific color (to
                    // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
                    // change color while the other colors stay the same.
                    backgroundColor:
                        Theme.of(context).colorScheme.inversePrimary,
                    // Here we take the value from the MyHomePage object that was created by
                    // the App.build method, and use it to set our appbar title.
                    title: Text('Training Court'),
                    bottom: const TabBar(
                      tabs: [
                        Tab(icon: Icon(Icons.emoji_events)),
                        Tab(icon: Icon(Icons.article)),
                        Tab(icon: Icon(Icons.person)),
                      ],
                    )),
                body: TabBarView(
                  children: [
                    TournamentsScreen(_tournaments, _tournamentRounds),
                    LogsScreen(_logs),
                    Icon(Icons.directions_bike),
                  ],
                ),
              ));
        });
  }
}
