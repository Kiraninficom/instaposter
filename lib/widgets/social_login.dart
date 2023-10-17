import 'package:flutter/material.dart';

class SocialLoginButton extends StatelessWidget {
  final void Function() onPressed;
  final String? imagePath;
  final Widget? child;

  const SocialLoginButton({
    Key? key,
    this.child,
    this.imagePath,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: imagePath == null
              ? null
              : DecorationImage(
                  image: Image.asset(imagePath!).image,
                ),
        ),
        child: child,
      ),
    );
  }
}
