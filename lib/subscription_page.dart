// ignore_for_file: must_be_immutable, prefer_typing_uninitialized_variables
import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:click/pages/landing_page.dart';
import 'package:click/utils/constants.dart';
import 'package:click/utils/navigation.dart';
import 'package:click/utils/styles.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'pages/authcredential.dart';

class Subscriptionpage extends StatefulWidget {
  var frompage;
  Subscriptionpage({Key? key, this.frompage}) : super(key: key);

  @override
  State<Subscriptionpage> createState() => _SubscriptionpageState();
}

class _SubscriptionpageState extends State<Subscriptionpage> {
  var activeplan;
  int selectedsub = 0;
  late Razorpay _razorpay;

  void launchRazorpay() {
    var doublevalue = (double.parse(subscription[selectedsub]['fee']) -
        double.parse(subscription[selectedsub]['discount']));
    var totalval = doublevalue.toInt() * 100;

    var options = {
      'key': "$razorpaykeyvalue",
      'amount': totalval,
      'currency': 'INR',
      'name': 'ADDON',
      'description': subscription[selectedsub]['subscription_name'],
    };
    try {
      _razorpay.open(options);
    } catch (e) {
      if (kDebugMode) {}
    }
  }

  void initializeRazorpay() {
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) async {
    if (kDebugMode) {
      //print('Payment Sucessfull');
      // toScreen(context, LandingPage(value: 2));
      Authcredential().storeindex('$selectedsub');
    }
    successsubscription(
      "${response.paymentId}",
      "${subscription[selectedsub]["id"]}",
    );
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    if (kDebugMode) {
      //print('Payment error');
      Fluttertoast.showToast(msg: 'Payment error');
    }
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    if (kDebugMode) {
      //print('External wallet');
      Fluttertoast.showToast(msg: 'Payment Failed');
    }
  }

  Future successsubscription(var transactionId, var subscriptionId) async {
    var gettoken = await Authcredential().getToken();
    var message;
    try {
      http.Response response =
          await http.post(Uri.parse("${baseurl}subscribed_plans"), headers: {
        'token': '$gettoken'
      }, body: {
        "subscription_id": "${subscriptionId}",
        "transaction_id": "${transactionId}",
      });
      print(response.body);
      var mapres = json.decode(response.body);
      message = mapres['response']['response_message'];
      if (response.statusCode == 200) {
        Fluttertoast.showToast(msg: message);
        toScreen(context, LandingPage(value: 2));
        print(message);
      }
    } catch (e) {
      Fluttertoast.showToast(msg: message);
      print(message);
    }
  }

  Future getsubscription() async {
    var gettoken = await Authcredential().getToken();
    http.Response response = await http.get(
        Uri.parse('$weburl/api/api/subscription_plans'),
        headers: {'token': '$gettoken'});
    var mapreduce = json.decode(response.body);
    setState(() {
      subscription = mapreduce['data'];
    });

    return mapreduce;
  }

