// domain/entities/event_category.dart
import 'package:flutter/material.dart';

enum CategoryType { meeting, call, focus, personal }

class EventCategory {
  final String id;
  final String name;
  final Color color;
  final IconData icon;

  const EventCategory({
    required this.id,
    required this.name,
    required this.color,
    required this.icon,
  });

  static const Map<CategoryType, EventCategory> defaults = {
    CategoryType.meeting: EventCategory(
      id: 'meeting',
      name: 'Riunione',
      color: Color(0xFF6264A7), // Teams Purple
      icon: Icons.groups_rounded,
    ),
    CategoryType.call: EventCategory(
      id: 'call',
      name: 'Chiamata',
      color: Color(0xFF0078D4), // Microsoft Blue
      icon: Icons.phone_in_talk_rounded,
    ),
    CategoryType.focus: EventCategory(
      id: 'focus',
      name: 'Focus',
      color: Color(0xFF107C41), // Excel Green
      icon: Icons.center_focus_strong_rounded,
    ),
    CategoryType.personal: EventCategory(
      id: 'personal',
      name: 'Personale',
      color: Color(0xFFD13438), // Crimson Red
      icon: Icons.person_rounded,
    ),
  };
}