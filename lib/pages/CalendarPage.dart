import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/classes/event_list.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart'
    show CalendarCarousel;
import 'package:supabase_flutter/supabase_flutter.dart';
import '../main.dart';
import '../utils/calendar_logic.dart';

class Calendarpage extends StatefulWidget {
  const Calendarpage({super.key});

  @override
  State<Calendarpage> createState() => _CalendarpageState();
}

class _CalendarpageState extends State<Calendarpage> with RouteAware {
  static const int _stressHighlightDays = 3;

  final supabase = Supabase.instance.client;
  bool _isSubscribed = false;

  DateTime _currentDate = DateTime.now();
  DateTime? _selectedDate = DateTime.now();
  bool _isLoadingEvents = true;

  late EventList<Event> _markedDateMap;

  final List<String> ltDays = ['Sk', 'Pr', 'An', 'Tr', 'Kt', 'Pn', 'Št'];
  final List<String> ltMonths = [
    'Sausis',
    'Vasaris',
    'Kovas',
    'Balandis',
    'Gegužė',
    'Birželis',
    'Liepa',
    'Rugpjūtis',
    'Rugsėjis',
    'Spalis',
    'Lapkritis',
    'Gruodis',
  ];

  @override
  void initState() {
    super.initState();
    _markedDateMap = EventList<Event>(events: {});
    _loadEventsFromDatabase();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!_isSubscribed) {
      final route = ModalRoute.of(context);
      if (route is PageRoute) {
        routeObserver.subscribe(this, route);
        _isSubscribed = true;
      }
    }
  }

  @override
  void didPopNext() {
    _loadEventsFromDatabase();
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }

  DateTime _dateOnly(DateTime date) {
    return DateTime(date.year, date.month, date.day);
  }

  CalendarEventType? _eventTypeFromTitle(String? title) {
    switch (title) {
      case 'Treniruotė':
        return CalendarEventType.training;
      case 'Turnyras':
        return CalendarEventType.tournament;
      case 'Čempionatas':
        return CalendarEventType.championship;
      default:
        return null;
    }
  }

  CalendarEventType? _eventTypeFromDatabase(String? value) {
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

  String _eventTypeValue(CalendarEventType type) {
    switch (type) {
      case CalendarEventType.training:
        return 'treniruote';
      case CalendarEventType.tournament:
        return 'turnyras';
      case CalendarEventType.championship:
        return 'cempionatas';
    }
  }

  String _eventTitle(CalendarEventType type) {
    switch (type) {
      case CalendarEventType.training:
        return 'Treniruotė';
      case CalendarEventType.tournament:
        return 'Turnyras';
      case CalendarEventType.championship:
        return 'Čempionatas';
    }
  }

  Widget _eventIcon(CalendarEventType type) {
    switch (type) {
      case CalendarEventType.training:
        return Container(
          decoration: const BoxDecoration(
            color: Colors.blue,
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.fitness_center, color: Colors.white, size: 16),
        );
      case CalendarEventType.tournament:
        return Container(
          decoration: const BoxDecoration(
            color: Colors.red,
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.emoji_events, color: Colors.white, size: 16),
        );
      case CalendarEventType.championship:
        return Container(
          decoration: const BoxDecoration(
            color: Colors.orange,
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.workspace_premium,
            color: Colors.white,
            size: 16,
          ),
        );
    }
  }

  Event _calendarEventFromType({
    required int id,
    required DateTime day,
    required CalendarEventType type,
  }) {
    return Event(
      id: id,
      date: _dateOnly(day),
      title: _eventTitle(type),
      description: _eventTypeValue(type),
      icon: _eventIcon(type),
    );
  }

  Event _diaryEvent({
    required int id,
    required DateTime day,
  }) {
    return Event(
      id: id,
      date: _dateOnly(day),
      title: 'Dienorastis uzpildytas',
      description: 'dienorastis',
      icon: Container(
        decoration: const BoxDecoration(
          color: Colors.green,
          shape: BoxShape.circle,
        ),
        child: const Icon(Icons.edit_note, color: Colors.white, size: 16),
      ),
    );
  }

  bool _eventAlreadyExists(DateTime day, String title) {
    final events = _markedDateMap.getEvents(day);
    return events.any((event) => event.title == title);
  }

  int? _stressDaysUntilEvent(DateTime day) {
    final normalizedDay = _dateOnly(day);
    int? closestStressDay;

    for (final entry in _markedDateMap.events.entries) {
      final eventDay = _dateOnly(entry.key);
      final daysUntilEvent = eventDay.difference(normalizedDay).inDays;

      if (daysUntilEvent < 1 || daysUntilEvent > _stressHighlightDays) {
        continue;
      }

      final hasStressfulEvent = entry.value.any((event) {
        final type = _eventTypeFromTitle(event.title);
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

  Color? _stressHighlightColor(DateTime day) {
    switch (_stressDaysUntilEvent(day)) {
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

  Widget? _buildStressDay(
    bool isSelectedDay,
    bool isToday,
    bool isPrevMonthDay,
    TextStyle textStyle,
    bool isNextMonthDay,
    DateTime day,
  ) {
    final highlightColor = _stressHighlightColor(day);
    if (highlightColor == null || isPrevMonthDay || isNextMonthDay) {
      return null;
    }

    final foregroundColor = isSelectedDay || isToday
        ? Colors.white
        : textStyle.color ?? Colors.black;

    return Container(
      margin: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: isSelectedDay
            ? const Color.fromRGBO(167, 139, 250, 1)
            : highlightColor,
        shape: BoxShape.circle,
        border: isToday && !isSelectedDay
            ? Border.all(color: Colors.deepPurpleAccent, width: 2)
            : null,
      ),
      alignment: Alignment.center,
      child: Text(
        '${day.day}',
        style: textStyle.copyWith(
          color: foregroundColor,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Future<void> _loadEventsFromDatabase() async {
    final user = supabase.auth.currentUser;

    if (user == null) {
      if (!mounted) return;
      setState(() {
        _isLoadingEvents = false;
      });
      return;
    }

    try {
      final response = await supabase
          .from('events')
          .select('id, event_type, event_date')
          .eq('user_id', user.id)
          .order('event_date');

      final events = <DateTime, List<Event>>{};

      for (final row in response) {
        final eventId = row['id'] as int?;
        final eventType = _eventTypeFromDatabase(row['event_type'] as String?);
        final eventDateRaw = row['event_date'] as String?;

        if (eventId == null || eventType == null || eventDateRaw == null) {
          continue;
        }

        final eventDay = _dateOnly(DateTime.parse(eventDateRaw).toLocal());
        events.putIfAbsent(eventDay, () => []);
        events[eventDay]!.add(
          _calendarEventFromType(
            id: eventId,
            day: eventDay,
            type: eventType,
          ),
        );
      }

      try {
        final diaryResponse = await supabase
            .from('dienorastis')
            .select('id, entry_date')
            .eq('user_id', user.id)
            .order('entry_date');

        for (final row in diaryResponse) {
          final rawDiaryId = row['id'];
          final diaryDateRaw = row['entry_date'] as String?;

          if (rawDiaryId == null || diaryDateRaw == null) {
            continue;
          }

          final diaryId = rawDiaryId.toString().hashCode;

          final diaryDay = _dateOnly(DateTime.parse(diaryDateRaw).toLocal());
          events.putIfAbsent(diaryDay, () => []);

          final alreadyMarked = events[diaryDay]!.any(
            (event) => event.description == 'dienorastis',
          );

          if (!alreadyMarked) {
            events[diaryDay]!.add(
              _diaryEvent(
                id: diaryId,
                day: diaryDay,
              ),
            );
          }
        }
      } catch (_) {}

      if (!mounted) return;
      setState(() {
        _markedDateMap = EventList<Event>(events: events);
        _isLoadingEvents = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _isLoadingEvents = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Nepavyko užkrauti kalendoriaus įvykių: $e')),
      );
    }
  }

  Future<void> _addSingleEventToDatabase({
    required DateTime day,
    required CalendarEventType type,
  }) async {
    final user = supabase.auth.currentUser;
    if (user == null) return;

    final inserted = await supabase
        .from('events')
        .insert({
          'user_id': user.id,
          'event_type': _eventTypeValue(type),
          'event_date': day.toIso8601String(),
        })
        .select('id, event_type, event_date')
        .single();

    final insertedId = inserted['id'] as int;
    final insertedType =
        _eventTypeFromDatabase(inserted['event_type'] as String?) ?? type;
    final insertedDate = DateTime.parse(inserted['event_date'] as String)
        .toLocal();

    _markedDateMap.add(
      _dateOnly(insertedDate),
      _calendarEventFromType(
        id: insertedId,
        day: insertedDate,
        type: insertedType,
      ),
    );
  }

  Future<int> _addRecurringEventsToDatabase({
    required DateTime startDate,
    required DateTime endDate,
    required List<int> weekdays,
    required CalendarEventType type,
  }) async {
    final user = supabase.auth.currentUser;
    if (user == null) return 0;

    final payload = <Map<String, dynamic>>[];
    final title = _eventTitle(type);
    DateTime current = _dateOnly(startDate);
    final last = _dateOnly(endDate);

    while (!current.isAfter(last)) {
      if (weekdays.contains(current.weekday) &&
          !_eventAlreadyExists(current, title)) {
        payload.add({
          'user_id': user.id,
          'event_type': _eventTypeValue(type),
          'event_date': current.toIso8601String(),
        });
      }

      current = current.add(const Duration(days: 1));
    }

    if (payload.isEmpty) {
      return 0;
    }

    final insertedRows = await supabase
        .from('events')
        .insert(payload)
        .select('id, event_type, event_date');

    for (final row in insertedRows) {
      final eventId = row['id'] as int?;
      final eventType = _eventTypeFromDatabase(row['event_type'] as String?);
      final eventDateRaw = row['event_date'] as String?;

      if (eventId == null || eventType == null || eventDateRaw == null) {
        continue;
      }

      final eventDay = _dateOnly(DateTime.parse(eventDateRaw).toLocal());
      _markedDateMap.add(
        eventDay,
        _calendarEventFromType(
          id: eventId,
          day: eventDay,
          type: eventType,
        ),
      );
    }

    return insertedRows.length;
  }

  Future<void> _showAddEventDialog(DateTime selectedDay) async {
    CalendarEventType? chosenType;
    bool isRecurring = false;
    DateTime recurrenceEndDate = selectedDay.add(const Duration(days: 30));
    final Set<int> selectedWeekdays = {};

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Pridėti įvykį'),
          content: StatefulBuilder(
            builder: (context, setDialogState) {
              return SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    RadioListTile<CalendarEventType>(
                      title: const Text('Treniruotė'),
                      value: CalendarEventType.training,
                      groupValue: chosenType,
                      onChanged: (value) {
                        setDialogState(() {
                          chosenType = value;
                        });
                      },
                    ),
                    RadioListTile<CalendarEventType>(
                      title: const Text('Turnyras'),
                      value: CalendarEventType.tournament,
                      groupValue: chosenType,
                      onChanged: (value) {
                        setDialogState(() {
                          chosenType = value;
                        });
                      },
                    ),
                    RadioListTile<CalendarEventType>(
                      title: const Text('Čempionatas'),
                      value: CalendarEventType.championship,
                      groupValue: chosenType,
                      onChanged: (value) {
                        setDialogState(() {
                          chosenType = value;
                        });
                      },
                    ),
                    const Divider(),
                    CheckboxListTile(
                      title: const Text('Kartoti kas savaitę'),
                      value: isRecurring,
                      onChanged: (value) {
                        setDialogState(() {
                          isRecurring = value ?? false;
                          if (isRecurring && selectedWeekdays.isEmpty) {
                            selectedWeekdays.add(selectedDay.weekday);
                          }
                        });
                      },
                    ),
                    if (isRecurring) ...[
                      const SizedBox(height: 8),
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Kartoti:',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      CheckboxListTile(
                        title: const Text('Pirmadienį'),
                        value: selectedWeekdays.contains(DateTime.monday),
                        onChanged: (value) {
                          setDialogState(() {
                            value == true
                                ? selectedWeekdays.add(DateTime.monday)
                                : selectedWeekdays.remove(DateTime.monday);
                          });
                        },
                      ),
                      CheckboxListTile(
                        title: const Text('Antradienį'),
                        value: selectedWeekdays.contains(DateTime.tuesday),
                        onChanged: (value) {
                          setDialogState(() {
                            value == true
                                ? selectedWeekdays.add(DateTime.tuesday)
                                : selectedWeekdays.remove(DateTime.tuesday);
                          });
                        },
                      ),
                      CheckboxListTile(
                        title: const Text('Trečiadienį'),
                        value: selectedWeekdays.contains(DateTime.wednesday),
                        onChanged: (value) {
                          setDialogState(() {
                            value == true
                                ? selectedWeekdays.add(DateTime.wednesday)
                                : selectedWeekdays.remove(DateTime.wednesday);
                          });
                        },
                      ),
                      CheckboxListTile(
                        title: const Text('Ketvirtadienį'),
                        value: selectedWeekdays.contains(DateTime.thursday),
                        onChanged: (value) {
                          setDialogState(() {
                            value == true
                                ? selectedWeekdays.add(DateTime.thursday)
                                : selectedWeekdays.remove(DateTime.thursday);
                          });
                        },
                      ),
                      CheckboxListTile(
                        title: const Text('Penktadienį'),
                        value: selectedWeekdays.contains(DateTime.friday),
                        onChanged: (value) {
                          setDialogState(() {
                            value == true
                                ? selectedWeekdays.add(DateTime.friday)
                                : selectedWeekdays.remove(DateTime.friday);
                          });
                        },
                      ),
                      CheckboxListTile(
                        title: const Text('Šeštadienį'),
                        value: selectedWeekdays.contains(DateTime.saturday),
                        onChanged: (value) {
                          setDialogState(() {
                            value == true
                                ? selectedWeekdays.add(DateTime.saturday)
                                : selectedWeekdays.remove(DateTime.saturday);
                          });
                        },
                      ),
                      CheckboxListTile(
                        title: const Text('Sekmadienį'),
                        value: selectedWeekdays.contains(DateTime.sunday),
                        onChanged: (value) {
                          setDialogState(() {
                            value == true
                                ? selectedWeekdays.add(DateTime.sunday)
                                : selectedWeekdays.remove(DateTime.sunday);
                          });
                        },
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Text('Iki: '),
                          TextButton(
                            onPressed: () async {
                              final picked = await showDatePicker(
                                context: context,
                                initialDate: recurrenceEndDate,
                                firstDate: selectedDay,
                                lastDate: DateTime(2100),
                                locale: const Locale('lt', 'LT'),
                              );
                              if (picked != null) {
                                setDialogState(() {
                                  recurrenceEndDate = picked;
                                });
                              }
                            },
                            child: Text(
                              '${recurrenceEndDate.day}-${recurrenceEndDate.month}-${recurrenceEndDate.year}',
                            ),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              );
            },
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Atšaukti'),
            ),
            ElevatedButton(
              onPressed: () async {
                if (chosenType == null) return;

                final day = _dateOnly(selectedDay);

                try {
                  if (isRecurring) {
                    if (selectedWeekdays.isEmpty) return;

                    final insertedCount = await _addRecurringEventsToDatabase(
                      startDate: day,
                      endDate: recurrenceEndDate,
                      weekdays: selectedWeekdays.toList(),
                      type: chosenType!,
                    );

                    if (!mounted) return;
                    setState(() {});
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          insertedCount > 0
                              ? 'Pasikartojantys įvykiai išsaugoti'
                              : 'Tokie pasikartojantys įvykiai jau egzistuoja',
                        ),
                      ),
                    );
                  } else {
                    final title = _eventTitle(chosenType!);

                    if (_eventAlreadyExists(day, title)) {
                      if (!mounted) return;
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Toks įvykis šiai dienai jau egzistuoja'),
                        ),
                      );
                      return;
                    }

                    await _addSingleEventToDatabase(
                      day: day,
                      type: chosenType!,
                    );

                    if (!mounted) return;
                    setState(() {});
                  }

                  if (!mounted) return;
                  Navigator.pop(context);
                } catch (e) {
                  if (!mounted) return;
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Nepavyko išsaugoti įvykio: $e')),
                  );
                }
              },
              child: const Text('Išsaugoti'),
            ),
          ],
        );
      },
    );
  }

  List<Event> _getEventsForDay(DateTime date) {
    return _markedDateMap.getEvents(_dateOnly(date));
  }

  Future<void> _deleteEvent(DateTime date, Event event) async {
    final day = _dateOnly(date);

    if (event.description == 'dienorastis') {
      return;
    }

    try {
      if (event.id != null) {
        await supabase.from('events').delete().eq('id', event.id!);
      }

      if (!mounted) return;
      setState(() {
        final events = List<Event>.from(_markedDateMap.getEvents(day));
        events.remove(event);

        _markedDateMap = EventList<Event>(events: {
          ..._markedDateMap.events,
          day: events,
        });

        if (events.isEmpty) {
          _markedDateMap.events.remove(day);
        }
      });
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Nepavyko ištrinti įvykio: $e')),
      );
    }
  }

  Widget _buildCalendarBody() {
    final selectedEvents = _selectedDate != null
        ? _getEventsForDay(_selectedDate!)
        : <Event>[];

    if (_isLoadingEvents) {
      return const Center(child: CircularProgressIndicator());
    }

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_left),
                  onPressed: () {
                    setState(() {
                      _currentDate = DateTime(
                        _currentDate.year,
                        _currentDate.month - 1,
                      );
                    });
                  },
                ),
                Text(
                  '${ltMonths[_currentDate.month - 1]} ${_currentDate.year}',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.arrow_right),
                  onPressed: () {
                    setState(() {
                      _currentDate = DateTime(
                        _currentDate.year,
                        _currentDate.month + 1,
                      );
                    });
                  },
                ),
              ],
            ),
          ),
          CalendarCarousel<Event>(
            onDayPressed: (date, events) {
              setState(() {
                _selectedDate = _dateOnly(date);
                _currentDate = _dateOnly(date);
              });
            },
            customDayBuilder: (
              isSelectable,
              index,
              isSelectedDay,
              isToday,
              isPrevMonthDay,
              textStyle,
              isNextMonthDay,
              isThisMonthDay,
              day,
            ) {
              return _buildStressDay(
                isSelectedDay,
                isToday,
                isPrevMonthDay,
                textStyle,
                isNextMonthDay,
                day,
              );
            },
            customWeekDayBuilder: (int index, String day) {
              return Expanded(
                child: Center(
                  child: Text(
                    ltDays[index],
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              );
            },
            selectedDateTime: _selectedDate,
            targetDateTime: _currentDate,
            markedDatesMap: _markedDateMap,
            markedDateShowIcon: true,
            markedDateIconMaxShown: 3,
            markedDateMoreShowTotal: false,
            thisMonthDayBorderColor: Colors.grey,
            weekendTextStyle: const TextStyle(color: Colors.red),
            headerTextStyle: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            selectedDayButtonColor: const Color.fromRGBO(167, 139, 250, 1),
            todayButtonColor: Colors.deepPurpleAccent,
            daysTextStyle: const TextStyle(color: Colors.black),
            showHeader: false,
            weekFormat: false,
            height: 420,
            iconColor: const Color.fromRGBO(167, 139, 250, 1),
          ),
          const SizedBox(height: 20),
          Text(
            _selectedDate != null
                ? 'Pasirinkta data: ${_selectedDate!.day}-${_selectedDate!.month}-${_selectedDate!.year}'
                : 'Pasirinkite datą',
            style: const TextStyle(fontSize: 18),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: selectedEvents.isEmpty
                ? const Center(
                    child: Text(
                      'Šiai dienai nėra įvykių',
                      style: TextStyle(fontSize: 16),
                    ),
                  )
                : ListView.builder(
                    itemCount: selectedEvents.length,
                    itemBuilder: (context, index) {
                      final event = selectedEvents[index];
                      final isDiaryEvent = event.description == 'dienorastis';
                      return Card(
                        child: ListTile(
                          leading: event.icon,
                          title: Text(event.title ?? ''),
                          trailing: isDiaryEvent
                              ? null
                              : IconButton(
                                  icon: const Icon(Icons.delete),
                                  onPressed: () {
                                    _deleteEvent(_selectedDate!, event);
                                  },
                                ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color.fromRGBO(167, 139, 250, 1),
        title: const Text(
          'Kalendorius',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 0.0),
            child: Image.asset(
              'assets/brain_logo_goodremakecolor.png',
              height: 60,
            ),
          ),
        ],
      ),
      floatingActionButton: _selectedDate == null
          ? null
          : FloatingActionButton(
              backgroundColor: const Color.fromRGBO(167, 139, 250, 1),
              onPressed: () => _showAddEventDialog(_selectedDate!),
              child: const Icon(Icons.add),
            ),
      body: _buildCalendarBody(),
    );
  }
}
