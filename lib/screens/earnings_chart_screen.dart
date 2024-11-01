import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:get/get.dart';
import '../controllers/earnings_controller.dart';
import 'transcript_screen.dart';

class EarningsChartScreen extends StatelessWidget {
  final EarningsController controller;
  final String ticker;

  const EarningsChartScreen(
      {Key? key, required this.controller, required this.ticker})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Earnings Chart'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 40.0),
        child: Obx(() {
          if (controller.earnings.isEmpty) {
            return const Center(child: Text("No data available"));
          }

          return Column(
            children: [
              Expanded(
                child: GestureDetector(
                  child: BarChart(
                    BarChartData(
                      alignment: BarChartAlignment.spaceAround,
                      maxY: controller.earnings
                              .map((e) => e.actualEps)
                              .reduce((a, b) => a > b ? a : b) +
                          0.5,
                      barTouchData: BarTouchData(
                        touchCallback: handleTouchResponse,
                        touchTooltipData: BarTouchTooltipData(
                          tooltipPadding: EdgeInsets.all(10),
                          getTooltipColor: (BarChartGroupData group) =>
                              const Color(0xFF1A1A19),
                          // getTooltipItem: getTooltipItems,
                          getTooltipItem: (group, groupIndex, rod, rodIndex) {
                            String date =
                                "Act Eps ${controller.earnings[group.x.toInt()].actualEps.toString()}";
                            return BarTooltipItem(
                              '$date\n',
                              const TextStyle(
                                color: Color(0xFF006BFF),
                                fontWeight: FontWeight.bold,
                              ),
                              children: <TextSpan>[
                                TextSpan(
                                  text:
                                      "Est Eps ${controller.earnings[group.x.toInt()].estimatedEps.toString()}",
                                  style: const TextStyle(
                                    color: Color(0xFFa4a2a8),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                      titlesData: FlTitlesData(
                        bottomTitles: AxisTitles(
                          axisNameWidget: const Text('Date',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          sideTitles: SideTitles(
                            showTitles: true,
                            getTitlesWidget: (value, _) {
                              int index = value.toInt();
                              if (index >= 0 &&
                                  index < controller.earnings.length) {
                                return Text(
                                  controller.earnings[index].date,
                                  style: const TextStyle(fontSize: 10),
                                );
                              }
                              return const Text('');
                            },
                            reservedSize: 32,
                          ),
                        ),
                        leftTitles: AxisTitles(
                          axisNameWidget: const Text('EPS',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          sideTitles: SideTitles(
                            showTitles: true,
                            interval: 0.5,
                            getTitlesWidget: (value, _) =>
                                Text(value.toStringAsFixed(1)),
                            reservedSize: 40,
                          ),
                        ),
                      ),
                      gridData: FlGridData(show: true),
                      borderData: FlBorderData(
                        show: true,
                        border: Border.all(color: Colors.grey, width: 1),
                      ),
                      barGroups:
                          controller.earnings.asMap().entries.map((entry) {
                        final index = entry.key;
                        final earnings = entry.value;

                        return BarChartGroupData(
                          x: index,
                          barRods: [
                            BarChartRodData(
                              toY: earnings.actualEps,
                              color: Color(0xFF009fff),
                              width: 12,
                              borderRadius: BorderRadius.circular(1),
                            ),
                            BarChartRodData(
                              toY: earnings.estimatedEps,
                              color: Color(0xFFa4a2a8),
                              width: 12,
                              borderRadius: BorderRadius.circular(1),
                            ),
                          ],
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  LegendItem(color: Color(0xFF009fff), text: 'Actual EPS'),
                  SizedBox(width: 16),
                  LegendItem(color: Color(0xFFa4a2a8), text: 'Estimated EPS'),
                ],
              ),
            ],
          );
        }),
      ),
    );
  }

  void handleTouchResponse(
      FlTouchEvent touchEvent, BarTouchResponse? touchResponse) {
    if (touchResponse != null && touchResponse.spot != null) {
      final touchedGroupIndex = touchResponse.spot!.touchedBarGroupIndex;
      final earnings = controller.earnings[touchedGroupIndex];

      final year = DateTime.parse(earnings.date).year;
      final quarter = (DateTime.parse(earnings.date).month / 3).ceil();

      // Show loading indicator
      Get.dialog(
        const Center(
          child: CircularProgressIndicator(),
        ),
        barrierDismissible: false, // Prevent dismissing on tap
      );

      controller.fetchEarningsTranscript(ticker, year, quarter).then((_) {
        Get.back(); // Close the loading indicator
        Get.to(() => TranscriptScreen(
              transcript: controller.transcript.value,
              isLoading: controller.isLoadingTranscript,
              ticker: ticker,
              year: year,
              quarter: quarter,
            ));
      });
    }
  }
}

class LegendItem extends StatelessWidget {
  final Color color;
  final String text;

  const LegendItem({Key? key, required this.color, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 16,
          height: 16,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 4),
        Text(text, style: const TextStyle(fontSize: 12)),
      ],
    );
  }
}
