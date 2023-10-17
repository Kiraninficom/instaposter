import 'dart:convert';

import 'package:click/pages/authcredential.dart';
import 'package:click/pages/getapi.dart';
import 'package:click/utils/constants.dart';
import 'package:click/utils/navigation.dart';
import 'package:click/utils/styles.dart';
import 'package:click/widgets/textfield.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:http/http.dart' as http;

class Walletpage extends StatefulWidget {
  const Walletpage({super.key});

  @override
  State<Walletpage> createState() => _WalletpageState();
}

class _WalletpageState extends State<Walletpage> {
  TextEditingController moneyamount = TextEditingController();
  late Razorpay _razorpay;
  amountadded(var transid) async {
    var message;
    try {
      var gettoken = await Authcredential().getToken();
      http.Response response = await http
          .post(Uri.parse('${baseurl}user_wallet_recharge'), headers: {
        'token': '$gettoken'
      }, body: {
        "amount": moneyamount.text,
        "currency_code": "inr",
        "transaction_id": "$transid"
      });
      var mapresponse = json.decode(response.body);
      message = "${mapresponse['response']['response_message']}";
      await SentApi().getbalancedata();
      await SentApi().getwallethistorydata();
      setState(() {});
      Fluttertoast.showToast(msg: "$message");
    } catch (e) {
      Fluttertoast.showToast(msg: "$message");
    }
  }

  void launchRazorpay() {
    var doublevalue = double.parse(moneyamount.text);
    var totalval = doublevalue.toInt() * 100;

    var options = {
      'key': "$razorpaykeyvalue",
      'amount': totalval,
      'currency': 'INR',
      'name': 'ADDON',
      'description': "Add money in Wallet",
      'prefill': {'contact': userdata['mobileno'], 'email': userdata['email']}
    };
    try {
      _razorpay.open(options);
    } catch (e) {
      if (kDebugMode) {
        //print("Error: $e");
      }
    }
  }

