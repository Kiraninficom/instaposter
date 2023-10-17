import 'package:flutter/material.dart';

import '../utils/constants.dart';
import '../utils/styles.dart';

Widget tile(
  String title,
  Widget trailing, {
  void Function()? onPressed,
}) {
  return GestureDetector(
    onTap: onPressed,
    child: Padding(
      padding: const EdgeInsets.fromLTRB(8, 5, 8, 0),
      child: Card(
        elevation: 1.5,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 8, 8, 8.0),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 5, bottom: 5.0),
                child: Container(
                  height: 35,
                  width: 5,
                  decoration: BoxDecoration(
                    color: primaryColor,
                  ),
                ),
              ),
              w(10),
              Expanded(
                flex: 8,
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontFamily: 'Poppins',
                  ),
                ),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: trailing,
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
