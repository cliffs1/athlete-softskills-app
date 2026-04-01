import 'package:flutter/material.dart';
import 'package:softskills_app/pages/CompetitionReflectionPage.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CompetitionReflectionReminderWidget extends StatefulWidget {
  const CompetitionReflectionReminderWidget({super.key});

  @override
  State<CompetitionReflectionReminderWidget> createState() =>
      _CompetitionReflectionReminderWidgetState();
}

class _CompetitionReflectionReminderWidgetState
    extends State<CompetitionReflectionReminderWidget> {
  final supabase = Supabase.instance.client;

  Map<String, dynamic>? _pendingEvent;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _checkReflectionReminder();
  }

  String _eventTitle(String? eventType) {
    switch (eventType) {
      case 'turnyras':
        return 'Turnyras';
      case 'cempionatas':
        return 'Čempionatas';
      default:
        return 'Varžybos';
    }
  }

  Future<void> _checkReflectionReminder() async {
    final user = supabase.auth.currentUser;

    if (user == null || DateTime.now().hour < 18) {
      if (!mounted) return;
      setState(() {
        _pendingEvent = null;
        _isLoading = false;
      });
      return;
    }

    final now = DateTime.now();
    final startOfDay = DateTime(now.year, now.month, now.day);
    final endOfDay = startOfDay.add(const Duration(days: 1));

    try {
      final events = await supabase
          .from('events')
          .select('id, event_type, event_date')
          .eq('user_id', user.id)
          .inFilter('event_type', ['turnyras', 'cempionatas'])
          .gte('event_date', startOfDay.toIso8601String())
          .lt('event_date', endOfDay.toIso8601String())
          .order('event_date');

      if (events.isEmpty) {
        if (!mounted) return;
        setState(() {
          _pendingEvent = null;
          _isLoading = false;
        });
        return;
      }

      final eventIds = events.map((event) => event['id']).toList();

      final reflections = await supabase
          .from('event_reflections')
          .select('event_id')
          .eq('user_id', user.id)
          .inFilter('event_id', eventIds);

      final completedEventIds = reflections
          .map<int>((reflection) => reflection['event_id'] as int)
          .toSet();

      final pendingEvent = events.cast<Map<String, dynamic>?>().firstWhere(
            (event) => !completedEventIds.contains(event?['id']),
            orElse: () => null,
          );

      if (!mounted) return;
      setState(() {
        _pendingEvent = pendingEvent;
        _isLoading = false;
      });
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _pendingEvent = null;
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading || _pendingEvent == null) {
      return const SizedBox();
    }

    final eventId = _pendingEvent!['id'] as int;
    final eventType = _pendingEvent!['event_type'] as String?;
    final eventDate = DateTime.parse(_pendingEvent!['event_date'] as String)
        .toLocal();

    return GestureDetector(
      onTap: () async {
        final result = await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => CompetitionReflectionPage(
              eventId: eventId,
              eventTitle: _eventTitle(eventType),
              eventDate: eventDate,
            ),
          ),
        );

        if (result == true) {
          await _checkReflectionReminder();
        }
      },
      child: Container(
        width: 350,
        margin: const EdgeInsets.symmetric(horizontal: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color.fromRGBO(238, 242, 255, 1),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color.fromRGBO(199, 210, 254, 1)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            const Icon(Icons.nightlight_round, color: Colors.indigo, size: 30),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                'Laikas vakaro refleksijai po šiandienos ${_eventTitle(eventType).toLowerCase()}',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const Icon(Icons.arrow_forward_ios, size: 16),
          ],
        ),
      ),
    );
  }
}
