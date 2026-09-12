import 'package:flutter/material.dart';
import 'home.dart';

void main() {
  runApp(const EventReminderApp());
}

class EventReminderApp extends StatelessWidget {
  const EventReminderApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Event Reminder',
      home: const HomePage(),
    );
  }
}