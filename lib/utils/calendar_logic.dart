import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';

enum CalendarEventType {
  training,
  tournament,
  championship,
}

DateTime dateOnly(DateTime date) {
  return DateTime(date.year, date.month, date.day);
}

CalendarEventType? eventTypeFromTitle(String? title) {
  switch (title) {
    case 'Treniruote':
    case 'TreniruotÄ—':
      return CalendarEventType.training;
    case 'Turnyras':
      return CalendarEventType.tournament;
    case 'Cempionatas':
    case 'ÄŒempionatas':
      return CalendarEventType.championship;
    default:
      return null;
  }
}

CalendarEventType? eventTypeFromDatabase(String? value) {
  switch (value) {
    case 'treniruote':
      return CalendarEventType.training;
    case 'turnyras':
      return CalendarEventType.tournament;
    case 'cempionatas':
      return CalendarEventType.championship;
    default:
      return null;
  }
}

String eventTypeValue(CalendarEventType type) {
  switch (type) {
    case CalendarEventType.training:
      return 'treniruote';
    case CalendarEventType.tournament:
      return 'turnyras';
    case CalendarEventType.championship:
      return 'cempionatas';
  }
}

String eventTitle(CalendarEventType type) {
  switch (type) {
    case CalendarEventType.training:
      return 'TreniruotÄ—';
    case CalendarEventType.tournament:
      return 'Turnyras';
    case CalendarEventType.championship:
      return 'ÄŒempionatas';
  }
}

bool eventAlreadyExists(List<Event> events, String title) {
  return events.any((event) => event.title == title);
}

List<DateTime> recurringEventDates({
  required DateTime startDate,
  required DateTime endDate,
  required List<int> weekdays,
  required bool Function(DateTime day) alreadyExists,
}) {
  final dates = <DateTime>[];
  DateTime current = dateOnly(startDate);
  final last = dateOnly(endDate);

  while (!current.isAfter(last)) {
    if (weekdays.contains(current.weekday) && !alreadyExists(current)) {
      dates.add(current);
    }

    current = current.add(const Duration(days: 1));
  }

  return dates;
}

int? stressDaysUntilEvent(
  DateTime day,
  Map<DateTime, List<Event>> markedEvents, {
  int stressHighlightDays = 3,
}) {
  final normalizedDay = dateOnly(day);
  int? closestStressDay;

  for (final entry in markedEvents.entries) {
    final eventDay = dateOnly(entry.key);
    final daysUntilEvent = eventDay.difference(normalizedDay).inDays;

    if (daysUntilEvent < 1 || daysUntilEvent > stressHighlightDays) {
      continue;
    }

    final hasStressfulEvent = entry.value.any((event) {
      final type = eventTypeFromTitle(event.title);
      return type == CalendarEventType.tournament ||
          type == CalendarEventType.championship;
    });

    if (!hasStressfulEvent) {
      continue;
    }

    if (closestStressDay == null || daysUntilEvent < closestStressDay) {
      closestStressDay = daysUntilEvent;
    }
  }

  return closestStressDay;
}

Color? stressHighlightColor(
  DateTime day,
  Map<DateTime, List<Event>> markedEvents, {
  int stressHighlightDays = 3,
}) {
  switch (
      stressDaysUntilEvent(day, markedEvents, stressHighlightDays: stressHighlightDays)) {
    case 1:
      return Colors.red.withValues(alpha: 0.30);
    case 2:
      return Colors.orange.withValues(alpha: 0.22);
    case 3:
      return Colors.amber.withValues(alpha: 0.18);
    default:
      return null;
  }
}