  getsubs() async {
    if (subscriptiondetail != null) {
      if (int.parse(subscriptiondetail['days_left']) >= 0) {
        setState(() {
          activeplan = subscriptiondetail['plan_id'];
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    initializeRazorpay();
    getsubscription();
    getsubs();
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: subscription.isEmpty
          ? Center(
              child: Image.asset(
              "assets/loading.gif",
              height: 100,
            ))
          : Center(
              child: CarouselSlider.builder(
                itemCount: subscription.length,
                options: CarouselOptions(
                  aspectRatio: .62,
                  autoPlay: false,
                  enlargeCenterPage: true,
                ),
                itemBuilder: (context, index, realIndex) {
                  final duration = Duration(
                      days: int.parse(subscription[index]['duration']));
                  final totalMonths = duration.inDays ~/
                      30; // Using integer division to get whole months
                  var month = totalMonths;

                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: whitecolor,
                          border: Border.all(
                              color: colorcombination[index]['1'], width: 3),
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 4,
                              color: blackcolor,
                            )
                          ],
                          borderRadius: BorderRadius.circular(18)),
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                color: colorcombination[index]['1'],
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(15),
                                    topRight: Radius.circular(15))),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Text(
                                    subscription[index]['subscription_name'],
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontFamily: "news706",
                                      color: whitecolor,
                                    ),
                                  ),
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  color: Colors.yellow,
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        children: [
                                          double.parse(subscription[index]
                                                          ['discount'])
                                                      .toInt() ==
                                                  0
                                              ? SizedBox.shrink()
                                              : Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      "Not For",
                                                      style: TextStyle(
                                                          color: blackcolor,
                                                          fontSize: 15),
                                                    ),
                                                    w(10),
                                                    Text(
                                                      "\u{20B9} ${double.parse(subscription[index]['fee']).toInt()}",
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          decoration:
                                                              TextDecoration
                                                                  .lineThrough,
                                                          color: blackcolor,
                                                          fontSize: 15),
                                                    ),
                                                  ],
                                                ),
                                          int.parse(subscription[index]
                                                      ['duration']) <
                                                  30
                                              ? Text(
                                                  "\u{20B9} ${(double.parse(subscription[index]['fee']) - double.parse(subscription[index]['discount'])).toInt()}/${subscription[index]['duration']} Days",
                                                  style: const TextStyle(
                                                      fontFamily:
                                                          "Poppins-SemiBold",
                                                      fontSize: 22),
                                                )
                                              : Text(
                                                  "\u{20B9} ${(double.parse(subscription[index]['fee']) - double.parse(subscription[index]['discount'])).toInt()}/$month month",
                                                  style: const TextStyle(
                                                      fontFamily:
                                                          "Poppins-SemiBold",
                                                      fontSize: 22),
                                                ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            "Plan Features",
                            textAlign: TextAlign.start,
                            textScaleFactor: 1.4,
                          ),
                          h(2),
                          Expanded(
                            child: SingleChildScrollView(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: List.generate(
                                      "${subscription[index]['primary_list']}"
                                              .split("</li>")
                                              .length -
                                          1, (i) {
                                    var value =
                                        "${subscription[index]['primary_list']}"
                                            .split("</li>");
                                    return Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.check_circle,
                                            color: Colors.green,
                                          ),
                                          w(5),
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                1.8,
                                            child: HtmlWidget(
                                                "${value[i]}</li>",
                                                textStyle: TextStyle(
                                                    overflow:
                                                        TextOverflow.ellipsis)),
                                          ),
                                        ],
                                      ),
                                    );
                                  }),
                                ),
                              ),
                            ),
                          ),
                          Container(
                              padding: EdgeInsets.all(10),
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                  color: colorcombination[index]['1'],
                                  borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(15),
                                      bottomRight: Radius.circular(15))),
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 25),
                                child: activeplan == subscription[index]['id']
                                    ? Column(
                                        children: [
                                          Text("Active Plan"),
                                          Text(
                                              "${subscriptiondetail['days_left']} days left"),
                                        ],
                                      )
                                    : activeplan != null
                                        ? SizedBox.shrink()
                                        : Container(
                                            child: MaterialButton(
                                                color: whitecolor,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15)),
                                                onPressed: () {
                                                  setState(() {
                                                    selectedsub = index;
                                                  });
                                                  if (subscription[index]
                                                          ['fee'] ==
                                                      "0.00") {
                                                    toScreen(context,
                                                        LandingPage(value: 0));
                                                  } else {
                                                    launchRazorpay();
                                                  }
                                                },
                                                child: Text(
                                                  'Subscribe Plan',
                                                  style: TextStyle(
                                                    fontSize: 18,
                                                    color:
                                                        colorcombination[index]
                                                            ['1'],
                                                  ),
                                                )),
                                          ),
                              ))
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
    );
  }

  List colorcombination = [
    {"1": primaryColor, "2": Colors.yellow},
    {"1": Color(0xff9f26ff), "2": Colors.yellow},
    {"1": Color(0xff45cd3b), "2": Colors.yellow},
    {"1": Color(0xff000c98), "2": Colors.yellow},
    {"1": Color(0xffe800e9), "2": Colors.yellow},
    {"1": Color(0xff703c00), "2": Colors.yellow},
    {"1": primaryColor, "2": Colors.yellow},
    {"1": Color(0xff9f26ff), "2": Colors.yellow},
    {"1": Color(0xff45cd3b), "2": Colors.yellow},
    {"1": Color(0xff000c98), "2": Colors.yellow},
    {"1": Color(0xffe800e9), "2": Colors.yellow},
    {"1": Color(0xff703c00), "2": Colors.yellow},
  ];
}
