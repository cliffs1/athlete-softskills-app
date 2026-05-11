import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CoachMessageNotificationWidget extends StatefulWidget {
  const CoachMessageNotificationWidget({super.key});

  @override
  State<CoachMessageNotificationWidget> createState() =>
      _CoachMessageNotificationWidgetState();
}

class _CoachMessageNotificationWidgetState
    extends State<CoachMessageNotificationWidget> {
  final Set<String> hiddenMessageKeys = {};

  SupabaseClient get supabase => Supabase.instance.client;

  String _messageKey(Map<String, dynamic> message) {
    final id = message['id'];
    if (id != null) return id.toString();

    return [
      message['treneris_id'],
      message['zaidejas_id'],
      message['tekstas'],
    ].join('|');
  }

  Future<void> _dismissMessage(Map<String, dynamic> message) async {
    final key = _messageKey(message);

    setState(() {
      hiddenMessageKeys.add(key);
    });

    try {
      final messageId = message['id'];
      var query = supabase.from('zinutes').update({'ar_perskaite': true});

      if (messageId != null) {
        query = query.eq('id', messageId);
      } else {
        final user = supabase.auth.currentUser;
        if (user == null) return;

        query = query
            .eq('zaidejas_id', user.id)
            .eq('treneris_id', message['treneris_id'])
            .eq('tekstas', message['tekstas'])
            .eq('ar_perskaite', false);
      }

      await query;
    } catch (e) {
      if (!mounted) return;

      setState(() {
        hiddenMessageKeys.remove(key);
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Klaida: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = supabase.auth.currentUser;
    if (user == null) return const SizedBox();

    return StreamBuilder<List<Map<String, dynamic>>>(
      stream: supabase
          .from('zinutes')
          .stream(primaryKey: ['id'])
          .eq('zaidejas_id', user.id),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const SizedBox();
        }

        final messages = snapshot.data!
            .where(
              (message) =>
                  message['ar_perskaite'] == false &&
                  !hiddenMessageKeys.contains(_messageKey(message)),
            )
            .toList();
        if (messages.isEmpty) {
          return const SizedBox();
        }

        final message = messages.last;
        final text = (message['tekstas'] ?? '').toString();
        final unreadCount = messages.length;

        return Container(
          width: 350,
          margin: const EdgeInsets.symmetric(horizontal: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color.fromRGBO(245, 240, 255, 1),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color.fromRGBO(167, 139, 250, 1)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 6,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(
                Icons.notifications_active_outlined,
                color: Color.fromRGBO(124, 92, 210, 1),
                size: 30,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      unreadCount > 1
                          ? 'Naujos trenerio zinutes ($unreadCount)'
                          : 'Nauja trenerio zinute',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      text,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 15),
                    ),
                  ],
                ),
              ),
              IconButton(
                tooltip: 'Pazymeti kaip perskaityta',
                icon: const Icon(Icons.close, size: 20),
                onPressed: () => _dismissMessage(message),
              ),
            ],
          ),
        );
      },
    );
  }
}
