import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:trainingcourt/models/generated_classes.dart';

class LogsScreen extends StatelessWidget {
  List<Logs> logs;

  LogsScreen(this.logs, {super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: logs.length,
        itemBuilder: ((context, index) {
          return Card(
            child: Column(
              children: [
                Text(DateFormat('MM/dd/yyyy').format(logs[index].createdAt!)),
              ],
            ),
          );
        }));
  }
}
