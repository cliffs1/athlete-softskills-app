import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:supabase_flutter/supabase_flutter.dart';

class CoachResponse {
  final String summary;
  final String analysis;
  final String tomorrowTip;

  const CoachResponse({
    required this.summary,
    required this.analysis,
    required this.tomorrowTip,
  });
}

class AiCoachService {
  static const String _apiUrl = 'https://api.groq.com/openai/v1/chat/completions';
  static const CoachResponse _fallbackResponse = CoachResponse(
    summary: 'Šiandienos įrašas išsaugotas.',
    analysis:
        'Tavo atsakymai padeda pastebėti, kaip jautiesi ir kas šiandien buvo svarbiausia. Verta atkreipti dėmesį į tai, kas tau padėjo išlaikyti pastangas, bendravimą ar emocinį stabilumą. Pasirink vieną konkretų dalyką, kurį rytoj nori pakartoti arba pagerinti.',
    tomorrowTip:
        'Rytoj prieš treniruotę ar rungtynes trumpai įvardyk vieną aiškų tikslą ir po veiklos įvertink, kas tau padėjo jo siekti.',
  );

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
Tu esi lietuvių kalba rašantis sporto psichologijos asistentas.
Tavo užduotis - parašyti trumpą, aiškią ir logišką sportininko dienoraščio analizę.

Taisyklės:
- Rašyk tik taisyklinga lietuvių kalba.
- Kreipkis į sportininką "tu" forma.
- Remkis tik pateiktu dienoraščiu. Nekurk faktų, kurių jame nėra.
- Nekartok visų klausimų ir atsakymų.
- Jei dienoraštyje yra pirmo asmens formos, perrašyk jas antru asmeniu: "bandžiau" -> "bandei", "stengiausi" -> "stengeisi".
- Jei informacijos mažai, rašyk atsargiai: "panašu", "gali būti", "verta pastebėti".
- Nevartok sudėtingų ar dirbtinių frazių.
- Nevartok netaisyklingos formos "jaučiesi". Rašyk "jautiesi".
- Nevartok netaisyklingos formos "jautis", kai kalbi apie savijautą. Rašyk "jaustis".
- Derink linksnius: rašyk "teigiamomis mintimis", ne "teigiamais mintimis".
- Nekalbėk apie diagnozes, ligas ar terapiją.
- Atsakymas turi būti konkretus sportininkui, bet ne ilgesnis nei prašoma.

Dienoraštis:
"""
$diaryText
"""

Grąžink tik validų JSON be Markdown, be kodo bloko ir be papildomo teksto:
{
  "summary": "1-2 sakiniai apie bendrą dienos kryptį.",
  "analysis": "3-4 aiškūs sakiniai apie emocijas, bendravimą, pastangas arba pasitikėjimą pagal tai, kas matosi dienoraštyje.",
  "tomorrow_tip": "2-3 konkretūs sakiniai su praktišku patarimu rytojui."
}''';

    try {
      final response = await http.post(
        Uri.parse(_apiUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $apiKey',
        },
        body: jsonEncode({
          'model': 'llama-3.3-70b-versatile',
          'messages': [
            {'role': 'user', 'content': prompt},
          ],
          'max_tokens': 650,
          'temperature': 0.2,
        }),
      );

      if (response.statusCode != 200) {
        return _fallbackResponse;
      }

      final data = jsonDecode(response.body);
      final text = data['choices'][0]['message']['content'] as String;
      final json = jsonDecode(_cleanJsonText(text));

      return CoachResponse(
        summary: _safeText(json['summary'], _fallbackResponse.summary),
        analysis: _safeText(json['analysis'], _fallbackResponse.analysis),
        tomorrowTip: _safeText(
          json['tomorrow_tip'],
          _fallbackResponse.tomorrowTip,
        ),
      );
    } catch (e) {
      return _fallbackResponse;
    }
  }

  static String _cleanJsonText(String value) {
    final clean = value.replaceAll(RegExp(r'```json|```'), '').trim();
    final start = clean.indexOf('{');
    final end = clean.lastIndexOf('}');
    if (start == -1 || end == -1 || end <= start) return clean;
    return clean.substring(start, end + 1);
  }

  static String _safeText(dynamic value, String fallback) {
    final text = value?.toString().trim();
    if (text == null || text.isEmpty) return fallback;
    if (text.length > 1400) return fallback;
    return _fixCommonLithuanianIssues(text);
  }

  static String _fixCommonLithuanianIssues(String value) {
    return value
        .replaceAll('jaučiesi', 'jautiesi')
        .replaceAll('Jaučiesi', 'Jautiesi')
        .replaceAll(RegExp(r'\bjautis\b'), 'jaustis')
        .replaceAll(RegExp(r'\bJautis\b'), 'Jaustis')
        .replaceAll('teigiamais mintimis', 'teigiamomis mintimis')
        .replaceAll('Teigiamais mintimis', 'Teigiamomis mintimis')
        .replaceAll('bandžiau labai mažai pritaikyti',
            'bandei labai mažai pritaikyti')
        .replaceAll('Bandžiau labai mažai pritaikyti',
            'Bandei labai mažai pritaikyti')
        .replaceAll(RegExp(r'\bbandžiau\b'), 'bandei')
        .replaceAll(RegExp(r'\bBandžiau\b'), 'Bandei')
        .replaceAll(RegExp(r'\bstengiausi\b'), 'stengeisi')
        .replaceAll(RegExp(r'\bStengiausi\b'), 'Stengeisi')
        .replaceAll(RegExp(r'\btaikiau\b'), 'taikei')
        .replaceAll(RegExp(r'\bTaikiau\b'), 'Taikei');
  }
}
