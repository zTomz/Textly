// ignore_for_file: unnecessary_this

import 'package:flutter/material.dart';

class ToggleButton extends StatefulWidget {
  bool status;
  final void Function() toggleFunc;
  ToggleButton({Key? key, required this.status, required this.toggleFunc}) : super(key: key);

  @override
  State<ToggleButton> createState() => _ToggleButtonState();
}

class _ToggleButtonState extends State<ToggleButton> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    ThemeData theme = Theme.of(context);

    return GestureDetector(
      onTap: this.widget.toggleFunc,
      child: Container(
        width: 60,
        height: 30,
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: theme.accentColor,
              offset: const Offset(4, 4),
            ),
          ],
          border: Border.all(width: 4, color: theme.accentColor),
          color: theme.primaryColor,
        ),
        child: Row(
          mainAxisAlignment: this.widget.status
              ? MainAxisAlignment.end
              : MainAxisAlignment.start,
          children: [
            Container(
              width: 20,
              height: 20,
              color: theme.accentColor,
            )
          ],
        ),
      ),
    );
  }
}
