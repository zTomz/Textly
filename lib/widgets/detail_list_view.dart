// ignore_for_file: unnecessary_this

import 'package:flutter/material.dart';
import 'package:textly/settings.dart';
import 'dart:math' as math;

class DetailListView extends StatefulWidget {
  final String title;
  final List list;
  final int sum;
  const DetailListView({
    Key? key,
    required this.title,
    required this.list,
    required this.sum,
  }) : super(key: key);

  @override
  State<DetailListView> createState() => _DetailListViewState();
}

class _DetailListViewState extends State<DetailListView> {
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    ThemeData theme = Theme.of(context);

    return Container(
      height: 300,
      width: size.width * 0.85,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: theme.accentColor,
            offset: const Offset(9, 9),
          ),
        ],
        border: Border.all(width: 9, color: theme.accentColor),
        color: theme.primaryColor,
      ),
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(left: 13, top: 10, right: 13),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  this.widget.title,
                  style: theme.textTheme.headline1!.copyWith(fontSize: 24),
                ),
                if (settings[1].status)
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 20,
                        height: 20,
                        color: currentPage == 0
                            ? theme.accentColor
                            : theme.accentColor.withOpacity(0.6),
                      ),
                      const SizedBox(width: 5),
                      Container(
                        width: 20,
                        height: 20,
                        color: currentPage == 1
                            ? theme.accentColor
                            : theme.accentColor.withOpacity(0.6),
                      )
                    ],
                  ),
              ],
            ),
          ),
          Expanded(
            child: PageView(
              onPageChanged: (int page) {
                setState(() {
                  currentPage = page;
                });
              },
              children: [
                SingleChildScrollView(
                  child: Column(
                    children: [
                      Column(
                        children: this
                            .widget
                            .list
                            .map(
                              (value) => Container(
                                height: 60,
                                margin: const EdgeInsets.only(
                                    top: 10, bottom: 10, left: 10, right: 20),
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: theme.accentColor,
                                      offset: const Offset(9, 9),
                                    ),
                                  ],
                                  border: Border.all(
                                      width: 9, color: theme.accentColor),
                                  color: theme.primaryColor,
                                ),
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: settings[0].status
                                          ? size.width * 0.85 * 0.35
                                          : size.width * 0.85 * 0.3,
                                      height: 70,
                                      child: Center(
                                        child: Text(
                                          settings[0].status
                                              ? "${value[1].toString()} | ${convertDoubleToString((value[1] / this.widget.sum) * 100)}%"
                                              : value[1].toString(),
                                          style: theme.textTheme.bodyText2,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: 10,
                                      height: 70,
                                      decoration: BoxDecoration(
                                        color: theme.accentColor,
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Center(
                                        child: Text(
                                          value[0].toString(),
                                          style: theme.textTheme.bodyText2,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                            .toList(),
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
                if (getLargestValue() != -1 && settings[1].status)
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10),
                      Container(
                        width: size.width * 0.75,
                        height: 40,
                        decoration: BoxDecoration(
                          border: Border(
                            top: BorderSide(
                              width: 5,
                              color: theme.accentColor,
                            ),
                            bottom: BorderSide(
                              width: 5,
                              color: theme.accentColor,
                            ),
                            right: BorderSide(
                              width: 5,
                              color: theme.accentColor,
                            ),
                          ),
                        ),
                        child: Row(
                          children: [
                            const SizedBox(width: 5),
                            Text(
                              "0",
                              style: theme.textTheme.bodyText1,
                            ),
                            const Spacer(),
                            Text(
                              (getLargestValue() * 0.33).toStringAsFixed(2),
                              style: theme.textTheme.bodyText1,
                            ),
                            const Spacer(),
                            Text(
                              (getLargestValue() * 0.66).toStringAsFixed(2),
                              style: theme.textTheme.bodyText1,
                            ),
                            const Spacer(),
                            Text(
                              getLargestValue().toString(),
                              style: theme.textTheme.bodyText1,
                            ),
                            const SizedBox(width: 5),
                          ],
                        ),
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                            child: Column(
                          children: this
                              .widget
                              .list
                              .map(
                                (value) => Container(
                                  margin: const EdgeInsets.symmetric(
                                    vertical: 10,
                                  ),
                                  width: size.width * 0.75,
                                  height: 30,
                                  child: Stack(
                                    children: [
                                      Positioned(
                                        left: 0,
                                        top: 0,
                                        child: Container(
                                          width: size.width *
                                              0.75 *
                                              (calculatePercent(value[1]) /
                                                  100),
                                          height: 30,
                                          color: theme.accentColor,
                                        ),
                                      ),
                                      Positioned(
                                          top: 5,
                                          left: 10,
                                          child: Text(
                                              "${value[0].toString()} | ${value[1].toString()}"))
                                    ],
                                  ),
                                ),
                              )
                              .toList(),
                        )),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  double calculatePercent(int value) {
    return (value / getLargestValue()) * 100;
  }

  String convertDoubleToString(double percentage) {
    return percentage.toStringAsFixed(2);
  }

  int getLargestValue() {
    if (this.widget.list.length == 0) {
      return -1;
    }

    List<int> values = [];

    this.widget.list.forEach((value) {
      values.add(value[1]);
    });

    values.sort();
    return values[values.length - 1];
  }
}
