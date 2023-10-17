import 'package:click/create_image_poster.dart';
import 'package:click/pages/bottom_navigation/homepage.dart';
import 'package:click/utils/navigation.dart';
import 'package:flutter/material.dart';

class Custom extends StatefulWidget {
  const Custom({Key? key}) : super(key: key);

  @override
  State<Custom> createState() => _CustomState();
}

class _CustomState extends State<Custom> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Poster(
            onTap: () {},
            title: 'VIDEO',
            color: Colors.blueAccent,
            child: const CircleAvatar(
              backgroundColor: Colors.red,
              child: Icon(
                Icons.videocam_outlined,
                color: Colors.white,
              ),
            ),
          ),
          Poster(
            onTap: () {
              toScreen(context, const Createimageposter());
            },
            title: 'PHOTO',
            color: Colors.redAccent,
            child: Image.asset(
              'assets/photoPoster.png',
              height: 40,
            ),
          ),
        ],
      ),
    );
  }
}
