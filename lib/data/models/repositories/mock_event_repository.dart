// data/repositories/mock_event_repository.dart
import 'package:app_calendario/dominio/entita/calendar_event.dart';
import 'package:app_calendario/dominio/entita/event_category.dart';
class MockEventRepository {
  List<CalendarEvent> getMockEvents() {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    return [
      CalendarEvent(
        id: '1',
        title: 'Meeting - Team App',
        description: 'Allineamento sui task giornalieri',
        startTime: today.add(const Duration(hours: 9, minutes: 30)),
        endTime: today.add(const Duration(hours: 10, minutes: 00)),
        category: EventCategory.defaults[CategoryType.meeting]!,
        location: 'Canale Teams General',),
      CalendarEvent(
        id: '2',
        title: 'Call con il cliente',
        startTime: today.add(const Duration(hours: 11, minutes: 00)),
        endTime: today.add(const Duration(hours: 12, minutes: 00)),
        category: EventCategory.defaults[CategoryType.call]!,),
      CalendarEvent(
        id: '3',
        title: 'Sessione di Sviluppo',
        description: 'Implementazione architettura Clean Flutter',
        startTime: today.add(const Duration(hours: 14, minutes: 00)),
        endTime: today.add(const Duration(hours: 16, minutes: 30)),
        category: EventCategory.defaults[CategoryType.focus]!,),
      CalendarEvent(
        id: '4',
        title: 'Call con il team',
        startTime: today.add(const Duration(days: 1, hours: 15, minutes: 00)),
        endTime: today.add(const Duration(days: 1, hours: 16, minutes: 00)),
        category: EventCategory.defaults[CategoryType.meeting]!,
      ),
    ];
  }
}