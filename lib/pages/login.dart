// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:click/helpers/layout.dart';
import 'package:click/pages/authcredential.dart';
import 'package:click/pages/landing_page.dart';
import 'package:click/pages/otp.dart';
import 'package:click/pages/otpverify_dialog.dart';
import 'package:click/pages/register.dart';
import 'package:click/subscription_page.dart';
import 'package:click/utils/constants.dart';
import 'package:click/utils/navigation.dart';
import 'package:click/utils/styles.dart';
import 'package:click/widgets/button.dart';
import 'package:click/widgets/confirmation.dart';
import 'package:click/widgets/social_login.dart';
import 'package:click/widgets/textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController mobilenumber = TextEditingController();
  final TextEditingController password = TextEditingController();
  bool hidePassword = true;
  late Image logo;
  bool progress = false;

  togglePassword() {
    setState(() {
      hidePassword = !hidePassword;
    });
  }

  @override
  void initState() {
    super.initState();
    logo = Image.asset("assets/instapost.png");
  }

  @override
  void didChangeDependencies() {
    precacheImage(logo.image, context);
    super.didChangeDependencies();
  }

  void login(String mobilenumber, password) async {
    var message;
    try {
      setState(() {
        progress = true;
      });
      http.Response response = await http.post(
        Uri.parse(loginapi),
        headers: {
          'token': '8338d6ff4f0878b222f312494c1621a9',
        },
        body: {
          'mobileno': mobilenumber,
          'password': "$password",
          'country_code': '91'
        },
      );
      //print(response.body);
      var mapresponse = json.decode(response.body);
      message = "${mapresponse['response']['response_message']}";
      var token1 = mapresponse['data']['token'];
      Fluttertoast.showToast(
          msg: '${mapresponse['response']['response_message']}');
      //print(mapresponse);
      if (mapresponse['data']['status'] == false) {
        var userid = mapresponse['data']['user_id'];
        setState(() {
          progress = false;
        });
        durationdialog(
          message,
          true,
          false,
        ).then((value) {
          showDialog(
            context: context,
            builder: (context) {
              return Otpdialog(
                userid: userid,
                mobilenumber: mobilenumber,
              );
            },
          );
        });
      } else {
        Authcredential().storeToken(token1);
        //print(mapresponse);
        setState(() {
          token = token1;
          progress = false;
        });
        durationdialog(
          message,
          true,
          false,
        ).then((value) {
          toScreen(context, LandingPage(value: 0));
        });
      }
    } catch (e) {
      if (kDebugMode) {
        //print(e.toString());
      }
      durationdialog(message, false, true);
      Fluttertoast.showToast(msg: message);
      setState(() {
        progress = false;
      });
    }
  }

  durationdialog(var message, bool sucess, bool failur) {
    return showDialog(
        context: context,
        builder: (context) {
          Future.delayed(Duration(seconds: 4), () {
            backscreen(context);
          });
          return ConfirmationDialog(
            title: message,
            sucess: sucess,
            failure: failur,
          );
        });
  }

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

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
          child: Center(
            child: SingleChildScrollView(
              child: Form(
                key: _formkey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: SizedBox(
                        height: MediaQuery.of(context).size.width * .6,
                        child: Image.asset("assets/instapost.png"),
                      ),
                    ),
                    h(10),
                    Text(
                      'Welcome To InstaPoster',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: whitecolor,
                        fontSize: AppLayout.getHeight(23),
                      ),
                    ),
                    h(10),
                    CustomTextField(
                      maxlength: 10,
                      validate: (value) {
                        if (value.isEmpty) {
                          return "Please enter mobile number";
                        }
                        if (value.length != 10) {
                          return "Please enter correct mobile number";
                        }
                      },
                      keyboardType: TextInputType.number,
                      controller: mobilenumber,
                      fillColor: whitecolor,
                      errorcolor: whitecolor,
                      hinttext: 'Mobile No.',
                      prefixIcon: const Icon(Icons.person_outline),
                    ),

                    CustomTextField(
                      validate: (value) {
                        if (value.isEmpty) {
                          return "Please enter password";
                        }
                      },
                      controller: password,
                      hinttext: 'Password',
                      prefixIcon: const Icon(Icons.password_outlined),
                      obscureText: hidePassword,
                      fillColor: whitecolor,
                      errorcolor: whitecolor,
                      suffixIcon: IconButton(
                        icon: Icon(hidePassword
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined),
                        onPressed: togglePassword,
                      ),
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: InkWell(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 15.0),
                          child: Text(
                            'Forgot Password?',
                            style: TextStyle(color: whitecolor),
                          ),
                        ),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      OTP(number: mobilenumber.text)));
                        },
                      ),
                    ),
                    h(10),
                    progress == true
                        ? const Center(child: CircularProgressIndicator())
                        : SizedBox(
                            width: MediaQuery.of(context).size.width * .7,
                            child: MaterialButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              child: Padding(
                                padding: const EdgeInsets.all(8),
                                child: Text(
                                  'Login',
                                  style: TextStyle(
                                      color: whitecolor, fontSize: 20),
                                ),
                              ),
                              color: primaryColor,
                              onPressed: () {
                                if (_formkey.currentState!.validate()) {
                                  login(mobilenumber.text, password.text);
                                }
                                // toScreen(context, const LandingPage());
                              },
                            ),
                          ),
                    h(10),
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(left: 20.0),
                            child: Divider(
                              thickness: 1.5,
                              color: whitecolor,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 10, right: 10),
                          child: Text('Don\'t Have an Account?',
                              style: TextStyle(color: whitecolor)),
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(right: 20.0),
                            child: Divider(
                              thickness: 1.5,
                              color: whitecolor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    h(10),
                    // SocialLoginButton(
                    //   onPressed: () async {
                    //     try {
                    //       final GoogleSignIn googleSignIn = GoogleSignIn(
                    //         scopes: ['email'],
                    //       );
                    //       final GoogleSignInAccount? googleUser =
                    //           await googleSignIn.signIn();

                    //       final FirebaseAuth auth = FirebaseAuth.instance;

                    //       final GoogleSignInAuthentication googleAuth =
                    //           await googleUser!.authentication;

                    //       final AuthCredential credential =
                    //           GoogleAuthProvider.credential(
                    //         accessToken: googleAuth.accessToken,
                    //         idToken: googleAuth.idToken,
                    //       );
                    //       UserCredential userCredential =
                    //           await auth.signInWithCredential(credential);
                    //       if (kDebugMode) {
                    //         //print(userCredential);
                    //       }
                    //       // Authcredential().storeToken(userCredential.user!.uid);
                    //       // toScreen(context, LandingPage());
                    //       if (userCredential.additionalUserInfo!.isNewUser) {
                    //         http.Response response = await http.post(
                    //             Uri.parse("$weburl/api/api/user_social_signup"),
                    //             body: {
                    //               "email": "${userCredential.user!.email}",
                    //               "country_code": "91",
                    //               'mobileno':
                    //                   "${userCredential.user!.phoneNumber}",
                    //               "password": "not required"
                    //             });
                    //         var result = jsonDecode(response.body);
                    //         if (kDebugMode) {
                    //           //print(result);
                    //         }
                    //         if (response.statusCode == 200) {
                    //           // Authcredential().storeUserdata(result['data']);
                    //           Authcredential()
                    //               .storeToken(result['data']['token']);
                    //           toScreen(context, LandingPage(value: 0));
                    //           // showDialog(
                    //           //   context: context,
                    //           //   builder: (context) {
                    //           //     return Subscriptionpage(
                    //           //       frompage: null,
                    //           //     );
                    //           //   },
                    //           // );
                    //         }
                    //       } else if (!userCredential
                    //           .additionalUserInfo!.isNewUser) {
                    //         if (kDebugMode) {
                    //           //print(userCredential.user!.email);
                    //         }
                    //         if (kDebugMode) {
                    //           //print(userCredential.user!.phoneNumber);
                    //         }
                    //         http.Response response = await http.post(
                    //             Uri.parse("$weburl/api/api/user_social_signin"),
                    //             body: {
                    //               "otp": "1234",
                    //               'mobileno':
                    //                   "${userCredential.user!.phoneNumber}",
                    //               "email": userCredential.user!.email
                    //                   .toString()
                    //                   .trim(),
                    //               "country_code": "91",
                    //               "password": "not required"
                    //             });
                    //         var result = jsonDecode(response.body);
                    //         if (kDebugMode) {
                    //           //print(result);
                    //         }
                    //         if (response.statusCode == 200) {
                    //           // authController
                    //           //     .storeUserdata(result['data']["user_details"]);
                    //           Authcredential().storeToken(
                    //               result['data']["user_details"]['token']);
                    //           toScreen(context, LandingPage(value: 0));
                    //           // showDialog(
                    //           //   context: context,
                    //           //   builder: (context) {
                    //           //     return Subscriptionpage(
                    //           //       frompage: null,
                    //           //     );
                    //           //   },
                    //           // );
                    //         }
                    //       } else {
                    //         ScaffoldMessenger.of(context).showSnackBar(
                    //             const SnackBar(content: Text("Login failed")));
                    //       }
                    //     } catch (e) {
                    //       if (kDebugMode) {
                    //         //print(e);
                    //       }
                    //     }
                    //   },
                    //   child: const Icon(
                    //     FontAwesomeIcons.googlePlus,
                    //     color: Colors.redAccent,
                    //     size: 35,
                    //   ),
                    // ),
                    // h(40),
                    // const Text('Don\'t Have an Account?'),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * .7,
                      child: MaterialButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Text(
                            'Register',
                            style: TextStyle(color: whitecolor, fontSize: 20),
                          ),
                        ),
                        color: Colors.red,
                        onPressed: () {
                          toScreen(context, const Registerpage());
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
