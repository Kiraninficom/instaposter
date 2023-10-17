// ignore_for_file: prefer_interpolation_to_compose_strings

import 'dart:convert';

import 'package:click/pages/otpverify_dialog.dart';
import 'package:http/http.dart' as http;
import 'package:click/utils/constants.dart';
import 'package:click/utils/navigation.dart';
import 'package:click/utils/styles.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:sms_autofill/sms_autofill.dart';
import '../helpers/layout.dart';
import '../widgets/button.dart';
import '../widgets/textfield.dart';
import 'changepassword.dart';

class OTP extends StatefulWidget {
  final String number;

  const OTP({
    Key? key,
    required this.number,
  }) : super(key: key);

  @override
  State<OTP> createState() => _OTPState();
}

class _OTPState extends State<OTP> {
  TextEditingController phone = TextEditingController();
  late Image image;

  @override
  void initState() {
    phone.text = widget.number;
    super.initState();
    image = Image.asset("assets/forgot.png");
    SmsAutoFill().getAppSignature.then((signature) {
      setState(() {
        appSignature = signature;
      });
    });
  }

  @override
  void didChangeDependencies() {
    precacheImage(image.image, context);
    super.didChangeDependencies();
  }

  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
            colors: [appBarColor, primaryColor],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
          )),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ListView(
              children: [
                h(10),
                Form(
                  key: formkey,
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: InkWell(
                          onTap: () {
                            backscreen(context);
                          },
                          child: CircleAvatar(
                            backgroundColor: whitecolor,
                            child: Icon(
                              Icons.arrow_back,
                              color: blackcolor,
                            ),
                          ),
                        ),
                      ),
                      Image.asset("assets/forgot.png"),
                      Text(
                        'Enter your mobile number\nWe will send you OTP to verify',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: whitecolor,
                            fontSize:
                                18), //(height: 1.5, color: AppColors.white),
                      ),
                      h(20),
                      CustomTextField(
                        validate: (value) {
                          if (value.isEmpty) {
                            return "Please enter mobile number";
                          }
                          if (value.length != 10) {
                            return "Enter Correct number";
                          }
                        },
                        keyboardType: TextInputType.number,
                        maxlength: 10,
                        errorcolor: whitecolor,
                        fillColor: whitecolor,
                        controller: phone,
                        hinttext: 'Mobile No.',
                        prefixIcon: const Icon(Icons.person_outline),
                      ),
                      h(20),
                      progress == true
                          ? Center(
                              child: CircularProgressIndicator(),
                            )
                          : Center(
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width * .6,
                                child: MaterialButton(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: Text(
                                      'Send OTP',
                                      style: TextStyle(
                                          color: whitecolor, fontSize: 20),
                                    ),
                                  ),
                                  color: primaryColor,
                                  onPressed: () async {
                                    if (formkey.currentState!.validate()) {
                                      forgotpassword();
                                    }
                                    // toScreen(context, const LandingPage());
                                  },
                                ),
                              ),
                            ),

                      // TextFormField(
                      //   enabled: true,
                      //   style: style(16),
                      //   //(color: AppColors.white),
                      //   cursorColor: Colors.white,
                      //   controller: phone,
                      //   keyboardType: TextInputType.number,
                      //   textAlignVertical: TextAlignVertical.center,
                      //   onChanged: (st) {
                      //     if (st.length == 10) {
                      //       FocusScope.of(context).requestFocus(FocusNode());
                      //     }
                      //   },
                      //   decoration: InputDecoration(
                      //     counterStyle: style(16),
                      //     //(color: AppColors.white),
                      //     enabledBorder: UnderlineInputBorder(
                      //       borderSide: BorderSide(color: AppColors.blue),
                      //     ),
                      //     focusedBorder: UnderlineInputBorder(
                      //       borderSide: BorderSide(color: AppColors.blue),
                      //     ),
                      //     focusColor: AppColors.blue,
                      //     prefixIcon: Row(
                      //       mainAxisSize: MainAxisSize.min,
                      //       children: [
                      //         const Icon(Icons.call_outlined),
                      //         Text(
                      //           '+91',
                      //           style: style(16),
                      //         ),
                      //       ],
                      //     ),
                      //   ),
                      // ),

                      // const SizedBox(
                      //   height: 20,
                      // ),
                      // Text(
                      //   'Verify OTP to Continue.',
                      //   style: style(20), //(color: AppColors.white),
                      // )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  var appSignature;

  bool progress = false;
  var id;
  Future forgotpassword() async {
    //print(true);
    var message;
    try {
      setState(() {
        progress = true;
      });
      http.Response response = await http.post(
          Uri.parse("${baseurl}fogotPasswordSendOtp"),
          body: {'mobileno': phone.text, 'signature': appSignature});
      //print(response.body);
      var mapresponse = json.decode(response.body);

      //print(mapresponse);
      message = "${mapresponse['response']['response_message']}";
      var data = mapresponse['data']['user_id'];
      //print(data);
      if (data.isNotEmpty) {
        setState(() {
          id = mapresponse['data']['user_id'];
          progress = false;
        });
        showDialog(
          context: context,
          builder: (context) {
            return Otpdialog(
              mobilenumber: phone.text,
              forgot: true,
              userid: mapresponse['data']['user_id'],
            );
          },
        );
      } else {
        setState(() {
          progress = false;
        });
      }
      Fluttertoast.showToast(
          msg: '${mapresponse['response']['response_message']}');
    } catch (e) {
      //print(e.toString());
      Fluttertoast.showToast(msg: "$message");
      setState(() {
        progress = false;
      });
    }
  }
}
