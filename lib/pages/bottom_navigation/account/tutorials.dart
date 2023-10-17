import 'package:click/utils/navigation.dart';
import 'package:click/utils/styles.dart';
import 'package:click/widgets/tile.dart';
import 'package:click/widgets/youtube.dart';
import 'package:flutter/material.dart';

class Tutorials extends StatefulWidget {
  const Tutorials({Key? key}) : super(key: key);

  @override
  State<Tutorials> createState() => _TutorialsState();
}

class _TutorialsState extends State<Tutorials> {
  Widget trailing = const Icon(
    Icons.arrow_forward_ios_outlined,
    size: 18,
  );

  void openYoutube() {
    toScreen(context, const MyYoutubePlayer());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: const Text('Tutorials'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            tile('How to add business?', trailing, onPressed: openYoutube),
            tile('How to edit business?', trailing, onPressed: openYoutube),
            tile('How to create post?', trailing, onPressed: openYoutube),
            tile('How to create video post?', trailing, onPressed: openYoutube),
            tile('How to create greeting post?', trailing,
                onPressed: openYoutube),
            tile('How to create custom photos?', trailing,
                onPressed: openYoutube),
            tile('How to create custom video?', trailing,
                onPressed: openYoutube),
            tile('How to buy premium package?', trailing,
                onPressed: openYoutube),
          ],
        ),
      ),
    );
  }
}
