// domain/entities/calendar_event.dart
import 'event_category.dart';

class CalendarEvent {
  final String id;
  final String title;
  final String? description;
  final DateTime startTime;
  final DateTime endTime;
  final EventCategory category;
  final String? location;

  const CalendarEvent({
    required this.id,
    required this.title,
    this.description,
    required this.startTime,
    required this.endTime,
    required this.category,
    this.location,
  });

  bool get isAllDay => 
      startTime.hour == 0 && startTime.minute == 0 && 
      endTime.hour == 23 && endTime.minute == 59;
}