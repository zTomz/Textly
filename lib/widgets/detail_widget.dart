// ignore_for_file: unnecessary_this

import 'package:flutter/material.dart';
import 'package:textly/data.dart';

class DetailWidget extends StatelessWidget {
  final String count;
  final String title;

  const DetailWidget({Key? key, required this.count, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      width: size.width * 0.925,
      height: 90,
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: GOLD,
        borderRadius: BorderRadius.circular(90),
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(90),
              ),
              child: Center(
                child: Text(this.count),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Center(
              child: Text(this.title),
            ),
          ),
        ],
      ),
    );
  }
}
