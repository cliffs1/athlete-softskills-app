import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart'
    show CalendarCarousel;
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/classes/event_list.dart';

enum CalendarEventType {
  training,
  tournament,
  championship,
}

class Calendarpage extends StatefulWidget {
  const Calendarpage({super.key});

  @override
  State<Calendarpage> createState() => _CalendarpageState();
}

class _CalendarpageState extends State<Calendarpage> {
  DateTime _currentDate = DateTime.now();
  DateTime? _selectedDate = DateTime.now();

  late EventList<Event> _markedDateMap;
  final List<String> ltDays = ['Sk', 'Pr', 'An', 'Tr', 'Kt', 'Pn', 'Št'];
  List<String> ltMonths = [
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
  }

  DateTime _dateOnly(DateTime date) {
    return DateTime(date.year, date.month, date.day);
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
          child: const Icon(Icons.workspace_premium, color: Colors.white, size: 16),
        );
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
  bool _eventAlreadyExists(DateTime day, String title) {
    final events = _markedDateMap.getEvents(day);
    return events.any((event) => event.title == title);
  }
  void _addRecurringEvent({
    required DateTime startDate,
    required DateTime endDate,
    required List<int> weekdays,
    required CalendarEventType type,
  }) {
    DateTime current = _dateOnly(startDate);
    final last = _dateOnly(endDate);
    final title = _eventTitle(type);

    while (!current.isAfter(last)) {
      if (weekdays.contains(current.weekday) &&
          !_eventAlreadyExists(current, title)) {
        _markedDateMap.add(
          current,
          Event(
            date: current,
            title: title,
            icon: _eventIcon(type),
          ),
        );
      }

      current = current.add(const Duration(days: 1));
    }
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
                      title: const Text('Treiniruotė'),
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
                      title: const Text('Kartoti kas savaitė'),
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
              onPressed: () {
                if (chosenType == null) return;

                final day = _dateOnly(selectedDay);

                setState(() {
                  if (isRecurring) {
                    if (selectedWeekdays.isEmpty) return;

                    _addRecurringEvent(
                      startDate: day,
                      endDate: recurrenceEndDate,
                      weekdays: selectedWeekdays.toList(),
                      type: chosenType!,
                    );
                  } else {
                    final title = _eventTitle(chosenType!);

                    if (!_eventAlreadyExists(day, title)) {
                      _markedDateMap.add(
                        day,
                        Event(
                          date: day,
                          title: title,
                          icon: _eventIcon(chosenType!),
                        ),
                      );
                    }
                  }
                });

                Navigator.pop(context);
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

  void _deleteEvent(DateTime date, Event event) {
    final day = _dateOnly(date);

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
  }

  @override
  Widget build(BuildContext context) {
    final selectedEvents = _selectedDate != null
        ? _getEventsForDay(_selectedDate!)
        : <Event>[];

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color.fromRGBO(167, 139, 250, 1),
        title: const Text(
          "Kalendorius",
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
      body: Padding(
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
                        return Card(
                          child: ListTile(
                            leading: event.icon,
                            title: Text(event.title ?? ''),
                            trailing: IconButton(
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
      ),
    );
  }
}