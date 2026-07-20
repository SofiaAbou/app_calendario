// presentation/screens/calendar_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/calendar_provider.dart';
import '../widgets/calendar_header.dart';
import '../widgets/week_view.dart';
import '../widgets/month_view.dart';

class CalendarScreen extends StatelessWidget {
  const CalendarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<CalendarProvider>();

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const CalendarHeader(),
            Expanded(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 200),
                child: _buildCurrentView(provider.currentView),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Logica per aggiungere un nuovo evento
        },
        icon: const Icon(Icons.add),
        label: const Text('Nuovo Evento'),
        backgroundColor: const Color(0xFF6264A7), // Colore Teams
        foregroundColor: Colors.white,
      ),
    );
  }

  Widget _buildCurrentView(CalendarViewType view) {
    switch (view) {
      case CalendarViewType.day:
        return const WeekView(isSingleDay: true);
      case CalendarViewType.week:
        return const WeekView(isSingleDay: false);
      case CalendarViewType.month:
        return const MonthView();
    }
  }
}