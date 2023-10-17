import 'package:flutter/material.dart';

import '../helpers/layout.dart';

class Button extends StatelessWidget {
  final String text;
  final void Function()? onPressed;
  final TextStyle? style;
  final Color? primaryColor;
  final double? radius;
  final bool? circular;

  const Button({
    Key? key,
    required this.text,
    this.style,
    this.primaryColor,
    this.radius,
    this.circular,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryColor,
        shape: circular != null
            ? const CircleBorder()
            : RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(AppLayout.getHeight(radius ?? 30)),
              ),
      ),
      onPressed: onPressed,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          text,
          style: style ??
              const TextStyle(
                fontSize: 18,
              ),
        ),
      ),
    );
  }
}
