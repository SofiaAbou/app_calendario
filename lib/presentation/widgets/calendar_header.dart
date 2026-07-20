// presentation/widgets/calendar_header.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/calendar_provider.dart';

class CalendarHeader extends StatelessWidget {
  const CalendarHeader({super.key});

  String _getMonthYearString(DateTime date) {
    const months = [
      'Gennaio', 'Febbraio', 'Marzo', 'Aprile', 'Maggio', 'Giugno',
      'Luglio', 'Agosto', 'Settembre', 'Ottobre', 'Novembre', 'Dicembre'
    ];
    return '${months[date.month - 1]} ${date.year}';
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<CalendarProvider>();
    final theme = Theme.of(context);
    final isDesktop = MediaQuery.of(context).size.width > 768;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        border: Border(bottom: BorderSide(color: theme.dividerColor.withOpacity(0.2))),
      ),
      child: Row(
        children: [
          // Titolo Mese/Anno
          Text(
            _getMonthYearString(provider.selectedDate),
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.onSurface,
            ),
          ),
          const SizedBox(width: 16),
          // Pulsante Oggi
          OutlinedButton(
            onPressed: provider.goToToday,
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 12),
            ),
            child: const Text('Oggi'),
          ),
          const SizedBox(width: 8),
          // Navigazione Avanti/Indietro
          IconButton(
            icon: const Icon(Icons.chevron_left),
            onPressed: provider.previousPeriod,
          ),
          IconButton(
            icon: const Icon(Icons.chevron_right),
            onPressed: provider.nextPeriod,
          ),
          const Spacer(),
          // Selettore Viste (Giorno/Settimana/Mese)
          SegmentedButton<CalendarViewType>(
            segments: [
              ButtonSegment(
                value: CalendarViewType.day,
                label: Text(isDesktop ? 'Giorno' : 'G'),
                icon: const Icon(Icons.view_day_outlined),
              ),
              ButtonSegment(
                value: CalendarViewType.week,
                label: Text(isDesktop ? 'Settimana' : 'S'),
                icon: const Icon(Icons.view_week_outlined),
              ),
              ButtonSegment(
                value: CalendarViewType.month,
                label: Text(isDesktop ? 'Mese' : 'M'),
                icon: const Icon(Icons.calendar_view_month_outlined),
              ),
            ],
            selected: {provider.currentView},
            onSelectionChanged: (Set<CalendarViewType> newSelection) {
              provider.setView(newSelection.first);
            },
          ),
        ],
      ),
    );
  }
}