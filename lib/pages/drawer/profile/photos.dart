import 'package:click/utils/constants.dart';
import 'package:click/utils/styles.dart';
import 'package:flutter/material.dart';

class ProfilePhoto extends StatefulWidget {
  final image;
  final String title;
  final bool? editMode;
  const ProfilePhoto({
    Key? key,
    required this.image,
    required this.title,
    this.editMode = true,
  }) : super(key: key);

  @override
  State<ProfilePhoto> createState() => _ProfilePhotoState();
}

class _ProfilePhotoState extends State<ProfilePhoto> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            Container(
              padding: const EdgeInsets.all(3),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: primaryColor,
                  width: 2,
                ),
              ),
              child: CircleAvatar(
                radius: 60,
                backgroundImage: widget.image,
              ),
            ),
            if (widget.editMode!)
              Positioned(
                bottom: 10,
                right: 0,
                child: Container(
                    width: 35,
                    height: 35,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: primaryColor,
                    ),
                    child: const Icon(
                      Icons.edit_outlined,
                      color: Colors.white,
                    )
                    // IconButton(
                    //   icon: const Icon(
                    //     Icons.edit_outlined,
                    //     color: Colors.white,
                    //   ),
                    //   onPressed: () {
                    //     // todo: select image from gallery
                    //   },
                    // ),
                    ),
              ),
          ],
        ),
        h(5),
        Text(
          widget.title,
          style: const TextStyle(
            fontSize: 20,
          ),
        )
      ],
    );
  }
}
