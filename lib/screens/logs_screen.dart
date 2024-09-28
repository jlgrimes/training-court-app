import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:trainingcourt/components/logs/log_preview.dart';
import 'package:trainingcourt/components/logs/logs.utils.dart';
import 'package:trainingcourt/models/generated_classes.dart';

class LogsScreen extends StatelessWidget {
  List<Logs> logs;

  LogsScreen(this.logs, {super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: logs.length,
        itemBuilder: ((context, index) {
          return LogPreview(parseBattleLog(logs[index].log, logs[index].id, logs[index].createdAt.toString(), logs[index].archetype, 'comp0cker'));
        }));
  }
}
