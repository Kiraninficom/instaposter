import 'dart:async';
import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:click/main.dart';
import 'package:click/pages/authcredential.dart';
import 'package:click/pages/bottom_navigation/blockedpage.dart';
import 'package:click/pages/bottom_navigation/popup_dialog.dart';
import 'package:click/pages/csc_category.dart';
import 'package:click/pages/festival_category.dart';
import 'package:click/pages/getapi.dart';
import 'package:click/pages/login.dart';
import 'package:click/pages/notification.dart';
import 'package:click/utils/constants.dart';
import 'package:click/utils/navigation.dart';
import 'package:click/utils/styles.dart';
import 'package:click/widgets/popupconstant.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import '../../helpers/layout.dart';

class Homepage extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  int value;

  Homepage({Key? key, required this.scaffoldKey, required this.value})
      : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final TextEditingController searchController = TextEditingController();
  final TextEditingController selectedcategory = TextEditingController();

  final CarouselController _carouselController = CarouselController();

  // var selctedpage = [
  // const Csccategory(),
  // const Festivalcategory(),
  // const Logocategory(),
  // const Buisnesscategory(),
  // const Jobcategory(),
  // const Csccategory(),
  // ];
  var selectedtext = ['csc category', 'buisness category', 'festival category'];
  var selectedtextvalue;

  Future getcscdata() async {
    var csc = await Authcredential().getfromlocal("cscprofile");
    SentApi().getcscprofieldata().then((value) {
      setState(() {});
    });
    if (csc != null) {
      setState(() {
        cscvalue = jsonDecode(csc);
      });
    }
  }

  Future getuser() async {
    var user = await Authcredential().getfromlocal("userdata");
    SentApi().getuserdata().then((value) {
      setState(() {});
    });
    if (userdata != null) {
      setState(() {
        userdata = jsonDecode(user);
      });
    }
  }

  Future getpremium() async {
    var premium = await Authcredential().getfromlocal("premium");
    SentApi().getpremiumlist().then((value) {
      setState(() {});
    });
    if (premium != null) {
      setState(() {
        premiumtemplatelist = jsonDecode(premium);
      });
    }
  }

  Future getfestivalprofilevalue() async {
    var festival = await Authcredential().getfromlocal("festivalprofile");
    SentApi().getfestivalprofile().then((value) {
      setState(() {});
    });
    if (festival != null) {
      setState(() {
        festivalprofilevalue = jsonDecode(festival);
      });
    }
  }

  getposterimage() async {
    var p = await Authcredential().getfromlocal("poster");
    SentApi().getposterimage().then((value) {
      setState(() {});
    });
    if (p != null) {
      setState(() {
        poster = jsonDecode(p);
      });
    }
  }

  getsubscription() async {
    //print('hitsub');
    var mapreduce = await Authcredential().getfromlocal("subscriptiondetails");
    var data = jsonDecode(mapreduce);
    SentApi().getsubs().then((value) {
      //print("object $subscriptiondetail");
      if (subscriptiondetail != null) {
        var subscribedid = subscriptiondetail["subscription_cat_Id"];
        int indexvalue = int.parse(subscribedid) - 1;
        //print("subde $indexvalue");
        //print("subde $subscribedid");
        setState(() {
          selectedvalue = indexvalue;
        });
      } else {
        setState(() {
          selectedvalue = 0;
        });
      }
    });
    int indexvalue = 0;
    if (data != null) {
      setState(() {
        subscriptiondetail = data;
        var subscribedid = data["subscription_cat_Id"];
        //print("data $subscribedid");
        indexvalue = int.parse(subscribedid) - 1;
      });
    }
    setState(() {
      selectedvalue = indexvalue;
      //print("elses $indexvalue");
    });
  }

  getrequestedpremium() async {
    var requestedpremium =
        await Authcredential().getfromlocal("requestedpremium");
    SentApi().getrequestedpremiumlist().then((value) {
      setState(() {});
    });
    if (requestedpremium != null) {
      setState(() {
        requestedpremiumtemplatelist = jsonDecode(requestedpremium);
      });
    }
  }

  getcscbasicdata() async {
    var cscbasic = await Authcredential().getfromlocal("cscbasic");
    SentApi().getcscbasic().then((value) {
      setState(() {});
    });
    if (cscbasic != null) {
      setState(() {
        onlineserviceposter = jsonDecode(cscbasic);
      });
    }
  }

  getcscsubdata() async {
    var cscsubservice = await Authcredential().getfromlocal("cscsub");
    SentApi().getcscsubservices().then((value) {
      setState(() {});
    });
    if (cscsubservice != null) {
      setState(() {
        onlinesubservice = jsonDecode(cscsubservice);
      });
    }
  }

  getcscimage() async {
    var cscimage = await Authcredential().getfromlocal("cscimage");
    SentApi().getcscimage().then((value) {
      setState(() {});
    });
    if (cscimage != null) {
      setState(() {
        onlineimage = jsonDecode(cscimage);
      });
    }
  }

  getlogodata() async {
    var logo = await Authcredential().getfromlocal("logo");
    SentApi().getlogoservices().then((value) {
      setState(() {});
    });
    if (logo != null) {
      setState(() {
        designlogo = jsonDecode(logo);
      });
    }
  }

  getfacebookdata() async {
    var facebook = await Authcredential().getfromlocal("facebook");
    SentApi().getfacebookservices().then((value) {
      setState(() {});
    });
    if (facebook != null) {
      setState(() {
        facebookcover = jsonDecode(facebook);
      });
    }
  }

  getjobbasicdata() async {
    var jobsbasicca = await Authcredential().getfromlocal("jobbasic");
    SentApi().getjobbasic().then((value) {
      setState(() {});
    });
    if (jobsbasicca != null) {
      setState(() {
        jobcategory = jsonDecode(jobsbasicca);
      });
    }
  }

  getjobsubdata() async {
    var jobsubca = await Authcredential().getfromlocal("jobsub");
    SentApi().getjobsubservices().then((value) {
      setState(() {});
    });
    if (jobsubca != null) {
      setState(() {
        jobsubservicelist = jsonDecode(jobsubca);
      });
    }
  }

  getjobdata() async {
    var jobimag = await Authcredential().getfromlocal("jobimage");
    SentApi().getjobimage().then((value) {
      setState(() {});
    });
    if (jobimag != null) {
      setState(() {
        jobimage = jsonDecode(jobimag);
      });
    }
  }

  getfestival() async {
    var festival = await Authcredential().getfromlocal("festival");
    SentApi().getfestivalposter().then((value) {
      setState(() {});
    });
    if (festival != null) {
      setState(() {
        festivalposter = jsonDecode(festival);
      });
    }
  }

  getschemedata() async {
    var schemeimag = await Authcredential().getfromlocal("schemeimage");
    SentApi().getschemeimage().then((value) {
      setState(() {});
    });
    if (schemeimag != null) {
      setState(() {
        schemeimage = jsonDecode(schemeimag);
        alldataget = true;
      });
    }
  }

  checkvalidation() async {
    final connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      var checkinguservalue = await SentApi().getuserdata();
      if (checkinguservalue['status'] == "0") {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => BlockedPage(),
            ),
            (route) => false);
      }
    } else {
      setState(() {
        nextscreen = Networkpage(
          fromhome: true,
        );
      });
    }
  }

  getpopupvalues() async {
    var value = await Authcredential().getfromlocal("popup");
    var data = jsonDecode(value);
    List newlist = [];
    if (data.isNotEmpty) {
      for (var id in data) {
        if (id['service'] == 'home') {
          setState(() {
            newlist.add(id);
          });
        }
      }
      if (newlist.isNotEmpty && homepopup == false) {
        showDialog(
          context: context,
          builder: (context) {
            return PopupPage(value: newlist);
          },
        );
        setState(() {
          homepopup = true;
        });
      }
    }
  }

  getwallethistorydata() async {
    var wallet = await Authcredential().getfromlocal("wallethistory");
    SentApi().getwallethistorydata().then((value) {
      setState(() {});
    });
    if (wallet != null) {
      setState(() {
        wallethistory = jsonDecode(wallet);
      });
    }
  }

  getnotificationdata() async {
    var notification = await Authcredential().getfromlocal("notification");
    SentApi().getnotificationdata().then((value) {
      setState(() {});
    });
    if (notification != null) {
      setState(() {
        notificationlist = jsonDecode(notification);
      });
    }
  }

  getdata() async {
    var data = await SentApi().getdownloadandsharedata();
    var balancedata = await SentApi().getbalancedata();
    setState(() {
      downloaddata = data;
      balancedata = balancedata;
    });
  }

  getpopupdatavalue() {
    SentApi().getpopuplist().then((value) {
      setState(() {});
    });
  }

  @override
  void initState() {
    super.initState();
    getallvalues();
    if (subscriptiondetail != null) {
      setState(() {
        var subscribedid = subscriptiondetail["subscription_cat_Id"];
        //print("data $subscribedid");
        selectedvalue = int.parse(subscribedid) - 1;
      });
    } else {
      setState(() {
        selectedvalue = 0;
      });
    }
  }

  getgreetingdata() async {
    var cscbasic = await Authcredential().getfromlocal("greetingbasic");
    SentApi().getgreetingbasic().then((value) {
      setState(() {});
    });
    setState(() {
      greetingcategory = jsonDecode(cscbasic);
    });
  }

  getgreetingsubdata() async {
    var cscsubservice = await Authcredential().getfromlocal("greetingsub");
    SentApi().getgreetingsubservices().then((value) {
      setState(() {});
    });
    setState(() {
      greetingssubservice = jsonDecode(cscsubservice);
    });
  }

  getgreetingimage() async {
    var cscimage = await Authcredential().getfromlocal("greetingimage");
    SentApi().getgreetingimage().then((value) {
      setState(() {});
    });
    setState(() {
      greetingimage = jsonDecode(cscimage);
    });
  }

  getcurrentposterimages() async {
    var value = await SentApi().getcurrentposterimage();

    setState(() {
      currentposterimages = value;
    });
    print(value);
  }

  getallvalues() {
    getcurrentposterimages();
    getdata();
    getsubscription();
    getposterimage();
    getnotificationdata();
    getwallethistorydata();
    getpopupvalues();
    getcscbasicdata();
    getcscsubdata();
    getcscimage();
    getcscdata();
    getgreetingdata();
    getgreetingsubdata();
    getgreetingimage();
    getuser();
    getpremium();
    getfestivalprofilevalue();
    getrequestedpremium();
    getlogodata();
    getjobdata();
    getfacebookdata();
    getschemedata();
    getfestival();
    getjobsubdata();
    getjobbasicdata();
    checkvalidation();
    getpopupdatavalue();
  }

  List<Widget> images() {
    final List<Widget> imageSliders = List.generate(poster.length,
            (index) => '$weburl/${poster[index]['category_image']}')
        .map(
          (item) => item.isEmpty
              ? Container(
                  height: AppLayout.getHeight(50),
                  decoration:
                      BoxDecoration(border: Border.all(color: blackcolor)),
                )
              : InkWell(
                  onTap: () {},
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                    child: CachedNetworkImage(
                      imageUrl: item,
                      fit: BoxFit.fill,
                      width: double.maxFinite,
                    ),
                  ),
                ),
        )
        .toList();
    return imageSliders;
  }

  var nextscreen;
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      color: appBarColor,
      onRefresh: () async {
        final connectivityResult = await (Connectivity().checkConnectivity());
        if (connectivityResult == ConnectivityResult.mobile ||
            connectivityResult == ConnectivityResult.wifi) {
          setState(() {
            nextscreen = null;
          });
          await getallvalues();
        } else {
          setState(() {
            nextscreen = Networkpage(
              fromhome: true,
            );
          });
        }
      },
      child: nextscreen ??
          Scaffold(
            key: widget.key,
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView(
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          widget.scaffoldKey.currentState!.openDrawer();
                        },
                        child: Row(
                          children: [
                            const Icon(
                              Icons.menu,
                              size: 30,
                            ),
                            const SizedBox(width: 20),
                            userdata == null || userdata == []
                                ? const Center(child: Text("Welcome"))
                                : CircleAvatar(
                                    radius: 18,
                                    backgroundImage: CachedNetworkImageProvider(
                                      "$weburl/${userdata["profile_img"]}",
                                    ),
                                  ),
                          ],
                        ),
                      ),
                      w(10),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.3,
                        height: 40,
                        child: userdata == null
                            ? const SizedBox.shrink()
                            : RichText(
                                softWrap: true,
                                text: TextSpan(
                                    text: 'Hi, ',
                                    style: TextStyle(
                                        height: 1.5,
                                        fontSize: 13,
                                        color: blackcolor),
                                    children: [
                                      TextSpan(
                                          text: "${userdata["name"]}",
                                          style: TextStyle(
                                              height: 1.5,
                                              fontSize: 13,
                                              color: blackcolor)),
                                      TextSpan(
                                          text: " Welcome",
                                          style: TextStyle(
                                              height: 1.5,
                                              fontSize: 13,
                                              color: blackcolor))
                                    ]),
                              ),
                      ),
                      const Spacer(),
                      GestureDetector(
                          onTap: () {
                            toScreen(context, NotificationPage());
                          },
                          child: Icon(
                            Icons.notifications_active,
                            color: primaryColor,
                            size: 40,
                          )),
                      w(10),
                      userdata != null
                          ? Column(
                              children: [
                                CircularPercentIndicator(
                                  lineWidth: 3.5,
                                  reverse: true,
                                  percent: subscriptiondetail == null
                                      ? DateTime.now()
                                                  .difference(DateTime.parse(
                                                      userdata['created_at']))
                                                  .inDays >
                                              7
                                          ? 0.00
                                          : (7 -
                                                  DateTime.now()
                                                      .difference(DateTime
                                                          .parse(userdata[
                                                              'created_at']))
                                                      .inDays) /
                                              7.toDouble()
                                      : int.parse(subscriptiondetail[
                                                  'days_left']) <
                                              0
                                          ? 0.0
                                          : (int.parse(subscriptiondetail[
                                                      'days_left']) /
                                                  int.parse(subscriptiondetail[
                                                      'plan_duration']))
                                              .toDouble(),
                                  radius: 20,
                                  progressColor: primaryColor,
                                  center: Text(
                                    subscriptiondetail == null
                                        ? DateTime.now()
                                                    .difference(DateTime.parse(
                                                        userdata['created_at']))
                                                    .inDays >
                                                7
                                            ? "0"
                                            : (7 -
                                                    DateTime.now()
                                                        .difference(DateTime
                                                            .parse(userdata[
                                                                'created_at']))
                                                        .inDays)
                                                .toString()
                                        : int.parse(subscriptiondetail[
                                                    'days_left']) <
                                                0
                                            ? "0"
                                            : int.parse(subscriptiondetail[
                                                    'days_left'])
                                                .toString(),
                                    style: TextStyle(color: blackcolor),
                                  ),
                                ),
                                Text(
                                  "Days Left",
                                )
                              ],
                            )
                          : SizedBox.shrink(),
                    ],
                  ),
                  h(10),
                  poster.isEmpty
                      ? const SizedBox.shrink()
                      : SizedBox(
                          height: AppLayout.getHeight(150),
                          child: CarouselSlider(
                            carouselController: _carouselController,
                            items: images(),
                            options: CarouselOptions(
                              viewportFraction: 1,
                              autoPlay: true,
                              enlargeCenterPage: true,
                            ),
                          ),
                        ),
                  h(10),
                  selectedvalue == 0
                      ? Csccategory(
                          onlineposter: onlineserviceposter,
                        )
                      : selectedvalue == 1
                          ? Festivalcategory()
                          : Center(
                              child: Image.asset(
                              "assets/loading.gif",
                              height: 100,
                            ))
                ],
              ),
            ),
          ),
    );
  }
}

class Poster extends StatelessWidget {
  final Color color;
  final Widget child;
  final String title;
  final void Function()? onTap;

  const Poster({
    Key? key,
    required this.color,
    required this.child,
    required this.title,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    child,
                    w(5),
                    Text(
                      'CREATE\n$title POSTER',
                      textAlign: TextAlign.justify,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: whitecolor),
                    )
                  ],
                ),
              ),
            ),
            Positioned(
              child: Image.asset(
                'assets/new.png',
                height: 35,
              ),
            )
          ],
        ),
      ),
    );
  }
}
