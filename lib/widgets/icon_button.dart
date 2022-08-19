// ignore_for_file: unnecessary_this

import 'package:flutter/material.dart';

class RetroIconButton extends StatelessWidget {
  final String tooltip;
  final Icon icon;
  final void Function()? onTap;
  const RetroIconButton(
      {Key? key,
      required this.tooltip,
      required this.icon,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return GestureDetector(
      onTap: this.onTap,
      child: Tooltip(
        message: this.tooltip,
        child: Container(
          width: 40,
          height: 40,
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
          child: Center(
            child: this.icon,
          ),
        ),
      ),
    );
  }
}
