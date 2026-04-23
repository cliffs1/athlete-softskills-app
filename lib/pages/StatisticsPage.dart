import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_radar_chart/flutter_radar_chart.dart' as radar;
import 'package:softskills_app/widgets/subscription_gate.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Statisticspage extends StatefulWidget {
  const Statisticspage({super.key});

  @override
  State<Statisticspage> createState() => _StatisticspageState();
}

class SkillData {
  final String skill;
  final double value;
  final String category;

  SkillData(this.skill, this.value, this.category);
}

class _StatisticspageState extends State<Statisticspage> {
  bool showRadar = true;
  final supabase = Supabase.instance.client;
  List<SkillData> skills = [];
  bool loading = true;
  String selectedCategory = 'socialiniai';

  @override
  void initState() {
    super.initState();
    loadSkills();
  }

  Future<void> loadSkills() async {
    skills = await fetchSkills();
    setState(() {
      loading = false;
    });
  }

  Future<List<SkillData>> fetchSkills() async {
    final user = supabase.auth.currentUser;
    if (user == null) return [];

    final response = await supabase
        .from('naudotojo_minkstieji')
        .select('svoris, minkstieji_gebejimai(pavadinimas, kategorija)')
        .eq('fk_naudotojas', user.id);

    final data = response as List;

    return data.map((item) {
      return SkillData(
        item['minkstieji_gebejimai']['pavadinimas'],
        (item['svoris'] as num).toDouble(),
        item['minkstieji_gebejimai']['kategorija'],
      );
    }).toList();
  }

  List<SkillData> get filteredSkills {
    return skills.where((s) => s.category == selectedCategory).toList();
  }

  Widget buildRadarChart() {
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
        child: radar.RadarChart(
          ticks: const [2, 4, 6, 8, 10],
          features: filteredSkills.map((e) => e.skill).toList(),
          data: [
            filteredSkills.map((e) => e.value).toList(),
          ],
          graphColors: const [Colors.blue],
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
              return BarChartGroupData(
                x: index,
                barRods: [
                  BarChartRodData(
                    toY: filteredSkills[index].value,
                    width: 18,
                    borderRadius: BorderRadius.circular(6),
                  ),
                ],
              );
            }),
            titlesData: FlTitlesData(
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  getTitlesWidget: (value, meta) {
                    if (value.toInt() < 0 ||
                        value.toInt() >= filteredSkills.length) {
                      return const SizedBox();
                    }

                    return Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Text(
                        filteredSkills[value.toInt()].skill,
                        style: const TextStyle(fontSize: 10),
                      ),
                    );
                  },
                ),
              ),
              leftTitles: const AxisTitles(
                sideTitles: SideTitles(showTitles: true),
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

  Widget buildChartToggle() {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: () {
              setState(() {
                showRadar = true;
              });
            },
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
              onPressed: () {
                setState(() {
                  showRadar = false;
                });
              },
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
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey[300],
              ),
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
          buildCategoryButton(
            label: 'socialiniai',
            category: 'socialiniai',
          ),
          SubscriptionGate(
            child: buildCategoryButton(
              label: 'emociniai',
              category: 'emociniai',
            ),
            fallback: buildLockedCategoryButton('emociniai'),
          ),
          SubscriptionGate(
            child: buildCategoryButton(
              label: 'protiniai',
              category: 'protiniai',
            ),
            fallback: buildLockedCategoryButton('protiniai'),
          ),
        ],
      ),
    );
  }

  Widget buildCategoryButton({
    required String label,
    required String category,
  }) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: ElevatedButton(
        onPressed: () {
          setState(() {
            selectedCategory = category;
          });
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: selectedCategory == category
              ? const Color.fromRGBO(79, 97, 127, 1)
              : Colors.grey[300],
        ),
        child: Text(
          label,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  Widget buildLockedCategoryButton(String label) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: ElevatedButton(
        onPressed: null,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.grey[300],
        ),
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

  Widget buildStatCard(String title, String value) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color.fromRGBO(229, 231, 235, 1),
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            title,
            style: const TextStyle(color: Color.fromRGBO(11, 18, 32, 1)),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildStatsRow() {
    return Row(
      children: [
        Expanded(
          child: buildStatCard('Pokytis', '+25%'),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: buildStatCard('Vidurkis', '6.8'),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
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
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildSkillSelector(),
            const SizedBox(height: 16),
            buildChartToggle(),
            const SizedBox(height: 16),
            const SubscriptionGate(
              child: SizedBox.shrink(),
              fallback: Padding(
                padding: EdgeInsets.only(bottom: 16),
                child: Text(
                  'Su prenumerata atrakinsi papildomas kategorijas ir stulpelinę diagramą.',
                  style: TextStyle(color: Colors.black54),
                ),
              ),
            ),
            showRadar ? buildRadarChart() : buildBarChart(),
            const SizedBox(height: 16),
            buildStatsRow(),
          ],
        ),
      ),
    );
  }
}
