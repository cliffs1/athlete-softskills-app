import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_radar_chart/flutter_radar_chart.dart' as radar;
import 'package:softskills_app/widgets/subscription_gate.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Statisticspage extends StatefulWidget {
  final String playerId;
  final bool showAppBar;
  final String? sport;

  const Statisticspage({
    super.key,
    required this.playerId,
    this.showAppBar = true,
    this.sport,
  });

  @override
  State<Statisticspage> createState() => _StatisticspageState();
}

const Map<String, Map<String, String>> kImportantSkills = {
  'Tinklinis': {
    'Socialiniai': 'Komandinis darbas', // Komandinis darbas, Komunikacija, Lyderystė
    'Emociniai': 'Atsakomybė', // Emocijų valdymas, Streso valdymas, Pasitikėjimas savimi, Atsakomybė
    'Kognityviniai': 'Koncentracija', // Koncentracija, Motyvacija, Sprendimų priėmimas
  },
  'Krepšinis': {
    'Socialiniai': 'Komunikacija',
    'Emociniai': 'Emocijų valdymas',
    'Kognityviniai': 'Sprendimų priėmimas',
  },
  'Futbolas': {
    'Socialiniai': 'Lyderystė',
    'Emociniai': 'Pasitikėjimas savimi',
    'Kognityviniai': 'Motyvacija',
  },
};

const Color kImportantColor = Color(0xFFFF9800); // orange

class SkillData {
  final String skill;
  final double currentValue;
  final double weekAgoValue;
  final String category;

  SkillData(this.skill, this.currentValue, this.weekAgoValue, this.category);
}

class SkillFetchResult {
  final List<SkillData> skills;
  final bool hasHistory;

  SkillFetchResult({required this.skills, required this.hasHistory});
}

class _StatisticspageState extends State<Statisticspage> {
  bool showRadar = true;
  final supabase = Supabase.instance.client;
  List<SkillData> skills = [];
  bool loading = true;
  String selectedCategory = 'Socialiniai';
  bool hasHistoryData = false;

  String? get _importantSkill =>
      widget.sport == null ? null : kImportantSkills[widget.sport]?[selectedCategory];

  bool _isImportant(String skillName) => skillName == _importantSkill;

  @override
  void initState() {
    super.initState();
    loadSkills();
  }

  Future<void> loadSkills() async {
    final result = await fetchSkills();
    setState(() {
      skills = result.skills;
      hasHistoryData = result.hasHistory;
      loading = false;
    });
  }

  Future<SkillFetchResult> fetchSkills() async {
    final playerId = widget.playerId;

    final currentResponse = await supabase
        .from('naudotojo_minkstieji')
        .select('fk_minkstieji_gebejimai, svoris, minkstieji_gebejimai(pavadinimas, kategorija)')
        .eq('fk_naudotojas', playerId);

    final weekAgoResponse = await supabase
        .from('naudotojo_minkstieji_history')
        .select('fk_minkstieji_gebejimai, svoris, created_at')
        .eq('fk_naudotojas', playerId)
        .lte(
      'created_at',
      DateTime.now().subtract(const Duration(days: 7)).toIso8601String(),
    )
        .order('created_at', ascending: false);

    final currentData = currentResponse as List;
    final weekAgoData = weekAgoResponse as List;
    final hasHistory = weekAgoData.isNotEmpty;

    final Map<int, double> weekAgoMap = {};
    for (var item in weekAgoData) {
      final skillId = item['fk_minkstieji_gebejimai'];
      weekAgoMap.putIfAbsent(skillId, () => (item['svoris'] as num).toDouble());
    }

    final fetchedSkills = currentData.map((item) {
      final skillId = item['fk_minkstieji_gebejimai'];
      return SkillData(
        item['minkstieji_gebejimai']['pavadinimas'],
        (item['svoris'] as num).toDouble(),
        weekAgoMap[skillId] ?? 0,
        item['minkstieji_gebejimai']['kategorija'],
      );
    }).toList();

    return SkillFetchResult(skills: fetchedSkills, hasHistory: hasHistory);
  }

  List<SkillData> get filteredSkills =>
      skills.where((s) => s.category == selectedCategory).toList();

  Widget buildRadarChart() {
    if (loading || filteredSkills.isEmpty) {
      return const SizedBox(
        height: 250,
        child: Center(child: CircularProgressIndicator()),
      );
    }

    final features = filteredSkills.map((e) {
      return _isImportant(e.skill) ? '★ ${e.skill}' : e.skill;
    }).toList();

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color.fromRGBO(229, 231, 235, 1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: SizedBox(
        height: 250,
        child: radar.RadarChart(
          ticks: const [2, 4, 6, 8, 10],
          features: features,
          data: hasHistoryData
              ? [
            filteredSkills.map((e) => e.weekAgoValue).toList(),
            filteredSkills.map((e) => e.currentValue).toList(),
          ]
              : [
            filteredSkills.map((e) => e.currentValue).toList(),
          ],
          graphColors: hasHistoryData
              ? const [Colors.grey, Colors.blue]
              : const [Colors.blue],
          outlineColor: Colors.grey,
        ),
      ),
    );
  }

