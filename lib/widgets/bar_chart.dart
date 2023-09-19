import 'package:flutter/material.dart';

class BarChart extends StatelessWidget {
  const BarChart({
    super.key,
    required this.largestValue,
    required this.data,
  });

  final double largestValue;
  final Map<String, double> data;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return LayoutBuilder(
      builder: (context, constraints) => Row(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(largestValue.toStringAsFixed(0)),
              Text((largestValue / 2).toStringAsFixed(0)),
              const Text("0"),
            ],
          ),
          const SizedBox(width: 7.5),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                border: Border(
                  left: BorderSide(),
                  bottom: BorderSide(),
                ),
              ),
              child: ListView.builder(
                itemCount: data.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) => Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 15),
                      width: 30,
                      height: constraints.maxHeight *
                              (data.values.elementAt(index) / largestValue) -
                          1,
                      alignment: Alignment.bottomCenter,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(20),
                        ),
                        border: Border.all(
                          color: theme.colorScheme.inversePrimary,
                          width: 2,
                        ),
                        color: theme.colorScheme.surfaceVariant,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 15),
                      width: 30,
                      alignment: Alignment.bottomCenter,
                      child: Text(data.keys.elementAt(index)),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
