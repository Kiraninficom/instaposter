import 'package:cached_network_image/cached_network_image.dart';
import 'package:click/pages/authcredential.dart';
import 'package:click/pages/bottom_navigation/account/contactdialog.dart';
import 'package:click/pages/drawer/profile/my_profile.dart';
import 'package:click/pages/drawer/refer&earn.dart';
import 'package:click/pages/getapi.dart';
import 'package:click/pages/login.dart';
import 'package:click/pages/notification_subject.dart';
import 'package:click/utils/constants.dart';
import 'package:click/utils/navigation.dart';
import 'package:click/utils/styles.dart';
import 'package:click/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../helpers/layout.dart';
import '../../../widgets/tile.dart';

class Account extends StatefulWidget {
  const Account({Key? key}) : super(key: key);

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  getdata() async {
    var data = await SentApi().getpolicyandservice();
    print(data);
    setState(() {
      privacypolicydata = data['privacy'];
      termandservicedata = data['terms'];
    });
  }

  @override
  void initState() {
    super.initState();
    getdata();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: whitecolor),
        backgroundColor: primaryColor,
        title: const Text('My Account'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            tile(
              'My Profile',
              const Icon(
                Icons.image_outlined,
                color: Colors.blueGrey,
              ),
              onPressed: () {
                toScreen(context, const MyProfile());
              },
            ),
            // tile('Tutorials', const Icon(Icons.help_outline_outlined),
            //     onPressed: () {
            //   toScreen(context, const Tutorials());
            // }),
            tile(
              'Refer & Earn',
              const Icon(
                Icons.share_outlined,
                color: Colors.orange,
              ),
              onPressed: () {
                toScreen(context, ReferAndEarnPage());
              },
            ),
            // tile(
            //     'Rate us',
            //     const Icon(
            //       Icons.star_rate_outlined,
            //       color: Colors.green,
            //     )),
            tile(
              'Privacy Policy',
              const Icon(
                Icons.privacy_tip_outlined,
                color: Colors.blue,
              ),
              onPressed: () {
                toScreen(
                    context,
                    NotificationSubjectPage(
                      subject: privacypolicydata[0]['content'] ??
                          "<p>Welcome To InstaPoster</p>",
                      title: 'Privacy Policy',
                    ));
              },
            ),
            tile(
              'Terms & Services',
              const Icon(
                FontAwesomeIcons.link,
                color: Colors.brown,
              ),
              onPressed: () {
                toScreen(
                    context,
                    NotificationSubjectPage(
                      subject: termandservicedata[0]['content'] ??
                          "<p>Welcome To InstaPoster</p>",
                      title: 'Terms & Services',
                    ));
              },
            ),
            tile(
                'Help & Support',
                CachedNetworkImage(
                  imageUrl: "https://img.icons8.com/color/512/whatsapp--v1.png",
                  width: 35,
                ), onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return Dialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ContactDialog());
                  });
            }),
            h(15),
            Center(
              child: SizedBox(
                height: AppLayout.getHeight(40),
                width: AppLayout.getWidth(120),
                child: Button(
                  style: TextStyle(
                    fontSize: AppLayout.getHeight(18),
                  ),
                  primaryColor: primaryColor,
                  text: 'Logout',
                  radius: 5,
                  onPressed: () {
                    Authcredential().deleteToken();
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Login(),
                        ),
                        (route) => false);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
