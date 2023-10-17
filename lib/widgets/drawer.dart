import 'package:click/pages/authcredential.dart';
import 'package:click/pages/bottom_navigation/account/account.dart';
import 'package:click/pages/drawer/profile/add_profile.dart';
import 'package:click/pages/drawer/profile/my_profile.dart';
import 'package:click/pages/login.dart';
import 'package:click/utils/constants.dart';
import 'package:click/utils/navigation.dart';
import 'package:click/utils/styles.dart';
import 'package:click/widgets/button.dart';
import 'package:click/widgets/user_account.dart';
import 'package:click/widgets/walletpage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  Widget drawerTile({
    required String title,
    required Widget icon,
    required page,
  }) {
    return InkWell(
      onTap: () {
        if (title != 'Logout') {
          Navigator.of(context).pop();
          toScreen(context, page);
        } else {
          replaceScreen(context, page);
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            icon,
            w(10),
            Text(
              title,
              style: TextStyle(fontFamily: "Poppins-SemiBold", fontSize: 18),
            )
          ],
        ),
      ),
    );
  }

  Widget numberContainer(
      {required String title,
      required number,
      required Color color,
      ontap,
      var icon}) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 8),
      child: InkWell(
        onTap: ontap,
        child: Container(
          height: 50,
          decoration: BoxDecoration(
              color: color, borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                Icon(
                  icon,
                  color: whitecolor,
                ),
                w(5),
                Text(
                  title,
                  style: whiteText(22),
                ),
                const Spacer(),
                Text(
                  number,
                  style: whiteText(22),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var diff = subscriptiondetail != null
        ? int.parse(subscriptiondetail['days_left']) < 0
            ? 0.0
            : (int.parse(subscriptiondetail['days_left']) /
                    int.parse(subscriptiondetail['plan_duration']))
                .toDouble()
        : DateTime.now()
                    .difference(DateTime.parse(userdata['created_at']))
                    .inDays >
                7
            ? 0.0
            : (7 -
                    DateTime.now()
                        .difference(DateTime.parse(userdata['created_at']))
                        .inDays) /
                7.toDouble();
    var leftdays = DateTime.now()
                .difference(DateTime.parse(userdata['created_at']))
                .inDays >
            7
        ? 0
        : (7 -
            DateTime.now()
                .difference(DateTime.parse(userdata['created_at']))
                .inDays);
    return Drawer(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          children: [
            const UserAccount(),
            h(30),
            LinearPercentIndicator(
              barRadius: Radius.circular(10),
              progressColor: appBarColor,
              lineHeight: 50,
              percent: diff,
              center: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    Icon(
                      Icons.calendar_month_outlined,
                      color: whitecolor,
                    ),
                    w(5),
                    Text(
                      'Days Left',
                      style: whiteText(22),
                    ),
                    const Spacer(),
                    Text(
                      subscriptiondetail == null
                          ? "$leftdays"
                          : int.parse(subscriptiondetail['days_left']) < 0
                              ? "0"
                              : subscriptiondetail['days_left'],
                      style: blackText(22),
                    ),
                  ],
                ),
              ),
            ),
            subscriptiondetail == null
                ? SizedBox.shrink()
                : int.parse(subscriptiondetail['days_left']) < 0
                    ? SizedBox.shrink()
                    : Column(
                        children: [
                          h(10),
                          numberContainer(
                              icon: subscriptiondetail['plan_type'] == '1'
                                  ? Icons.workspace_premium
                                  : Icons.wallet,
                              title: subscriptiondetail['plan_type'] == '1'
                                  ? 'Unlimated'
                                  : 'Account Bal.',
                              number: subscriptiondetail['plan_type'] == '1'
                                  ? ''
                                  : balancedata.isEmpty
                                      ? ".."
                                      : balancedata['available_balance'],
                              color: Colors.green,
                              ontap: () {
                                toScreen(context, Walletpage());
                              }),
                        ],
                      ),
            h(10),
            numberContainer(
                icon: Icons.download,
                title: 'Downloads',
                number: downloaddata.isEmpty
                    ? ".."
                    : "${downloaddata['total_downloads']}",
                color: primaryColor,
                ontap: () {}),
            h(10),
            numberContainer(
                icon: Icons.share,
                title: 'Share',
                number: downloaddata.isEmpty
                    ? ".."
                    : "${downloaddata['total_share']}",
                color: Colors.blueGrey,
                ontap: () {}),
            h(30),
            drawerTile(
                title: 'My Profile',
                icon: const Icon(Icons.person_outline),
                page: const MyProfile()),
            drawerTile(
                title: 'CSC Center Profile',
                icon: const Icon(Icons.person_outline),
                page: const Addprofile(
                    csc: true, buisness: false, festival: false)),
            // drawerTile(
            //   title: 'My Business Profile',
            //   icon: const Icon(
            //     FontAwesomeIcons.suitcase,
            //     size: 20,
            //   ),
            //   page:
            //       const Addprofile(csc: false, buisness: true, festival: false),
            // ),
            drawerTile(
              title: 'Festival Profile',
              icon: const Icon(FontAwesomeIcons.feather),
              page:
                  const Addprofile(csc: false, buisness: false, festival: true),
            ),
            // drawerTile(
            //   title: 'Festival Video Profile',
            //   icon: const Icon(
            //     Icons.videocam_outlined,
            //     color: Colors.red,
            //   ),
            //   page: Container(),
            // ),
            // drawerTile(
            //   title: 'Business Video Profile',
            //   icon: const Icon(
            //     Icons.videocam_outlined,
            //     color: Colors.red,
            //   ),
            //   page: Container(),
            // ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
              child: Row(
                children: [
                  Button(
                    radius: 5,
                    text: 'More',
                    primaryColor: primaryColor,
                    onPressed: () {
                      Navigator.of(context).pop();
                      toScreen(context, const Account());
                    },
                  ),
                  const Spacer(),
                  Button(
                    radius: 5,
                    text: 'Logout',
                    primaryColor: primaryColor,
                    onPressed: () async {
                      Authcredential().deleteToken();
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      await prefs.clear();
                      replaceScreen(context, const Login());
                    },
                  ),
                ],
              ),
            )
            // drawerTile(
            //   title: 'Language Settings',
            //   icon: const Icon(FontAwesomeIcons.language),
            //   page: const LanguageSettings(),
            // ),
          ],
        ),
      ),
    );
  }
}
