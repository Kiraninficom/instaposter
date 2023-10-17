// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:convert';

import 'package:click/helpers/layout.dart';
import 'package:click/pages/authcredential.dart';
import 'package:click/pages/otpverify_dialog.dart';
import 'package:click/utils/constants.dart';
import 'package:click/utils/navigation.dart';
import 'package:click/utils/styles.dart';
import 'package:click/widgets/button.dart';
import 'package:click/widgets/textfield.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:sms_autofill/sms_autofill.dart';

class Registerpage extends StatefulWidget {
  const Registerpage({Key? key}) : super(key: key);

  @override
  State<Registerpage> createState() => _RegisterpageState();
}

class _RegisterpageState extends State<Registerpage> {
  var obsecure = true;
  var confirmobsecure = true;
  final TextEditingController mobilenumber = TextEditingController();
  final TextEditingController otp = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController confirmpassword = TextEditingController();
  final TextEditingController name = TextEditingController();
  final TextEditingController sharecode = TextEditingController();
  var id;

  bool progress = false;
  bool editmode = true;
  bool? referaleditmode;
  var appSignature;

  Future registeruser() async {
    //print(true);
    var message;
    try {
      setState(() {
        progress = true;
      });
      var apiurl = register;
      Map mapdata = {
        'name': name.text,
        'email': email.text,
        'mobileno': mobilenumber.text,
        'password': confirmpassword.text,
        'country_code': '91',
        'share_code': sharecode.text,
        'signature': appSignature
      };
      http.Response response =
          await http.post(Uri.parse(apiurl), body: mapdata);
      //print(response.body);
      var mapresponse = json.decode(response.body);

      //print(mapresponse);
      message = "${mapresponse['response']['response_message']}";
      var data = mapresponse['data'];
      //print(data);
      if (data.isNotEmpty) {
        setState(() {
          id = mapresponse['data'];
          progress = false;
          editmode = false;
        });
        showDialog(
          context: context,
          builder: (context) {
            return Otpdialog(
              mobilenumber: mobilenumber.text,
              userid: mapresponse['data'],
            );
          },
        );
      } else {
        setState(() {
          progress = false;
          editmode = true;
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

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    getrefferalvalue();
    SmsAutoFill().getAppSignature.then((signature) {
      setState(() {
        appSignature = signature;
      });
    });
  }

  getrefferalvalue() async {
    var referalvalue = await Authcredential().getfromlocal("Referal");
    if (referalvalue != "null") {
      setState(() {
        sharecode.text = referalvalue;
        referaleditmode = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        elevation: 2,
        backgroundColor: primaryColor,
        title: Text(
          "Register Now",
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
          colors: [appBarColor, primaryColor],
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
        )),
        child: ListView(
          children: [
            Form(
              key: _formkey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  h(30),
                  CustomTextField(
                    errorcolor: whitecolor,
                    fillColor: whitecolor,
                    validate: (value) {
                      if (value.length != 10) {
                        return "please enter correct mobile number";
                      }
                    },
                    keyboardType: TextInputType.number,
                    maxlength: 10,
                    enabled: editmode,
                    controller: mobilenumber,
                    hinttext: 'Mobile No.',
                    prefixIcon: const Icon(Icons.phone),
                  ),

                  CustomTextField(
                    errorcolor: whitecolor,
                    fillColor: whitecolor,
                    validate: (value) {
                      if (value.isEmpty) {
                        return "please enter your name";
                      }
                      final RegExp nameRegExp = RegExp('[0-9.,]');
                      if (nameRegExp.hasMatch(value)) {
                        return "Please enter correctname";
                      }
                    },
                    enabled: editmode,
                    keyboardType: TextInputType.name,
                    controller: name,
                    hinttext: 'Your name',
                    prefixIcon: const Icon(Icons.person_outline),
                  ),
                  h(6),
                  CustomTextField(
                    errorcolor: whitecolor,
                    fillColor: whitecolor,
                    enabled: editmode,
                    validate: (value) {
                      if (value.isEmpty) {
                        return "Please Enter Your Email";
                      }
                      String pattern =
                          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                      RegExp regex = RegExp(pattern);
                      if (!regex.hasMatch(value!)) {
                        return 'Enter Valid Email';
                      } else {
                        return null;
                      }
                    },
                    keyboardType: TextInputType.emailAddress,
                    controller: email,
                    hinttext: 'E-mail',
                    prefixIcon: const Icon(Icons.email),
                  ),

                  CustomTextField(
                    errorcolor: whitecolor,
                    fillColor: whitecolor,
                    enabled: referaleditmode ?? editmode,
                    controller: sharecode,
                    hinttext: 'Referal code (Optional)',
                    prefixIcon: const Icon(Icons.money),
                  ),

                  CustomTextField(
                    errorcolor: whitecolor,
                    fillColor: whitecolor,
                    enabled: editmode,
                    keyboardType: TextInputType.visiblePassword,
                    suffixIcon: InkWell(
                      onTap: () {
                        setState(() {
                          obsecure = !obsecure;
                        });
                      },
                      child: Icon(obsecure
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined),
                    ),
                    obscureText: obsecure,
                    controller: password,
                    hinttext: 'Password',
                    prefixIcon: const Icon(Icons.lock),
                  ),

                  CustomTextField(
                    errorcolor: whitecolor,
                    fillColor: whitecolor,
                    enabled: editmode,
                    keyboardType: TextInputType.visiblePassword,
                    suffixIcon: InkWell(
                      onTap: () {
                        setState(() {
                          confirmobsecure = !confirmobsecure;
                        });
                      },
                      child: Icon(confirmobsecure
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined),
                    ),
                    obscureText: confirmobsecure,
                    controller: confirmpassword,
                    hinttext: 'Confirm Password',
                    prefixIcon: const Icon(Icons.lock),
                  ),

                  progress == true
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : SizedBox(
                          width: MediaQuery.of(context).size.width * .9,
                          child: MaterialButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Verify Mobile Number',
                                style:
                                    TextStyle(color: whitecolor, fontSize: 20),
                              ),
                            ),
                            color: primaryColor,
                            onPressed: () {
                              if (_formkey.currentState!.validate()) {
                                if (password.text == confirmpassword.text) {
                                  if (mobilenumber.text.isNotEmpty &&
                                      name.text.isNotEmpty &&
                                      email.text.isNotEmpty &&
                                      password.text.isNotEmpty &&
                                      confirmpassword.text.isNotEmpty) {
                                    if (editmode == true) {
                                      registeruser();
                                    }
                                  }
                                } else {
                                  Fluttertoast.showToast(
                                      msg: 'Password not match');
                                }
                              } else {
                                Fluttertoast.showToast(
                                    msg: "Please check Entered Details");
                              }
                            },
                          ),
                        ),

                  // if (_formkey.currentState!.validate()) {
                  //   sendcode(mobilenumber.text);
                  // }

                  //
                  // Align(
                  //     alignment: Alignment.centerRight,
                  //     child: Padding(
                  //       padding: const EdgeInsets.all(8.0),
                  //       child: InkWell(
                  //           onTap: () {
                  //             backscreen(context);
                  //           },
                  //           child: const Text('Have an Account?')),
                  //     )),
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