  Widget buildBarChart() {
    if (loading || filteredSkills.isEmpty) {
      return const SizedBox(
        height: 250,
        child: Center(child: CircularProgressIndicator()),
      );
    }

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color.fromRGBO(229, 231, 235, 1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: SizedBox(
        height: 250,
        child: BarChart(
          BarChartData(
            maxY: 10,
            barGroups: List.generate(filteredSkills.length, (index) {
              final skill = filteredSkills[index];
              final important = _isImportant(skill.skill);
              final currentBarColor = important ? kImportantColor : Colors.blue;

              return BarChartGroupData(
                x: index,
                barRods: hasHistoryData
                    ? [
                  BarChartRodData(
                    toY: skill.weekAgoValue,
                    width: 8,
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  BarChartRodData(
                    toY: skill.currentValue,
                    width: 8,
                    color: currentBarColor,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ]
                    : [
                  BarChartRodData(
                    toY: skill.currentValue,
                    width: 8,
                    color: currentBarColor,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ],
                barsSpace: 4,
              );
            }),
            titlesData: FlTitlesData(
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  getTitlesWidget: (value, meta) {
                    final i = value.toInt();
                    if (i < 0 || i >= filteredSkills.length) {
                      return const SizedBox();
                    }
                    final skill = filteredSkills[i];
                    final important = _isImportant(skill.skill);
                    return Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Transform.rotate(
                        angle: -0.2,
                        child: Text(
                          skill.skill,
                          style: TextStyle(
                            fontSize: 10,
                            color: important ? kImportantColor : null,
                            fontWeight: important ? FontWeight.bold : null,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              leftTitles: const AxisTitles(
                sideTitles: SideTitles(showTitles: true, reservedSize: 26),
              ),
              topTitles: const AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
              rightTitles: const AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget legendItem(Color color, String text, {bool bold = false}) {
    return Row(
      children: [
        Container(width: 12, height: 12, color: color),
        const SizedBox(width: 6),
        Text(
          text,
          style: TextStyle(fontWeight: bold ? FontWeight.bold : null),
        ),
      ],
    );
  }

  Widget buildLegend() {
    return Wrap(
      spacing: 10,
      runSpacing: 6,
      children: [
        if (hasHistoryData) legendItem(Colors.grey, 'Prieš savaitę'),
        legendItem(Colors.blue, 'Dabar'),
        if (_importantSkill != null)
          legendItem(kImportantColor, 'Svarbus įgūdis: $_importantSkill',
              bold: true),
      ],
    );
  }

  Widget buildChartToggle() {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: () => setState(() => showRadar = true),
            style: ElevatedButton.styleFrom(
              backgroundColor: showRadar
                  ? const Color.fromRGBO(79, 97, 127, 1)
                  : Colors.grey[300],
            ),
            child: const Text(
              'Voratinklio diagrama',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: SubscriptionGate(
            child: ElevatedButton(
              onPressed: () => setState(() => showRadar = false),
              style: ElevatedButton.styleFrom(
                backgroundColor: !showRadar
                    ? const Color.fromRGBO(79, 97, 127, 1)
                    : Colors.grey[300],
              ),
              child: const Text(
                'Stulpelinė diagrama',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white),
              ),
            ),
            fallback: ElevatedButton(
              onPressed: null,
              style: ElevatedButton.styleFrom(backgroundColor: Colors.grey[300]),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.lock_outline, size: 16),
                  SizedBox(width: 6),
                  Flexible(
                    child: Text(
                      'Stulpelinė diagrama',
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildSkillSelector() {
    return SizedBox(
      height: 50,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          buildCategoryButton(label: 'Socialiniai', category: 'Socialiniai'),
          SubscriptionGate(
            child: buildCategoryButton(
                label: 'Emociniai', category: 'Emociniai'),
            fallback: buildLockedCategoryButton('Emociniai'),
          ),
          SubscriptionGate(
            child: buildCategoryButton(
                label: 'Kognityviniai', category: 'Kognityviniai'),
            fallback: buildLockedCategoryButton('Kognityviniai'),
          ),
        ],
      ),
    );
  }

  Widget buildCategoryButton(
      {required String label, required String category}) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: ElevatedButton(
        onPressed: () => setState(() => selectedCategory = category),
        style: ElevatedButton.styleFrom(
          backgroundColor: selectedCategory == category
              ? const Color.fromRGBO(79, 97, 127, 1)
              : Colors.grey[300],
        ),
        child: Text(label, style: const TextStyle(color: Colors.white)),
      ),
    );
  }

  Widget buildLockedCategoryButton(String label) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: ElevatedButton(
        onPressed: null,
        style:
        ElevatedButton.styleFrom(backgroundColor: Colors.grey[300]),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.lock_outline, size: 16),
            const SizedBox(width: 6),
            Text(label),
          ],
        ),
      ),
    );
  }

  Widget buildStatCard(String title, String value1, String value2) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color.fromRGBO(229, 231, 235, 1),
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 8)],
      ),
      child: Column(
        children: [
          Text(title,
              style:
              const TextStyle(color: Color.fromRGBO(11, 18, 32, 1))),
          const SizedBox(height: 4),
          Text(value1,
              style: const TextStyle(
                  fontSize: 22, fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Text(value2,
              style: const TextStyle(
                  fontSize: 22, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  double getAverageAbsoluteChange() {
    if (filteredSkills.isEmpty) return 0;
    return filteredSkills.fold(
        0.0, (sum, s) => sum + (s.currentValue - s.weekAgoValue)) /
        filteredSkills.length;
  }

  double calculatePercentChange(double current, double previous) {
    if (previous == 0) return 0;
    return ((current - previous) / previous) * 100;
  }

  double getAveragePercentChange() {
    if (filteredSkills.isEmpty) return 0;
    return filteredSkills.fold(
        0.0,
            (sum, s) =>
        sum + calculatePercentChange(s.currentValue, s.weekAgoValue)) /
        filteredSkills.length;
  }

  double getCurrentAverage() {
    if (filteredSkills.isEmpty) return 0;
    return filteredSkills.fold(0.0, (sum, s) => sum + s.currentValue) /
        filteredSkills.length;
  }

  double getWeekAgoAverage() {
    if (filteredSkills.isEmpty) return 0;
    return filteredSkills.fold(0.0, (sum, s) => sum + s.weekAgoValue) /
        filteredSkills.length;
  }

  Widget buildStatsRow() {
    return Row(
      children: [
        Expanded(
          child: buildStatCard(
            'Bendras pokytis',
            hasHistoryData
                ? '+${getAverageAbsoluteChange().toStringAsFixed(2)}'
                : 'Nėra istorijos',
            hasHistoryData
                ? '(${getAveragePercentChange().toStringAsFixed(2)}%)'
                : '',
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: buildStatCard(
            'Bendras vidurkis',
            'Dabartinis ${getCurrentAverage().toStringAsFixed(2)}',
            hasHistoryData
                ? 'Prieš savaitė ${getWeekAgoAverage().toStringAsFixed(2)}'
                : '',
          ),
        ),
      ],
    );
  }

  Widget buildSkillBreakdown() {
    return Column(
      children: filteredSkills.map((s) {
        final diff = s.currentValue - s.weekAgoValue;
        final percent =
        s.weekAgoValue == 0 ? 0 : (diff / s.weekAgoValue) * 100;
        final important = _isImportant(s.skill);

        return ListTile(
          title: Row(
            children: [
              if (important) ...[
                const Icon(Icons.star, color: kImportantColor, size: 16),
                const SizedBox(width: 4),
              ],
              Flexible(
                child: Text(
                  s.skill,
                  style: TextStyle(
                    color: important ? kImportantColor : null,
                    fontWeight:
                    important ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              ),
            ],
          ),
          trailing: Text(
            hasHistoryData
                ? '${diff >= 0 ? '+' : ''}${diff.toStringAsFixed(2)} '
                '(${percent.toStringAsFixed(2)}%)'
                : 'Dabartinė reikšmė: ${s.currentValue.toStringAsFixed(2)}',
            style: TextStyle(
              color: important
                  ? kImportantColor
                  : (diff >= 0 ? Colors.green : Colors.red),
              fontWeight:
              important ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildContent() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              buildSkillSelector(),
              const SizedBox(height: 16),
              buildChartToggle(),
              const SizedBox(height: 4),
            ],
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildLegend(),
                const SizedBox(height: 10),
                showRadar ? buildRadarChart() : buildBarChart(),
                const SizedBox(height: 10),
                buildStatsRow(),
                const SizedBox(height: 10),
                buildSkillBreakdown(),
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.showAppBar) {
      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: const Color.fromRGBO(167, 139, 250, 1),
          title: const Text(
            'Statistika',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 0),
              child: Image.asset(
                'assets/brain_logo_goodremakecolor.png',
                height: 60,
              ),
            ),
          ],
        ),
        body: _buildContent(),
      );
    } else {
      return _buildContent();
    }
  }
}