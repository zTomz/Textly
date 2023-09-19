import 'package:flutter/material.dart';
import 'package:textly/widgets/my_vertical_divider.dart';

class DetailWidget extends StatelessWidget {
  final String value;
  final String title;
  final EdgeInsets? margin;

  const DetailWidget({
    Key? key,
    required this.value,
    required this.title,
    this.margin,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Container(
      height: 75,
      margin: margin,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: theme.colorScheme.inversePrimary, width: 2),
        color: theme.colorScheme.surfaceVariant,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.center,
            ),
          ),
          const MyVerticalDivider(),
          Expanded(
            child: Text(
              title,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
