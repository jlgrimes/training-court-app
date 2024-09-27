import 'package:flutter/material.dart';
import 'package:supabase_auth_ui/supabase_auth_ui.dart';

class LogsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: logs.length,
        itemBuilder: ((context, index) {
          return Text(logs[index].toString());
        }));
  }
}
