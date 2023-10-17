import 'package:click/pages/drawer/profile/photos.dart';
import 'package:click/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../helpers/layout.dart';
import '../../../utils/styles.dart';
import '../../../widgets/button.dart';
import '../../../widgets/textfield.dart';

class Profile extends StatefulWidget {
  final bool political;

  const Profile({
    Key? key,
    required this.political,
  }) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  // Widget politicalCard() {
  //   return Card(
  //     child: Row(
  //       children: [
  //         CircleAvatar(
  //           backgroundImage: Image.network(url).image,
  //         ),
  //         w(10),
  //         Column(
  //           children: [Text('')],
  //         )
  //       ],
  //     ),
  //   );
  // }
  bool get political => widget.political;

  @override
  Widget build(BuildContext context) {
    bool editMode = true;
    TextEditingController name = TextEditingController();
    TextEditingController designation = TextEditingController();
    TextEditingController designation2 = TextEditingController();
    TextEditingController facebook = TextEditingController();
    TextEditingController instagram = TextEditingController();
    TextEditingController twitter = TextEditingController();
    TextEditingController whatsapp = TextEditingController();
    TextEditingController mobile = TextEditingController();
    TextEditingController website = TextEditingController();
    TextEditingController email = TextEditingController();
    TextEditingController tagline = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text(political ? 'Political Profile' : 'My Business'),
        actions: [
          TextButton(
            onPressed: () {},
            child: Row(
              children: [
                const Icon(
                  Icons.add_outlined,
                  color: Colors.white,
                ),
                w(3),
                Text(
                  'Add ${political ? 'Profile' : 'Business'}',
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                )
              ],
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (!widget.political)
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Center(
                  child: ProfilePhoto(
                    image: Image.network(url),
                    title: 'Business Logo',
                    editMode: editMode,
                  ),
                ),
              ),
            if (widget.political)
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  children: [
                    ProfilePhoto(
                      image: Image.network(url),
                      title: 'Profile Photo',
                      editMode: editMode,
                    ),
                    const Spacer(),
                    ProfilePhoto(
                      image: Image.network(url),
                      title: 'Party Symbol',
                      editMode: editMode,
                    ),
                  ],
                ),
              ),
            h(5),
            const Center(
              child: Text(
                'Image size below 5MB',
                style: TextStyle(fontSize: 15),
              ),
            ),
            h(20),
            CustomTextField(
              height: 50,
              controller: name,
              labelText:
                  widget.political ? 'Enter your full name' : 'Business Name',
              enabled: editMode,
            ),
            if (!widget.political) ...[
              h(15),
              CustomTextField(
                height: 50,
                controller: tagline,
                labelText: 'Tagline',
                enabled: editMode,
              ),
            ],
            h(15),
            CustomTextField(
              height: 50,
              controller: designation,
              labelText: widget.political
                  ? 'Enter your designation'
                  : 'Enter your web url',
              enabled: editMode,
            ),
            h(15),
            CustomTextField(
              height: 50,
              controller: designation2,
              labelText: widget.political
                  ? 'Enter your designation 2'
                  : 'Enter your mail id',
              enabled: editMode,
              prefixIcon:
                  widget.political ? null : const Icon(Icons.email_outlined),
            ),
            h(15),
            CustomTextField(
              enabled: editMode,
              height: 50,
              controller: facebook,
              labelText: 'Facebook username',
              prefixIcon: const Icon(
                FontAwesomeIcons.facebook,
                color: Colors.blue,
                size: 18,
              ),
            ),
            h(15),
            CustomTextField(
              enabled: editMode,
              height: 50,
              controller: instagram,
              labelText: 'Instagram username',
              prefixIcon: const Icon(
                FontAwesomeIcons.instagram,
                color: Colors.redAccent,
                size: 18,
              ),
            ),
            h(15),
            CustomTextField(
              enabled: editMode,
              height: 50,
              controller: twitter,
              labelText: 'Twitter username',
              prefixIcon: const Icon(
                FontAwesomeIcons.twitter,
                color: Colors.lightBlue,
                size: 18,
              ),
            ),
            h(15),
            Row(
              children: [
                Expanded(
                  child: CustomTextField(
                    padding: const EdgeInsets.only(left: 20),
                    enabled: editMode,
                    height: 50,
                    controller: mobile,
                    labelText: 'Mobile',
                    prefixIcon: const Icon(
                      Icons.numbers,
                      size: 18,
                    ),
                  ),
                ),
                w(5),
                Expanded(
                  child: CustomTextField(
                    padding: const EdgeInsets.only(right: 20),
                    enabled: editMode,
                    height: 50,
                    controller: whatsapp,
                    labelText: 'Whatsapp',
                    prefixIcon: FaIcon(
                      FontAwesomeIcons.whatsapp,
                      size: 18,
                      color: Colors.green,
                    ),
                  ),
                ),
              ],
            ),
            h(15),
            if (widget.political)
              CustomTextField(
                enabled: editMode,
                height: 50,
                controller: website,
                labelText: 'Enter your web url',
                prefixIcon: const Icon(
                  Icons.language_outlined,
                  size: 18,
                ),
              ),
            if (widget.political) ...[
              h(15),
              CustomTextField(
                enabled: editMode,
                height: 50,
                controller: email,
                labelText: 'Enter your mail id',
                prefixIcon: const Icon(
                  Icons.email_outlined,
                  size: 18,
                ),
              ),
            ],
            h(20),
            Center(
              child: SizedBox(
                width: AppLayout.getScreenWidth() / 2,
                height: 50,
                child: Button(
                  radius: 15,
                  text: 'Submit',
                  style: const TextStyle(fontSize: 18),
                  primaryColor: primaryColor,
                  onPressed: () {
                    // todo: update profile
                  },
                ),
              ),
            ),
            h(10),
          ],
        ),
      ),
    );
  }
}
