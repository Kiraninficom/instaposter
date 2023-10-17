import 'package:click/pages/drawer/dynamic.dart';
import 'package:click/utils/constants.dart';
import 'package:click/utils/styles.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:share_plus/share_plus.dart';

class ReferAndEarnPage extends StatefulWidget {
  const ReferAndEarnPage({super.key});

  @override
  State<ReferAndEarnPage> createState() => _ReferAndEarnPageState();
}

class _ReferAndEarnPageState extends State<ReferAndEarnPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: primaryColor,
          title: Text("Refer & Earn"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: [
              Align(
                alignment: Alignment.center,
                child: Text(
                  "Invite your friends & Earn",
                  style: TextStyle(
                      color: primaryColor,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Align(
                alignment: Alignment.center,
                child: Text(
                  "You get 10% of your referral’s Earnings!",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    height: 200,
                    width: 200,
                    decoration: BoxDecoration(
                        border: Border.all(color: blackcolor, width: 0.8),
                        borderRadius: BorderRadius.circular(15)),
                  ),
                  Positioned(
                    child: Image.asset(
                      "assets/refer.png",
                      width: 270,
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Align(
                alignment: Alignment.center,
                child: Text(
                  "Referral Joined - ${userdata['referal_count'] ?? "0"}",
                  style: TextStyle(
                      fontSize: 20,
                      color: primaryColor,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              DottedBorder(
                dashPattern: [10, 5],
                strokeWidth: 1.2,
                radius: Radius.circular(10),
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "${userdata['referal']}",
                          style: TextStyle(color: blackcolor, fontSize: 20),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        InkWell(
                          onTap: () async {
                            await Clipboard.setData(
                                ClipboardData(text: "${userdata['referal']}"));
                            Fluttertoast.showToast(msg: "copied successfully");
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "COPY",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: blackcolor,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Icon(Icons.copy),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Align(
                alignment: Alignment.center,
                child: InkWell(
                  onTap: () {
                    Dynamiclinkprovider()
                        .shareReferralLink("ABCDE1234A")
                        .then((value) {
                      Share.share(value);
                    });
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width / 3,
                    decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            "SHARE",
                            style: TextStyle(
                                fontSize: 15,
                                color: whitecolor,
                                fontWeight: FontWeight.bold),
                          ),
                          Icon(
                            Icons.share,
                            color: whitecolor,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              // SizedBox(height: 20),
              // Padding(
              //   padding: const EdgeInsets.all(15.0),
              //   child: Align(
              //     alignment: Alignment.center,
              //     child: Container(
              //       decoration: BoxDecoration(
              //           border: Border.all(color: blackcolor, width: 0.8),
              //           borderRadius: BorderRadius.circular(15)),
              //       child: Padding(
              //         padding: const EdgeInsets.all(8.0),
              //         child: Column(
              //           crossAxisAlignment: CrossAxisAlignment.start,
              //           children: [
              //             Text(
              //               "How to Works?",
              //               style: TextStyle(
              //                   color: blackcolor,
              //                   fontSize: 20,
              //                   fontWeight: FontWeight.bold),
              //             ),
              //             SizedBox(height: 15),
              //             ...List.generate(
              //                 steps.length,
              //                 (index) => Padding(
              //                       padding:
              //                           const EdgeInsets.only(bottom: 15.0),
              //                       child: Row(
              //                         children: [
              //                           Text("Steps ${index + 1} :\n"),
              //                           Expanded(child: Text(steps[index]))
              //                         ],
              //                       ),
              //                     ))
              //           ],
              //         ),
              //       ),
              //     ),
              //   ),
              // )
            ],
          ),
        ),
      ),
    );
  }
}

var steps = [
  "Earn extra cashback for referring your friends and family",
  "Your referral joins Insta Rupee using your referral code and completes registration",
  "Explain your referral and how to use Insta Rupee App",
  "Get lifetime earning of 10% on your referral’s earnings",
];