  void initializeRazorpay() {
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) async {
    backscreen(context);
    amountadded(response.paymentId);
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

  @override
  void initState() {
    super.initState();
    initializeRazorpay();
    getdata();
  }

  getdata() async {
    var data = await SentApi().getbalancedata();
    var data1 = await SentApi().getwallethistorydata();
    setState(() {
      balancedata = data;
      wallethistory = data1;
    });
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  @override
  Widget build(BuildContext context) {
    //print(wallethistory);
    return RefreshIndicator(
      color: appBarColor,
      onRefresh: () async {
        var data = await SentApi().getbalancedata();
        var data1 = await SentApi().getwallethistorydata();
        print(data);
        setState(() {
          balancedata = data;
          wallethistory = data1;
        });
      },
      child: SafeArea(
        child: Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              elevation: 0,
              backgroundColor: whitecolor,
              title: Row(
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.arrow_back, color: Colors.black)),
                  Text(
                    subscriptiondetail['plan_type'] == '1' ? "" : "My Account",
                    style: TextStyle(color: Colors.black),
                  )
                ],
              ),
            ),
            body: Column(
              children: [
                subscriptiondetail['plan_type'] == '1'
                    ? Container()
                    : Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                    blurRadius: 5.0,
                                    color: Colors.red.shade200,
                                    offset: const Offset(0, 5)),
                              ],
                              borderRadius: BorderRadius.circular(15.0),
                              color: primaryColor),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "Mobile No. ${userdata['mobileno']}",
                                  style: TextStyle(
                                      color: whitecolor, fontSize: 15),
                                ),
                              ),
                              IntrinsicHeight(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width /
                                          2.5,
                                      child: Column(
                                        children: [
                                          Text(
                                            "Account Bal.",
                                            style: TextStyle(
                                                color: whitecolor,
                                                fontSize: 18,
                                                fontWeight: FontWeight.w500,
                                                fontFamily: "Poppins"),
                                          ),
                                          Text(
                                            "${balancedata['available_balance']}",
                                            style: TextStyle(
                                                color: whitecolor,
                                                fontSize: 18,
                                                fontWeight: FontWeight.w500,
                                                fontFamily: "Poppins"),
                                          ),
                                        ],
                                      ),
                                    ),
                                    VerticalDivider(
                                      color: whitecolor,
                                      thickness: 1.2,
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width /
                                          2.5,
                                      child: Column(
                                        children: [
                                          Text(
                                            "Validity",
                                            style: TextStyle(
                                                color: whitecolor,
                                                fontSize: 18,
                                                fontWeight: FontWeight.w500,
                                                fontFamily: "Poppins"),
                                          ),
                                          Text(
                                            "${subscriptiondetail['days_left']} Days Left",
                                            style: TextStyle(
                                                color: whitecolor,
                                                fontSize: 18,
                                                fontWeight: FontWeight.w500,
                                                fontFamily: "Poppins"),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              h(10),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: whitecolor,
                                ),
                                child: MaterialButton(
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return addmoney();
                                        });
                                  },
                                  child: Text(
                                    'Add Balance',
                                    style: TextStyle(color: blackcolor),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                const Padding(
                  padding: EdgeInsets.all(20),
                  child: Text(
                    "Transaction History",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontFamily: "assets/fonts/Poppins"),
                  ),
                ),
                wallethistory.isEmpty
                    ? const Center(child: Text("No transaction history"))
                    : Expanded(
                        child: ListView.builder(
                            // physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: wallethistory.length,
                            itemBuilder: (context, index) {
                              DateTime cr = DateTime.parse(
                                  "${wallethistory[index]['created_at']}");
                              DateFormat dateFormat =
                                  DateFormat.yMMMMd('en_US');
                              String formattedDate = dateFormat.format(cr);
                              return Card(
                                color: "${wallethistory[index]['reason']}"
                                            .contains("Subscribed") ||
                                        "${wallethistory[index]['reason']}"
                                            .contains("recharge")
                                    ? appBarColor
                                    : whitecolor,
                                elevation: 2,
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                // Text(
                                                //   "${wallethistory[index]['transaction_id']}",
                                                //   style: TextStyle(
                                                //       color: blackcolor),
                                                // ),
                                                Text(
                                                  "${wallethistory[index]['reason']}",
                                                  style: TextStyle(
                                                    color: "${wallethistory[index]['reason']}"
                                                                .contains(
                                                                    "Subscribed") ||
                                                            "${wallethistory[index]['reason']}"
                                                                .contains(
                                                                    "recharge")
                                                        ? whitecolor
                                                        : blackcolor,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          subscriptiondetail['plan_type'] ==
                                                      '1' ||
                                                  subscriptiondetail[
                                                          'plan_type'] ==
                                                      null
                                              ? SizedBox.shrink()
                                              : Text(
                                                  wallethistory[index][
                                                              'credit_wallet'] !=
                                                          '0'
                                                      ? "${wallethistory[index]['credit_wallet']}"
                                                      : "-${wallethistory[index]['debit_wallet']}",
                                                  style: TextStyle(
                                                      color: wallethistory[
                                                                      index][
                                                                  'credit_wallet'] !=
                                                              '0'
                                                          ? Colors.green
                                                          : redcolor,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      fontSize: 20),
                                                ),
                                        ],
                                      ),
                                      h(10),
                                      Text(
                                        "$formattedDate (${cr.hour}:${cr.minute})",
                                        style: TextStyle(
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }),
                      ),
              ],
            )),
      ),
    );
  }

  Widget addmoney() {
    return Dialog(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
              alignment: Alignment.centerRight,
              child: InkWell(
                  onTap: () {
                    backscreen(context);
                  },
                  child: const Icon(Icons.close)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomTextField(
              controller: moneyamount,
              labelText: "Enter Amount",
            ),
          ),
          MaterialButton(
            color: primaryColor,
            onPressed: () {
              if (moneyamount.text.isNotEmpty) {
                launchRazorpay();
              }
            },
            child: const Text("Add"),
          )
        ],
      ),
    );
  }
}
