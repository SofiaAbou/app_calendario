// presentation/widgets/month_view.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/calendar_provider.dart';

class MonthView extends StatelessWidget {
  const MonthView({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<CalendarProvider>();
    final theme = Theme.of(context);
    
    final firstDayOfMonth = DateTime(provider.selectedDate.year, provider.selectedDate.month, 1);
    final daysInMonth = DateTime(provider.selectedDate.year, provider.selectedDate.month + 1, 0).day;
    final startingWeekday = firstDayOfMonth.weekday;

    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 7,
        childAspectRatio: 1.2,
      ),
      itemCount: daysInMonth + (startingWeekday - 1),
      itemBuilder: (context, index) {
        if (index < startingWeekday - 1) {
          return const SizedBox.shrink(); // Cella vuota per allineamento
        }

        final dayNumber = index - (startingWeekday - 2);
        final currentDate = DateTime(provider.selectedDate.year, provider.selectedDate.month, dayNumber);

        final dayEvents = provider.events.where((e) =>
            e.startTime.year == currentDate.year &&
            e.startTime.month == currentDate.month &&
            e.startTime.day == currentDate.day).toList();

        return InkWell(
          onTap: () {
            provider.setSelectedDate(currentDate);
            provider.setView(CalendarViewType.day);
          },
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: theme.dividerColor.withOpacity(0.1)),
            ),
            padding: const EdgeInsets.all(4.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$dayNumber',
                  style: TextStyle(fontWeight: FontWeight.bold, color: theme.colorScheme.onSurface),
                ),
                const SizedBox(height: 4),
                ...dayEvents.take(2).map((event) => Container(
                  margin: const EdgeInsets.only(bottom: 2),
                  padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                  decoration: BoxDecoration(
                    color: event.category.color,
                    borderRadius: BorderRadius.circular(2),
                  ),
                  child: Text(
                    event.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: Colors.white, fontSize: 9),
                  ),
                )),
              ],
            ),
          ),
        );
      },
    );
  }
}