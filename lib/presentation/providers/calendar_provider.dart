// presentation/providers/calendar_provider.dart
import 'package:flutter/material.dart';
import '../../dominio/entita/calendar_event.dart';
import '../../data/models/repositories/mock_event_repository.dart';

enum CalendarViewType { day, week, month }

class CalendarProvider extends ChangeNotifier {
  final MockEventRepository _repository = MockEventRepository();

  DateTime _selectedDate = DateTime.now();
  CalendarViewType _currentView = CalendarViewType.week;
  List<CalendarEvent> _events = [];

  CalendarProvider() {
    _loadEvents();
  }

  // Getter pubblici
  DateTime get selectedDate => _selectedDate;
  CalendarViewType get currentView => _currentView;
  List<CalendarEvent> get events => _events;

  void _loadEvents() {
    _events = _repository.getMockEvents();
    notifyListeners();
  }

  // Cambio Vista
  void setView(CalendarViewType view) {
    _currentView = view;
    notifyListeners();
  }

  // Navigazione Date
  void setSelectedDate(DateTime date) {
    _selectedDate = date;
    notifyListeners();
  }

  void previousPeriod() {
    switch (_currentView) {
      case CalendarViewType.day:
        _selectedDate = _selectedDate.subtract(const Duration(days: 1));
        break;
      case CalendarViewType.week:
        _selectedDate = _selectedDate.subtract(const Duration(days: 7));
        break;
      case CalendarViewType.month:
        _selectedDate = DateTime(_selectedDate.year, _selectedDate.month - 1, 1);
        break;
    }
    notifyListeners();
  }

  void nextPeriod() {
    switch (_currentView) {
      case CalendarViewType.day:
        _selectedDate = _selectedDate.add(const Duration(days: 1));
        break;
      case CalendarViewType.week:
        _selectedDate = _selectedDate.add(const Duration(days: 7));
        break;
      case CalendarViewType.month:
        _selectedDate = DateTime(_selectedDate.year, _selectedDate.month + 1, 1);
        break;
    }
    notifyListeners();
  }

  void goToToday() {
    _selectedDate = DateTime.now();
    notifyListeners();
  }
}