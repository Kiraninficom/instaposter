import 'package:flutter/material.dart';

class WaterMark extends StatefulWidget {
  const WaterMark({Key? key}) : super(key: key);

  @override
  State<WaterMark> createState() => _WaterMarkState();
}

class _WaterMarkState extends State<WaterMark> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Watermark'),
      ),
    );
  }
}
