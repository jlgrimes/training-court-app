import 'package:flutter/material.dart';
import 'package:supabase_auth_ui/supabase_auth_ui.dart';
import 'package:trainingcourt/screens/logs_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomePageState();
}

class _HomePageState extends State<HomeScreen> {
  final _logsFuture = Supabase.instance.client
      .from('logs')
      .select('*')
      .eq('user', Supabase.instance.client.auth.currentUser!.id);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
              // TRY THIS: Try changing the color here to a specific color (to
              // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
              // change color while the other colors stay the same.
              backgroundColor: Theme.of(context).colorScheme.inversePrimary,
              // Here we take the value from the MyHomePage object that was created by
              // the App.build method, and use it to set our appbar title.
              title: Text('Training Court'),
              bottom: const TabBar(
                tabs: [
                  Tab(icon: Icon(Icons.article)),
                  Tab(icon: Icon(Icons.emoji_events)),
                  Tab(icon: Icon(Icons.person)),
                ],
              )),
          body: TabBarView(
            children: [
              FutureBuilder(
                  future: _logsFuture,
                  builder: (context, snapshot) {
                    final logs = snapshot.data!;
                    return ListView.builder(
                        itemCount: logs.length,
                        itemBuilder: ((context, index) {
                          return Text(logs[index].toString());
                        }));
                  }),
              Icon(Icons.directions_transit),
              Icon(Icons.directions_bike),
            ],
          ),
        ));
  }
}
