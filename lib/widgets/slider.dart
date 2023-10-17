import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../utils/constants.dart';

class CustomSlider extends StatelessWidget {
  const CustomSlider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child:  CachedNetworkImage( imageUrl:
                url,
                width: 200,
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
          h(10),
          const Text('आपके क्या हाल-चाल हैं'),
        ],
      ),
    );
  }
}
