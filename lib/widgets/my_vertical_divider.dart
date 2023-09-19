import 'package:flutter/material.dart';

class MyVerticalDivider extends StatelessWidget {
  const MyVerticalDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 2,
      color: Theme.of(context).colorScheme.inversePrimary
    );
  }
}