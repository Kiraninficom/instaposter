// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:click/pages/getapi.dart';
import 'package:click/utils/constants.dart';
import 'package:click/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserAccount extends StatefulWidget {
  const UserAccount({Key? key}) : super(key: key);

  @override
  State<UserAccount> createState() => _UserAccountState();
}

class _UserAccountState extends State<UserAccount> {
  // var userdata;

  Future getdata() async {
    var user = await SentApi().getuserdata();
    setState(() {
      userdata = user;
    });
  }

  @override
  void initState() {
    super.initState();
    getdata();
  }

  @override
  Widget build(BuildContext context) {
    if (userdata == null) {
      return const Center(child: CircularProgressIndicator());
    }
    return Row(
      children: [
        CircleAvatar(
          radius: 30,
          backgroundImage:
              CachedNetworkImageProvider("$weburl/${userdata["profile_img"]}"),
        ),
        w(10),
        Expanded(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                maxLines: 10,
                text: TextSpan(
                  children: [
                    const TextSpan(
                      text: 'Hello,  ',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                      ),
                    ),
                    TextSpan(
                      text: '${userdata["name"]}',
                      style: TextStyle(
                        color: primaryColor,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
              h(5),
              Text(
                '${userdata["mobileno"]}',
                style: const TextStyle(
                  fontSize: 16,
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
