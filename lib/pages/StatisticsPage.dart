import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'dart:math';

class Statisticspage extends StatefulWidget {
  const Statisticspage({super.key});

  @override
  State<Statisticspage> createState() => _StatisticspageState();
}

class _StatisticspageState extends State<Statisticspage> {
  final Random random = Random();

  late List<FlSpot> spots;

  @override
  void initState() {
    super.initState();
    spots = generateSpots();
  }

  List<FlSpot> generateSpots() {
    return List.generate(7, (index) {
      return FlSpot(
        (index + 1).toDouble(),
        (random.nextInt(10) + 1).toDouble(),
      );
    });
  }

  Widget buildSkillSelector() {
    final skills = ['Komunikacija', 'Susikaupimas', 'Pasitikėjimas', 'Komandiškumas'];

    return SizedBox(
      height: 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: skills.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: ElevatedButton(
              onPressed: () {
                // Veliau cia bus is vienos statistikos pereit i kita
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromRGBO(79, 97, 127, 1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Text(skills[index], style: TextStyle(color: Color.fromRGBO(255, 255, 255, 1))),
            ),
          );
        },
      ),
    );
  }

  Widget buildChartCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color.fromRGBO(229, 231, 235, 1),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: SizedBox(
        height: 250,
        child: LineChart(
          LineChartData(
            minX: 1,
            maxX: 7,
            minY: 0,
            maxY: 10,
            gridData: FlGridData(show: true),

            titlesData: FlTitlesData(
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  interval: 1,
                  getTitlesWidget: (value, meta) {
                    const days = ['Pr', 'An', 'Tr', 'Kt', 'Pn', 'Št', 'Sk'];
                    if (value < 1 || value > 7) return const SizedBox();
                    return Text(days[value.toInt() - 1]);
                  },
                ),
              ),
              topTitles: AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),

              rightTitles: AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
            ),

            lineBarsData: [
              LineChartBarData(
                spots: spots,
                isCurved: true,
                barWidth: 4,
                color: Color.fromRGBO(56, 189, 248, 1),
                dotData: FlDotData(show: true),
                belowBarData: BarAreaData(
                  show: true,
                  color: Colors.blue.withOpacity(0.2),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildStatCard(String title, String value) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color.fromRGBO(229, 231, 235, 1),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
          ),
        ],
      ),
      child: Column(
        children: [
          Text(title, style: TextStyle(color: Color.fromRGBO(11, 18, 32, 1))),
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
          child: buildStatCard("Pokytis", "+25%"), //<-- hardcoded kol kas
        ),
        const SizedBox(width: 12),
        Expanded(
          child: buildStatCard("Vidurkis", "6.8"), //<-- hardcoded kol kas
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color.fromRGBO(167, 139, 250, 1),
        title: const Text(
          "Statistika",
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildSkillSelector(),
            const SizedBox(height: 16),
            buildChartCard(),
            const SizedBox(height: 16),
            buildStatsRow(),
          ],
        ),
      ),
    );
  }
}