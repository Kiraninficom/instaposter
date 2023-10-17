import 'package:cached_network_image/cached_network_image.dart';
import 'package:click/utils/constants.dart';
import 'package:click/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class ContactDialog extends StatefulWidget {
  bool? forblockpage;
  ContactDialog({super.key, this.forblockpage});

  @override
  State<ContactDialog> createState() => _ContactDialogState();
}

class _ContactDialogState extends State<ContactDialog> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.phone_android_outlined,
                      color: appBarColor,
                    ),
                    const Text(
                      'Help & Support',
                    ),
                  ],
                ),
                widget.forblockpage == true
                    ? SizedBox.shrink()
                    : IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
              ],
            ),
            h(20),
            InkWell(
              onTap: () {
                launchUrl(
                    Uri.parse(
                        "whatsapp://send?phone=+918888102056&text=Hi, I need some help"),
                    mode: LaunchMode.externalApplication);
              },
              child: helpCard(
                'Click to send message',
                FaIcon(
                  FontAwesomeIcons.whatsapp,
                  size: 25,
                  color: Colors.green,
                ),
                // CachedNetworkImage(
                //   imageUrl:
                //       "https://img.icons8.com/color/512/whatsapp--v1.png",
                //   width: 35,
                // )
              ),
            ),
            // h(5),
            // InkWell(
            //   onTap: () {
            //     launchUrl(Uri.parse('tel:+918888102056'),
            //         mode: LaunchMode.externalApplication);
            //     Clipboard.setData(ClipboardData(text: '+91 8888102056'));
            //   },
            //   child: helpCard(
            //       '+91 8888102056',
            //       const Icon(
            //         Icons.call_outlined,
            //         color: Colors.teal,
            //       )),
            // ),
            h(5),
            InkWell(
              onTap: () {
                launchUrl(Uri.parse('mailto:info@instapost365.com'),
                    mode: LaunchMode.externalApplication);
                Clipboard.setData(ClipboardData(text: 'info@instapost365.com'));
              },
              child: helpCard(
                  'admin@instapost365.com',
                  const Icon(
                    Icons.email_outlined,
                    color: Colors.redAccent,
                  )),
            ),
          ],
        ),
      ),
    );
  }

  Widget helpCard(
    String title,
    Widget icon, {
    void Function()? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              icon,
              w(10),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
