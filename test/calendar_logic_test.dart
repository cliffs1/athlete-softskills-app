import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:softskills_app/utils/calendar_logic.dart';

void main() {
  group('calendar logic', () {
    test('dateOnly strips time from a DateTime', () {
      final result = dateOnly(DateTime(2026, 4, 15, 22, 45, 10));

      expect(result, DateTime(2026, 4, 15));
    });

    test('maps database values to event types', () {
      expect(
        eventTypeFromDatabase('treniruote'),
        CalendarEventType.training,
      );
      expect(
        eventTypeFromDatabase('turnyras'),
        CalendarEventType.tournament,
      );
      expect(
        eventTypeFromDatabase('cempionatas'),
        CalendarEventType.championship,
      );
      expect(eventTypeFromDatabase('unknown'), isNull);
      expect(eventTypeFromDatabase(null), isNull);
    });

    test('maps UI titles to event types', () {
      expect(eventTypeFromTitle('Treniruote'), CalendarEventType.training);
      expect(
        eventTypeFromTitle(eventTitle(CalendarEventType.training)),
        CalendarEventType.training,
      );
      expect(eventTypeFromTitle('Turnyras'), CalendarEventType.tournament);
      expect(eventTypeFromTitle('Cempionatas'), CalendarEventType.championship);
      expect(
        eventTypeFromTitle(eventTitle(CalendarEventType.championship)),
        CalendarEventType.championship,
      );
      expect(eventTypeFromTitle('Diary'), isNull);
      expect(eventTypeFromTitle(null), isNull);
    });

    test('maps event type values for storage', () {
      expect(eventTypeValue(CalendarEventType.training), 'treniruote');
      expect(eventTypeValue(CalendarEventType.tournament), 'turnyras');
      expect(eventTypeValue(CalendarEventType.championship), 'cempionatas');
    });

    test('maps event titles for display', () {
      expect(eventTitle(CalendarEventType.training), isNotEmpty);
      expect(eventTitle(CalendarEventType.training), contains('Treniruot'));
      expect(eventTitle(CalendarEventType.tournament), 'Turnyras');
      expect(eventTitle(CalendarEventType.championship), contains('empionatas'));
    });

    test('eventAlreadyExists returns true only for matching titles', () {
      final events = [
        Event(
          date: DateTime(2026, 4, 18),
          title: 'Turnyras',
          icon: const SizedBox.shrink(),
        ),
        Event(
          date: DateTime(2026, 4, 18),
          title: 'Dienorastis uzpildytas',
          icon: const SizedBox.shrink(),
        ),
      ];

      expect(eventAlreadyExists(events, 'Turnyras'), isTrue);
      expect(
        eventAlreadyExists(events, eventTitle(CalendarEventType.training)),
        isFalse,
      );
    });

    test('returns recurring dates for selected weekdays and skips duplicates', () {
      final dates = recurringEventDates(
        startDate: DateTime(2026, 4, 13),
        endDate: DateTime(2026, 4, 19),
        weekdays: [DateTime.monday, DateTime.wednesday, DateTime.friday],
        alreadyExists: (day) => day == DateTime(2026, 4, 15),
      );

      expect(
        dates,
        [
          DateTime(2026, 4, 13),
          DateTime(2026, 4, 17),
        ],
      );
    });

    test('returns empty recurring dates when start is after end', () {
      final dates = recurringEventDates(
        startDate: DateTime(2026, 4, 20),
        endDate: DateTime(2026, 4, 19),
        weekdays: [DateTime.monday],
        alreadyExists: (_) => false,
      );

      expect(dates, isEmpty);
    });

    test('finds nearest stressful event day', () {
      final markedEvents = <DateTime, List<Event>>{
        DateTime(2026, 4, 18): [
          Event(
            date: DateTime(2026, 4, 18),
            title: 'Turnyras',
            icon: const SizedBox.shrink(),
          ),
        ],
        DateTime(2026, 4, 19): [
          Event(
            date: DateTime(2026, 4, 19),
            title: eventTitle(CalendarEventType.training),
            icon: const SizedBox.shrink(),
          ),
        ],
      };

      expect(
        stressDaysUntilEvent(DateTime(2026, 4, 17), markedEvents),
        1,
      );
      expect(
        stressDaysUntilEvent(DateTime(2026, 4, 16), markedEvents),
        2,
      );
    });

    test('ignores stressful events outside configured highlight window', () {
      final markedEvents = <DateTime, List<Event>>{
        DateTime(2026, 4, 20): [
          Event(
            date: DateTime(2026, 4, 20),
            title: 'Turnyras',
            icon: const SizedBox.shrink(),
          ),
        ],
      };

      expect(
        stressDaysUntilEvent(DateTime(2026, 4, 15), markedEvents),
        isNull,
      );
      expect(
        stressDaysUntilEvent(
          DateTime(2026, 4, 15),
          markedEvents,
          stressHighlightDays: 5,
        ),
        5,
      );
    });

    test('returns expected highlight colors by distance', () {
      final markedEvents = <DateTime, List<Event>>{
        DateTime(2026, 4, 18): [
          Event(
            date: DateTime(2026, 4, 18),
            title: 'Turnyras',
            icon: const SizedBox.shrink(),
          ),
        ],
      };

      expect(
        stressHighlightColor(DateTime(2026, 4, 17), markedEvents),
        Colors.red.withValues(alpha: 0.30),
      );
      expect(
        stressHighlightColor(DateTime(2026, 4, 16), markedEvents),
        Colors.orange.withValues(alpha: 0.22),
      );
      expect(
        stressHighlightColor(DateTime(2026, 4, 15), markedEvents),
        Colors.amber.withValues(alpha: 0.18),
      );
    });

    test('returns null highlight color when no stressful event is nearby', () {
      final markedEvents = <DateTime, List<Event>>{
        DateTime(2026, 4, 20): [
          Event(
            date: DateTime(2026, 4, 20),
            title: eventTitle(CalendarEventType.training),
            icon: const SizedBox.shrink(),
          ),
        ],
      };

      expect(
        stressHighlightColor(DateTime(2026, 4, 17), markedEvents),
        isNull,
      );
    });
  });
}
