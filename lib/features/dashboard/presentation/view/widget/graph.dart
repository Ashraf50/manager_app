import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../../data/model/statistics/annual_tickets_average.dart';

class ChartsDashboard extends StatelessWidget {
  final List<AnnualTicketsAverage> annualTickets;
  const ChartsDashboard({super.key, required this.annualTickets});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildAnnualTicketsChart(),
      ],
    );
  }

  Widget _buildAnnualTicketsChart() {
    final List<FlSpot> spots = [];
    final List<String> years = [];
    for (int i = 0; i < annualTickets.length; i++) {
      final year = annualTickets[i].year ?? 0;
      final count = annualTickets[i].count ?? 0;
      spots.add(FlSpot(i.toDouble(), count.toDouble()));
      years.add(year.toString());
    }
    double maxY = annualTickets
        .map((e) => e.count ?? 0)
        .reduce((a, b) => a > b ? a : b)
        .toDouble();
    maxY = (maxY < 1) ? 1 : maxY + 1;
    return Container(
      height: 250,
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text(
                'Annual tickets average',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 8),
              Icon(
                Icons.remove_red_eye,
                size: 20,
                color: Colors.grey[400],
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: LineChart(
              LineChartData(
                gridData: const FlGridData(show: false),
                titlesData: FlTitlesData(
                  rightTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false)),
                  topTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false)),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) => Text(
                        '${value.toInt()}',
                        style: TextStyle(
                          color: Colors.grey[400],
                          fontSize: 12,
                        ),
                      ),
                      interval: 1,
                    ),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        int index = value.toInt();
                        if (index >= 0 && index < years.length) {
                          return Text(
                            years[index],
                            style: TextStyle(
                              color: Colors.grey[400],
                              fontSize: 12,
                            ),
                          );
                        }
                        return const Text('');
                      },
                      interval: 1,
                    ),
                  ),
                ),
                borderData: FlBorderData(show: false),
                lineBarsData: [
                  LineChartBarData(
                    spots: spots,
                    isCurved: true,
                    color: const Color(0xFF4CD964),
                    barWidth: 2,
                    isStrokeCapRound: true,
                    dotData: const FlDotData(show: false),
                    belowBarData: BarAreaData(
                      show: true,
                      color: const Color(0xFF4CD964).withOpacity(0.1),
                    ),
                  ),
                ],
                minY: 0,
                maxY: maxY,
              ),
            ),
          ),
        ],
      ),
    );
  }
}