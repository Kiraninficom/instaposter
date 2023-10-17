import 'package:click/main.dart';
import 'package:click/pages/bottom_navigation/account/contactdialog.dart';
import 'package:click/utils/styles.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

class BlockedPage extends StatefulWidget {
  const BlockedPage({super.key});

  @override
  State<BlockedPage> createState() => _BlockedPageState();
}

class _BlockedPageState extends State<BlockedPage> {
  @override
  void initState() {
    super.initState();
    checkconnection();
  }

  checkconnection() async {
    final connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
    } else {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (context) => Networkpage(
                    fromhome: true,
                  )),
          (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: primaryColor,
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Your Account is Blocked By Admin Contact On Support",
                style: TextStyle(fontSize: 25, fontFamily: 'Poppins'),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: whitecolor,
                    boxShadow: [BoxShadow(blurRadius: 2, color: blackcolor)],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ContactDialog(forblockpage: true)),
            ),
          ],
        ),
      ),
    );
  }
}
