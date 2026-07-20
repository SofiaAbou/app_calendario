// main.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'presentation/providers/calendar_provider.dart';
import 'presentation/screens/calendar_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => CalendarProvider(),
      child: const TeamsCalendarApp(),
    ),
  );
}

class TeamsCalendarApp extends StatelessWidget {
  const TeamsCalendarApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Teams Calendar',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      // Configurazione Material 3
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: const Color(0xFF6264A7), // Colore Primario Teams
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: const Color(0xFF6264A7),
        brightness: Brightness.dark,
      ),
      home: const CalendarScreen(),
    );
  }
}