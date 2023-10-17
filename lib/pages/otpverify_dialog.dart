import 'dart:async';
import 'dart:convert';

import 'package:click/pages/changepassword.dart';
import 'package:click/pages/login.dart';
import 'package:click/utils/constants.dart';
import 'package:click/utils/navigation.dart';
import 'package:click/utils/styles.dart';
import 'package:click/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:sms_autofill/sms_autofill.dart';

class Otpdialog extends StatefulWidget {
  var mobilenumber;
  var userid;
  bool? forgot;

  Otpdialog({super.key, this.mobilenumber, this.forgot, this.userid});

  @override
  State<Otpdialog> createState() => _OtpdialogState();
}

class _OtpdialogState extends State<Otpdialog> {
  int counter = 10 * 60;
  bool progress = false;
  Timer? _timer;
  int attempts = 0;
  String otp = "";
  var appSignature = "";
  OtpFieldController otpController = OtpFieldController();

  resendcode() async {
    var message;
    try {
      http.Response response =
          await http.post(Uri.parse("${baseurl}resendOtp"), body: {
        'user_id': "${widget.userid}",
        'signature': appSignature,
        "mobileno": widget.mobilenumber
      });
      var mapresponse = json.decode(response.body);
      message = '${mapresponse['response']['response_message']}';
      if (response.statusCode == 200) {
        //print(mapresponse);
        Fluttertoast.showToast(msg: "$message");
        setState(() {
          otpController.clear();
          otp = "";
          counter = 10 * 60;
        });
        startTimer();
      }
      _listenForCode();
    } catch (e) {
      //print(e);
      Fluttertoast.showToast(msg: "$message");
    }
  }

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = Timer.periodic(oneSec, (timer) {
      setState(() {
        if (counter == 0) {
          _timer?.cancel();
        } else {
          counter--;
        }
      });
    });
  }

  verifyotp(var otpvalue) async {
    var message;
    //print(otpvalue);
    setState(() {
      progress = true;
    });
    try {
      http.Response response = await http.post(
          Uri.parse(widget.forgot == true
              ? "${baseurl}verifyOtpForgotPass"
              : "${baseurl}verifyOtp"),
          body: {
            'otp': "$otpvalue",
            'user_id': "${widget.userid}",
          });
      var mapresponse = json.decode(response.body);
      message = '${mapresponse['response']['response_message']}';
      if (response.statusCode == 200) {
        //print(mapresponse);
        Fluttertoast.showToast(msg: "$message");
        if (mapresponse['data']['status'] == true) {
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
            builder: (context) {
              if (widget.forgot == true) {
                return ChangePassword(
                  id: "${widget.userid}",
                );
              } else {
                return Login();
              }
            },
          ), (route) => false);
        }
      }
    } catch (e) {
      //print(e);
      backscreen(context);
      Fluttertoast.showToast(msg: "$message");
      setState(() {
        progress = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    startTimer();
    _listenForCode();
    SmsAutoFill().getAppSignature.then((signature) {
      setState(() {
        appSignature = signature;
      });
    });
  }

  @override
  void dispose() {
    SmsAutoFill().unregisterListener();
    super.dispose();
  }

  void _listenForCode() async {
    await SmsAutoFill().listenForCode();
  }

  @override
  Widget build(BuildContext context) {
    var number = "${widget.mobilenumber}".substring(6, 10);
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Wrap(
          alignment: WrapAlignment.center,
          children: [
            Opacity(
              opacity: 0.0,
              child: Container(
                height: 10,
                child: PinFieldAutoFill(
                  codeLength: 4,
                  onCodeChanged: (p0) {
                    print(p0);
                    if (p0!.length != 0) {
                      otpController.set(p0.split(""));
                    }
                    print("otp$otp");
                  },
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Please enter the OTP to verify your account",
                textAlign: TextAlign.center,
                style: TextStyle(color: redcolor, fontSize: 18),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'A code has been sent to ******$number on WhatsApp and text message.',
                textAlign: TextAlign.center,
              ),
            ),
            OTPTextField(
                controller: otpController,
                length: 4,
                width: MediaQuery.of(context).size.width,
                textFieldAlignment: MainAxisAlignment.spaceAround,
                fieldWidth: 45,
                fieldStyle: FieldStyle.box,
                outlineBorderRadius: 8,
                style: TextStyle(fontSize: 17),
                onChanged: (pin) {
                  setState(() {
                    otp = pin;
                  });
                },
                onCompleted: (pin) {
                  setState(() {
                    otp = pin;
                  });
                }),
            progress == true
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Padding(
                    padding: EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * .8,
                      child: MaterialButton(
                        onPressed: () {
                          if ("$otp".length == 4) {
                            verifyotp(otp);
                          } else {
                            Fluttertoast.showToast(msg: "Enter Correct Otp");
                          }
                        },
                        color: redcolor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        child: Text(
                          "Validate",
                          style: TextStyle(color: whitecolor),
                        ),
                      ),
                    ),
                  ),
            attempts >= 3
                ? SizedBox.shrink()
                : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Didn't get a code"),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Opacity(
                              opacity: counter == 0 ? 1.0 : 0.6,
                              child: InkWell(
                                onTap: () {
                                  if (counter == 0) {
                                    resendcode();
                                    attempts = attempts + 1;
                                  }
                                },
                                child: Text(
                                  "Resend code($attempts/3)",
                                  style: TextStyle(color: redcolor),
                                ),
                              ),
                            ),
                            w(5),
                            Text(formatTime()),
                          ],
                        )
                      ],
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  String formatTime() {
    int minutes = counter ~/ 60;
    int seconds = counter % 60;
    String formattedTime =
        '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
    return formattedTime;
  }
}
