import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:supabase_flutter/supabase_flutter.dart';

class CoachResponse {
  final String summary;
  final String analysis;
  final String tomorrowTip;

  CoachResponse({
    required this.summary,
    required this.analysis,
    required this.tomorrowTip,
  });
}

class AiCoachService {
  static const String _apiUrl = 'https://api.groq.com/openai/v1/chat/completions';

  static Future<String> _getApiKey() async {
    final supabase = Supabase.instance.client;
    final response = await supabase
        .from('config_lentele')
        .select('value')
        .eq('key', 'groq_api_key')
        .single();
    return response['value'] as String;
  }

  static Future<CoachResponse> analyzeEntry({
    required String diaryText,
  }) async {
    final apiKey = await _getApiKey();

    final prompt = '''
Tu esi profesionalus sportininkų psichologinis coach\'as.
Kalbi TAISYKLINGA lietuvių kalba su taisyklingomis galūnėmis ir linksniais.
Kreipiesi į sportininką TU forma (ne JIS/JI forma).

Sportininkas šiandien atsakė į klausimus apie savo dieną:
"$diaryText"

Grąžink TIKTAI JSON be jokio papildomo teksto ar komentarų:
{
  "summary": "vienas trumpas sakinys apibendrinantis dienos nuotaiką (pvz. Šiandien tavo diena buvo...)",
  "analysis": "2-3 sakiniai. Pradėk žodžiu Tavo. Aptark konkrečius minkštuosius įgūdžius: emocijų valdymą, bendravimą, lyderystę, pasitikėjimą savimi.",
  "tomorrow_tip": "vienas konkretus praktinis patarimas rytojui. Pradėk veiksmažodžiu (pvz. Išbandyk..., Stebėk..., Prieš...)"
}''';

    final response = await http.post(
      Uri.parse(_apiUrl),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $apiKey',
      },
      body: jsonEncode({
        'model': 'llama-3.3-70b-versatile',
        'messages': [
          {'role': 'user', 'content': prompt}
        ],
        'max_tokens': 800,
        'temperature': 0.7,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('API klaida: ${response.statusCode}');
    }

    final data = jsonDecode(response.body);
    final text = data['choices'][0]['message']['content'] as String;
    final clean = text.replaceAll(RegExp(r'```json|```'), '').trim();
    final json = jsonDecode(clean);

    return CoachResponse(
      summary: json['summary'],
      analysis: json['analysis'],
      tomorrowTip: json['tomorrow_tip'],
    );
  }
}