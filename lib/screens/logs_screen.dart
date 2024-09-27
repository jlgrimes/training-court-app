import 'package:flutter/material.dart';
import 'package:supabase_auth_ui/supabase_auth_ui.dart';

class LogsScreen extends StatefulWidget {
  const LogsScreen({super.key});

  @override
  State<LogsScreen> createState() => _LogsPageState();
}

class _LogsPageState extends State<LogsScreen> {
  final _future = Supabase.instance.client
      .from('logs')
      .select('*')
      .eq('user', Supabase.instance.client.auth.currentUser!.id);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _future,
        builder: (context, snapshot) {
          final logs = snapshot.data!;
          return ListView.builder(
              itemCount: logs.length,
              itemBuilder: ((context, index) {
                return Text(logs[index].toString());
              }));
        });
  }
}
