// presentation/widgets/week_view.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/calendar_provider.dart';
import '../../dominio/entita/calendar_event.dart';

class WeekView extends StatelessWidget {
  final bool isSingleDay;

  const WeekView({super.key, this.isSingleDay = false});

  List<DateTime> _getDaysInWeek(DateTime selectedDate) {
    if (isSingleDay) return [selectedDate];
    final startOfWeek = selectedDate.subtract(Duration(days: selectedDate.weekday - 1));
    return List.generate(7, (index) => startOfWeek.add(Duration(days: index)));
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<CalendarProvider>();
    final days = _getDaysInWeek(provider.selectedDate);
    final theme = Theme.of(context);

    return Column(
      children: [
        // Intestazione Giorni
        Container(
          color: theme.colorScheme.surfaceVariant.withOpacity(0.3),
          child: Row(
            children: [
              const SizedBox(width: 60), // Spazio per le ore
              ...days.map((day) => Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    border: Border(left: BorderSide(color: theme.dividerColor.withOpacity(0.1))),
                  ),
                  child: Text(
                    '${_weekdayName(day.weekday)}\n${day.day}',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: _isSameDay(day, DateTime.now()) ? FontWeight.bold : FontWeight.normal,
                      color: _isSameDay(day, DateTime.now()) ? theme.colorScheme.primary : theme.colorScheme.onSurface,
                    ),
                  ),
                ),
              )),
            ],
          ),
        ),
        // Griglia Oraria Sfondabile
        Expanded(
          child: ListView.builder(
            itemCount: 24,
            itemBuilder: (context, hour) {
              return Container(
                height: 60,
                decoration: BoxDecoration(
                  border: Border(top: BorderSide(color: theme.dividerColor.withOpacity(0.1))),
                ),
                child: Row(
                  children: [
                    // Colonna Ora
                    SizedBox(
                      width: 60,
                      child: Text(
                        '${hour.toString().padLeft(2, '0')}:00',
                        textAlign: TextAlign.center,
                        style: theme.textTheme.bodySmall?.copyWith(color: Colors.grey),
                      ),
                    ),
                    // Celle dei Giorni
                    ...days.map((day) {
                      final hourStart = DateTime(day.year, day.month, day.day, hour);
                      final hourEnd = hourStart.add(const Duration(hours: 1));
                      
                      final dayEvents = provider.events.where((e) => 
                        e.startTime.isBefore(hourEnd) && e.endTime.isAfter(hourStart) &&
                        e.startTime.day == day.day
                      ).toList();

                      return Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border(left: BorderSide(color: theme.dividerColor.withOpacity(0.1))),
                          ),
                          child: Stack(
                            children: dayEvents.map((event) => _buildEventCard(context, event)).toList(),
                          ),
                        ),
                      );
                    }),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildEventCard(BuildContext context, CalendarEvent event) {
    return Container(
      margin: const EdgeInsets.all(2),
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: event.category.color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(4),
        border: Border(left: BorderSide(color: event.category.color, width: 4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            event.title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 11, 
              fontWeight: FontWeight.bold, 
              color: event.category.color,
            ),
          ),
        ],
      ),
    );
  }

  bool _isSameDay(DateTime d1, DateTime d2) {
    return d1.year == d2.year && d1.month == d2.month && d1.day == d2.day;
  }

  String _weekdayName(int day) {
    const names = ['Lun', 'Mar', 'Mer', 'Gio', 'Ven', 'Sab', 'Dom'];
    return names[day - 1];
  }
}