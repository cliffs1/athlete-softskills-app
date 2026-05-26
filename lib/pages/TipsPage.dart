import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../data/article_links.dart';

class TipsPage extends StatefulWidget {
  const TipsPage({super.key});

  @override
  State<TipsPage> createState() => _TipsPageState();
}

class _TipsPageState extends State<TipsPage> {
  final supabase = Supabase.instance.client;
  late final Future<Map<String, dynamic>?> todayDiaryAnalysis;

  @override
  void initState() {
    super.initState();
    todayDiaryAnalysis = loadTodayDiaryAnalysis();
  }

  Future<Map<String, dynamic>?> loadTodayDiaryAnalysis() async {
    final user = supabase.auth.currentUser;
    if (user == null) return null;

    final today = DateTime.now().toIso8601String().split('T')[0];
    final response = await supabase
        .from('dienorastis')
        .select('ai_analysis, ai_tip')
        .eq('user_id', user.id)
        .eq('entry_date', today)
        .maybeSingle();

    if (response == null) return null;

    final analysis = response['ai_analysis']?.toString().trim();
    final tip = response['ai_tip']?.toString().trim();
    if ((analysis == null || analysis.isEmpty) && (tip == null || tip.isEmpty)) {
      return null;
    }

    return Map<String, dynamic>.from(response);
  }

  Widget buildTipCard(String title, String description) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.lightbulb, color: Colors.orange),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  description,
                  style: const TextStyle(fontSize: 14),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSectionTitle(String title) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget buildTodayAnalysisCard(Map<String, dynamic> diary) {
    final analysis = diary['ai_analysis']?.toString().trim();
    final tip = diary['ai_tip']?.toString().trim();

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color.fromRGBO(167, 139, 250, 0.08),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color.fromRGBO(167, 139, 250, 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.psychology, color: Color.fromRGBO(167, 139, 250, 1)),
              SizedBox(width: 8),
              Text(
                "Šiandienos AI analizė",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          if (analysis != null && analysis.isNotEmpty) ...[
            const SizedBox(height: 12),
            Text(analysis, style: const TextStyle(fontSize: 14, height: 1.5)),
          ],
          if (tip != null && tip.isNotEmpty) ...[
            const SizedBox(height: 16),
            const Text(
              "Rytojaus tikslas",
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Color.fromRGBO(56, 189, 248, 1),
              ),
            ),
            const SizedBox(height: 6),
            Text(tip, style: const TextStyle(fontSize: 14, height: 1.5)),
          ],
        ],
      ),
    );
  }

  Widget buildTodayAnalysisSection() {
    return FutureBuilder<Map<String, dynamic>?>(
      future: todayDiaryAnalysis,
      builder: (context, snapshot) {
        if (!snapshot.hasData || snapshot.data == null) {
          return const SizedBox();
        }

        return Padding(
          padding: const EdgeInsets.only(bottom: 24),
          child: buildTodayAnalysisCard(snapshot.data!),
        );
      },
    );
  }

  Future<void> openArticle(BuildContext context, String url) async {
    final uri = Uri.parse(url);
    final isOpened = await launchUrl(
      uri,
      mode: LaunchMode.externalApplication,
    );

    if (!isOpened && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Nepavyko atidaryti straipsnio nuorodos.'),
        ),
      );
    }
  }

  Widget buildArticleCard(BuildContext context, ArticleLink article) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: () => openArticle(context, article.url),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 8,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(Icons.article_outlined, color: Colors.deepPurple),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    article.title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    article.description,
                    style: const TextStyle(fontSize: 14),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    article.url,
                    style: const TextStyle(
                      fontSize: 13,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            const Icon(Icons.open_in_new, size: 18),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color.fromRGBO(167, 139, 250, 1),
        title: const Text(
          "Patarimai",
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
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            buildTodayAnalysisSection(),
            buildSectionTitle("Patarimai"),
            const SizedBox(height: 12),
            buildTipCard(
              "Bendravimas",
              "Stenkitės aktyviai klausytis ir priimti kritiką iš komandos narių.",
            ),
            const SizedBox(height: 12),
            buildTipCard(
              "Susikaupimas",
              "Rungtynių metu svarbu nepasimesti tarp garso ir trikdžių.",
            ),
            const SizedBox(height: 12),
            buildTipCard(
              "Pasitikėjimas",
              "Svarbu neprarasti pasitikėjimo, nors ir nesiseka momente.",
            ),
            const SizedBox(height: 24),
            buildSectionTitle("Straipsniai"),
            const SizedBox(height: 12),
            ...articleLinks.map(
              (article) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: buildArticleCard(context, article),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
