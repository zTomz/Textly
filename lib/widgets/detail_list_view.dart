// ignore_for_file: unnecessary_this

import 'package:flutter/material.dart';

class DetailListView extends StatelessWidget {
  final String title;
  final List list;
  const DetailListView({Key? key, required this.title, required this.list}) : super(key: key);

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
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(left: 13, top: 10),
              child: Row(
                children: [
                  Text(this.title,
                      style: theme.textTheme.headline1!.copyWith(fontSize: 24)),
                ],
              ),
            ),
            Column(
              children: this.list
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
                        border: Border.all(width: 9, color: theme.accentColor),
                        color: theme.primaryColor,
                      ),
                      child: Row(
                        children: [
                          SizedBox(
                            width: size.width * 0.85 * 0.3,
                            height: 70,
                            child: Center(
                              child: Text(
                                value[1].toString(),
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
    );
  }
}
