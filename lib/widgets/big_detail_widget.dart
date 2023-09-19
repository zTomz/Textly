import 'package:flutter/material.dart';
import 'package:textly/widgets/bar_chart.dart';

class BigDetailWidget extends StatelessWidget {
  final String title;
  final Map<String, double> data;

  final Widget Function(BuildContext context, int index) itemBuilder;
  final int itemCount;

  const BigDetailWidget({
    super.key,
    required this.title,
    required this.itemBuilder,
    required this.itemCount,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    final largestValue = getLargestValue();

    return Container(
      height: 250,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: theme.colorScheme.inversePrimary, width: 2),
        color: theme.colorScheme.surfaceVariant,
      ),
      child: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            TabBar(
              tabs: [
                Tab(
                  text: title,
                ),
                const Tab(
                  text: "Diagram",
                ),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  ListView.builder(
                    itemCount: itemCount,
                    itemBuilder: itemBuilder,
                  ),
                  BarChart(largestValue: largestValue, data: data),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  double getLargestValue() {
    double largestValue = 0;

    for (final value in data.values) {
      if (value > largestValue) {
        largestValue = value;
      }
    }

    return largestValue;
  }
}
