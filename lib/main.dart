import 'dart:io';

import 'package:click/pages/authcredential.dart';
import 'package:click/pages/bottom_navigation/blockedpage.dart';
import 'package:click/pages/drawer/dynamic.dart';
import 'package:click/pages/getapi.dart';
import 'package:click/pages/landing_page.dart';
import 'package:click/pages/login.dart';
import 'package:click/utils/constants.dart';
import 'package:click/utils/styles.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_windowmanager/flutter_windowmanager.dart';
import 'package:permission_handler/permission_handler.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // if (Platform.isAndroid) {
  await FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);
  await Firebase.initializeApp();
  var value = await Dynamiclinkprovider().initdynamiclink();
  Authcredential().savevaluetolocal("Referal", "$value");
  final fcmToken = await FirebaseMessaging.instance.getToken();
  Authcredential().savevaluetolocal("fcmtoken", "$fcmToken");
  FirebaseMessaging.instance.subscribeToTopic("all").whenComplete(() {
    FirebaseMessaging.onMessage.listen(backgroundHnadler);
  });
  // }
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  FirebaseMessaging.onBackgroundMessage(backgroundHnadler);
  runApp(const MyApp());
}

@pragma('vm:entry-point')
Future backgroundHnadler(RemoteMessage message) async {}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: primarySwatch,
        listTileTheme: ListTileThemeData(
          iconColor: primaryColor,
        ),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(
            fontSize: 18,
          ),
        ),
        fontFamily: 'Poppins',
        appBarTheme: AppBarTheme(
          backgroundColor: appBarColor,
          iconTheme: const IconThemeData(
            color: Colors.white,
          ),
          elevation: 0.0,
          foregroundColor: Colors.white,
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: const Newmypage(),
    );
  }
}

class Newmypage extends StatefulWidget {
  const Newmypage({Key? key}) : super(key: key);

  @override
  State<Newmypage> createState() => _NewmypageState();
}

class _NewmypageState extends State<Newmypage> with TickerProviderStateMixin {
  Widget? nextscreen;
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 2),
  )..forward(from: 0);
  late final Animation<double> _animation =
      CurvedAnimation(parent: _controller, curve: Curves.easeIn);

  @override
  void initState() {
    super.initState();
    checkLogin();
  }

//cheklogin token from mobile storage
  void checkLogin() async {
    var t = await Authcredential().getToken();

    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      if (t != null) {
        setState(() {
          token = t;
        });
        print(token);
        var checkinguservalue = await SentApi().getuserdata();
        print(checkinguservalue);
        if (checkinguservalue == "Invalid") {
          setState(() {
            nextscreen = Login();
          });
        } else {
          if (checkinguservalue['status'] == "1") {
            setState(() {
              nextscreen = LandingPage(value: 0);
            });
          } else {
            setState(() {
              nextscreen = BlockedPage();
            });
          }
        }
      } else {
        setState(() {
          nextscreen = const Login();
        });
      }
    } else {
      setState(() {
        nextscreen = Networkpage();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: nextscreen ??
            Scaffold(
                body: ScaleTransition(
                    scale: _animation,
                    child: Center(
                        child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                           "assets/instapost.png",
                            width: 250,
                            height: 250,
                          ),
                          h(5),
                          Text(
                            "ADDON",
                            textScaleFactor: 4,
                            style: TextStyle(fontFamily: "news706"),
                          ),
                        ],
                      ),
                    )))));
  }
}

class Networkpage extends StatefulWidget {
  bool? fromhome;
  Networkpage({super.key, this.fromhome});

  @override
  State<Networkpage> createState() => _NetworkpageState();
}

class _NetworkpageState extends State<Networkpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/nointernet.png"),
            Text(
              "No Network Connection Found",
              textScaleFactor: 1.5,
              textAlign: TextAlign.center,
            ),
            h(15),
            SizedBox(
              width: MediaQuery.of(context).size.width * .5,
              child: MaterialButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                color: Colors.redAccent,
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => widget.fromhome == true
                            ? LandingPage(value: 0)
                            : Newmypage(),
                      ),
                      (route) => false);
                },
                child: Text(
                  "Try Again",
                  style: TextStyle(color: whitecolor),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
