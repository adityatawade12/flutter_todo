import 'package:flutter/material.dart';

class Task {
  final String taskName;
  final String id;
  final DateTime date;
  final TimeOfDay time;

  Task(
      {required this.taskName,
      required this.id,
      required this.date,
      required this.time});
}
