// ignore_for_file: must_be_immutable

import 'dart:convert';

import 'package:click/Pages/authcredential.dart';
import 'package:click/create_image_poster.dart';
import 'package:click/pages/bottom_navigation/account/account.dart';
import 'package:click/pages/bottom_navigation/custom.dart';
import 'package:click/pages/bottom_navigation/homepage.dart';
import 'package:click/pages/bottom_navigation/plans.dart';
import 'package:click/pages/bottom_navigation/showall_category.dart';
import 'package:click/pages/bottom_navigation/video.dart';
import 'package:click/pages/getapi.dart';
import 'package:click/pages/video_category.dart';
import 'package:click/utils/constants.dart';
import 'package:click/utils/styles.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../widgets/drawer.dart';

class LandingPage extends StatefulWidget {
  int value;
  LandingPage({Key? key, required this.value}) : super(key: key);

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  GlobalKey<ScaffoldState> key = GlobalKey();
  int currentIndex = 2;
  PageController pageController = PageController();

  changeIndex(val) {
    setState(() {
      currentIndex = val;
    });
  }

  getdata() async {
    SentApi().getsubs().then((value) {
      setState(() {});
    });
    var data = await Authcredential().getfromlocal("subscriptiondetails");
    if (data != null) {
      setState(() {
        subscriptiondetail = jsonDecode(data);
      });
    }
  }

  getrazorpaykey() async {
    var keyvalue = await SentApi().getrazorpaykey();
    setState(() {
      razorpaykeyvalue = keyvalue[0]['key_id'];
    });
  }

  getcurrentposterimages() async {
    var value = await SentApi().getcurrentposterimage();

    setState(() {
      currentposterimages = value;
    });
    print(value);
  }

  @override
  void initState() {
    super.initState();
    getdata();
    getrazorpaykey();
    SentApi().getpopuplist();
    getcurrentposterimages();
  }

  final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    List pages = [
      // const Video(),
      // const Custom(),
      // const Createimageposter(),
      const VideoCategory(),
      Showallcategory(
        activewatermark: false,
        greeting: true,
        popupvalue: "csc",
        value: greetingcategory,
        subimage: greetingimage,
        subvalue: greetingssubservice,
        cat: 'Greeting Poster',
      ),
      Homepage(
        scaffoldKey: key,
        value: widget.value,
      ),
      const Plans(),
      const Account(),
    ];
    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return false;
      },
      child: SafeArea(
        child: Scaffold(
            key: key,
            drawer: const CustomDrawer(),
            // appBar: AppBar(),
            bottomNavigationBar: CurvedNavigationBar(
              key: _bottomNavigationKey,
              index: currentIndex,
              height: 60.0,
              items: [
                Icon(
                  Icons.videocam_outlined,
                  color: whitecolor,
                ),
                Icon(
                  Icons.edit_outlined,
                  color: whitecolor,
                ),
                Icon(
                  Icons.home_outlined,
                  color: whitecolor,
                ),
                Icon(
                  FontAwesomeIcons.indianRupeeSign,
                  color: whitecolor,
                  size: 19,
                ),
                Icon(
                  Icons.account_circle_outlined,
                  color: whitecolor,
                ),
              ],
              color: appBarColor,
              buttonBackgroundColor: appBarColor,
              backgroundColor: Colors.transparent,
              animationCurve: Curves.easeOutSine,
              onTap: (index) {
                changeIndex(index);
              },
            ),
            body: pages[currentIndex]),
      ),
    );
  }
}
