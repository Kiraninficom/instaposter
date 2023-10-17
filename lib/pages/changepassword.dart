// ignore_for_file: must_be_immutable, prefer_typing_uninitialized_variables

import 'dart:convert';

import 'package:click/helpers/layout.dart';
import 'package:click/pages/login.dart';
import 'package:click/utils/constants.dart';
import 'package:click/utils/styles.dart';
import 'package:click/widgets/button.dart';
import 'package:click/widgets/textfield.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class ChangePassword extends StatefulWidget {
  var id;
  var otp;
  ChangePassword({super.key, this.id, this.otp});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  bool isPasswordShow = false;
  TextEditingController password = TextEditingController();
  TextEditingController cpassword = TextEditingController();

  late Image image;

  @override
  void initState() {
    super.initState();
    image = Image.asset(
      "assets/logo.jpg",
      height: 50,
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    precacheImage(image.image, context);
  }

  togglePassword() {
    setState(() {
      isPasswordShow = !isPasswordShow;
    });
  }

  @override
  Widget build(BuildContext context) {
    const double defaultPadding = 16.0;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
          colors: [appBarColor, primaryColor],
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
        )),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomTextField(
                fillColor: whitecolor,
                controller: password,
                labelText: 'Password',
                prefixIcon: const Icon(Icons.password_outlined),
                obscureText: isPasswordShow,
                suffixIcon: IconButton(
                  icon: Icon(isPasswordShow
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined),
                  onPressed: togglePassword,
                ),
              ),
              h(10),
              CustomTextField(
                fillColor: whitecolor,
                controller: cpassword,
                labelText: 'Confirm Password',
                prefixIcon: const Icon(Icons.password_outlined),
                obscureText: isPasswordShow,
                suffixIcon: IconButton(
                  icon: Icon(isPasswordShow
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined),
                  onPressed: togglePassword,
                ),
              ),
              h(10),
              Container(
                width: MediaQuery.of(context).size.width * .5,
                child: MaterialButton(
                  color: appBarColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  onPressed: () async {
                    if (password.text.isNotEmpty &&
                        cpassword.text.isNotEmpty &&
                        password.text == cpassword.text) {
                      var message;
                      try {
                        http.Response response = await http.post(
                            Uri.parse("${baseurl}forget_password"),
                            body: {
                              "user_id": widget.id,
                              "newpassword": password.text,
                            });
                        //print(response.body);
                        var mapresponse = json.decode(response.body);
                        message =
                            '${mapresponse['response']['response_message']}';

                        Fluttertoast.showToast(msg: "$message");
                        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                          builder: (context) {
                            return Login();
                          },
                        ), (route) => false);
                      } catch (e) {
                        Fluttertoast.showToast(msg: "$message");
                      }
                    } else {
                      Fluttertoast.showToast(msg: "Password not match!");
                    }
                  },
                  child: Text(
                    "Submit",
                    style: TextStyle(color: whitecolor, fontSize: 20),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
