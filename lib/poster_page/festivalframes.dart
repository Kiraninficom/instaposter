import 'package:cached_network_image/cached_network_image.dart';
import 'package:click/poster_page/poster_page.dart';
import 'package:click/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../utils/constants.dart';

getfestivalframe(
  BuildContext context, {
  var profilevalue,
  var frameno,
  var profileenable,
  var profileuploadedimage,
  var profilesize,
  var logoenable,
  var logosize,
  var nameenable,
  var namesize,
  var namefont,
  var namecolor,
  var designationenable,
  var designationsize,
  var designationfont,
  var designationcolor,
  var instagramenable,
  var instagramsize,
  var instagramfont,
  var instagramcolor,
  var facebookenable,
  var facebooksize,
  var facebookfont,
  var facebookcolor,
  var whatsappnumberenable,
  var whatsappnumbersize,
  var whatsappnumberfont,
  var whatsappnumbercolor,
  var weblinkenable,
  var weblinksize,
  var weblinkfont,
  var weblinkcolor,
  var emailenable,
  var emailsize,
  var emailfont,
  var emailcolor,
  var numberenable,
  var numbersize,
  var numberfont,
  var numbercolor,
  var addressenable,
  var addresssize,
  var addressfont,
  var addresscolor,
}) {
  var height = MediaQuery.of(context).size.width / 3.8;
  var width = MediaQuery.of(context).size.width;
  if (frameno == 1) {
    //print(namesize);
    //print(instagramsize);
    return Column(
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                profileenable == false
                    ? SizedBox.shrink()
                    : Container(
                        width: profilesize,
                        child: Text(""),
                      ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15, top: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        profilevalue["name"] == null || nameenable == false
                            ? SizedBox.shrink()
                            : Text(
                                profilevalue == null
                                    ? 'शुभेच्छुक: शुभम खत्री'
                                    : "${profilevalue['name']}",
                                softWrap: true,
                                style: TextStyle(
                                  color: namecolor ?? redcolor,
                                  fontSize: namesize.toDouble() + 5,
                                  fontFamily: namefont != null
                                      ? namefont['font']
                                      : "balbharati",
                                ),
                              ),
                        addressenable == false ||
                                profilevalue['address'] == null
                            ? SizedBox.shrink()
                            : RichText(
                                text: TextSpan(children: [
                                WidgetSpan(
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: blackcolor,
                                        borderRadius: BorderRadius.circular(3)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(2.0),
                                      child: Icon(
                                        Icons.location_on,
                                        size: addresssize - 1,
                                        color: whitecolor,
                                      ),
                                    ),
                                  ),
                                ),
                                WidgetSpan(child: w(5)),
                                TextSpan(
                                  text: profilevalue['address'],
                                  style: TextStyle(
                                    color: addresscolor ?? blackcolor,
                                    fontSize: addresssize.toDouble(),
                                    fontFamily: addressfont != null
                                        ? addressfont['font']
                                        : 'Mukta-Semibold',
                                  ),
                                )
                              ])),
                        numberenable == false &&
                                    whatsappnumberenable == false ||
                                addressenable == false
                            ? SizedBox.shrink()
                            : Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: Divider(
                                  height: 8,
                                  thickness: 1,
                                  color: blackcolor,
                                ),
                              ),
                        numberenable == false && whatsappnumberenable == false
                            ? SizedBox.shrink()
                            : Wrap(
                                children: [
                                  RichText(
                                      text: TextSpan(children: [
                                    profilevalue['mobileno'] == null ||
                                            numberenable == false
                                        ? WidgetSpan(child: SizedBox.shrink())
                                        : TextSpan(children: [
                                            WidgetSpan(
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    color: blackcolor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            3)),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(2.0),
                                                  child: Icon(
                                                    Icons.call,
                                                    size: numbersize - 1,
                                                    color: whitecolor,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            WidgetSpan(child: w(5)),
                                            TextSpan(
                                              text: profilevalue['mobileno'],
                                              style: TextStyle(
                                                color:
                                                    numbercolor ?? blackcolor,
                                                fontSize: numbersize,
                                                fontFamily: numberfont != null
                                                    ? numberfont['font']
                                                    : 'Mukta-Semibold',
                                              ),
                                            ),
                                          ]),
                                  ])),
                                  numberenable == false ||
                                          whatsappnumberenable == false
                                      ? SizedBox.shrink()
                                      : w(10),
                                  profilevalue['whatsapp_num'] == null ||
                                          whatsappnumberenable == false
                                      ? SizedBox.shrink()
                                      : RichText(
                                          text: TextSpan(children: [
                                            WidgetSpan(
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    color: Color(0xFF2CAD30),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            3)),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(2.0),
                                                  child: FaIcon(
                                                    FontAwesomeIcons.whatsapp,
                                                    size:
                                                        whatsappnumbersize - 1,
                                                    color: whitecolor,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            WidgetSpan(child: w(5)),
                                            TextSpan(
                                              text:
                                                  profilevalue['whatsapp_num'],
                                              style: TextStyle(
                                                color: whatsappnumbercolor ??
                                                    blackcolor,
                                                fontSize: whatsappnumbersize,
                                                fontFamily:
                                                    whatsappnumberfont != null
                                                        ? whatsappnumberfont[
                                                            'font']
                                                        : 'Mukta-Semibold',
                                              ),
                                            ),
                                          ]),
                                        )
                                ],
                              ),
                        h(5),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            (profilevalue["profile_img"] == null || profileenable == false) &&
                    (profileuploadedimage == null || profileenable == false)
                ? profileenable == false
                    ? SizedBox.shrink()
                    : Positioned(
                        left: 5,
                        bottom: 15,
                        child: CircleAvatar(
                          radius: profilesize / 2,
                          backgroundColor: whitecolor,
                          backgroundImage: Image.asset(
                            "assets/dfp.png",
                            width: profilesize,
                            height: profilesize,
                          ).image,
                        ))
                : Positioned(
                    left: 5,
                    bottom: 15,
                    child: CircleAvatar(
                      radius: profilesize / 2,
                      backgroundColor: whitecolor,
                      backgroundImage: profileuploadedimage != null
                          ? Image.file(profileuploadedimage).image
                          : CachedNetworkImageProvider(
                              "$weburl/${profilevalue["profile_img"]}",
                            ),
                    )),
          ],
        ),
      ],
    );
  }
  if (frameno == 2) {
    //print(namesize);
    //print(instagramsize);
    return Column(
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                profileenable == false
                    ? SizedBox.shrink()
                    : Container(
                        width: profilesize,
                        child: Text(""),
                      ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15, top: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        profilevalue["name"] == null || nameenable == false
                            ? SizedBox.shrink()
                            : Text(
                                profilevalue == null
                                    ? 'शुभेच्छुक: शुभम खत्री'
                                    : "${profilevalue['name']}",
                                softWrap: true,
                                style: TextStyle(
                                  color: namecolor ?? redcolor,
                                  fontSize: namesize.toDouble() + 5,
                                  fontFamily: namefont != null
                                      ? namefont['font']
                                      : "balbharati",
                                ),
                              ),
                        addressenable == false ||
                                profilevalue['address'] == null
                            ? SizedBox.shrink()
                            : RichText(
                                text: TextSpan(children: [
                                WidgetSpan(
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: blackcolor,
                                        borderRadius: BorderRadius.circular(3)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(2.0),
                                      child: Icon(
                                        Icons.location_on,
                                        size: addresssize - 1,
                                        color: whitecolor,
                                      ),
                                    ),
                                  ),
                                ),
                                WidgetSpan(child: w(5)),
                                TextSpan(
                                  text: profilevalue['address'],
                                  style: TextStyle(
                                    color: addresscolor ?? blackcolor,
                                    fontSize: addresssize.toDouble(),
                                    fontFamily: addressfont != null
                                        ? addressfont['font']
                                        : 'Mukta-Semibold',
                                  ),
                                )
                              ])),
                        numberenable == false &&
                                    whatsappnumberenable == false ||
                                addressenable == false
                            ? SizedBox.shrink()
                            : Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: Divider(
                                  height: 8,
                                  thickness: 1,
                                  color: blackcolor,
                                ),
                              ),
                        numberenable == false && whatsappnumberenable == false
                            ? SizedBox.shrink()
                            : Wrap(
                                children: [
                                  RichText(
                                      text: TextSpan(children: [
                                    profilevalue['mobileno'] == null ||
                                            numberenable == false
                                        ? WidgetSpan(child: SizedBox.shrink())
                                        : TextSpan(children: [
                                            WidgetSpan(
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    color: blackcolor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            3)),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(2.0),
                                                  child: Icon(
                                                    Icons.call,
                                                    size: numbersize - 1,
                                                    color: whitecolor,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            WidgetSpan(child: w(5)),
                                            TextSpan(
                                              text: profilevalue['mobileno'],
                                              style: TextStyle(
                                                color:
                                                    numbercolor ?? blackcolor,
                                                fontSize: numbersize,
                                                fontFamily: numberfont != null
                                                    ? numberfont['font']
                                                    : 'Mukta-Semibold',
                                              ),
                                            ),
                                          ]),
                                  ])),
                                  numberenable == false ||
                                          whatsappnumberenable == false
                                      ? SizedBox.shrink()
                                      : w(10),
                                  profilevalue['whatsapp_num'] == null ||
                                          whatsappnumberenable == false
                                      ? SizedBox.shrink()
                                      : RichText(
                                          text: TextSpan(children: [
                                            WidgetSpan(
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    color: Color(0xFF2CAD30),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            3)),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(2.0),
                                                  child: FaIcon(
                                                    FontAwesomeIcons.whatsapp,
                                                    size:
                                                        whatsappnumbersize - 1,
                                                    color: whitecolor,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            WidgetSpan(child: w(5)),
                                            TextSpan(
                                              text:
                                                  profilevalue['whatsapp_num'],
                                              style: TextStyle(
                                                color: whatsappnumbercolor ??
                                                    blackcolor,
                                                fontSize: whatsappnumbersize,
                                                fontFamily:
                                                    whatsappnumberfont != null
                                                        ? whatsappnumberfont[
                                                            'font']
                                                        : 'Mukta-Semibold',
                                              ),
                                            ),
                                          ]),
                                        )
                                ],
                              ),
                        h(5),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            (profilevalue["profile_img"] == null || profileenable == false) &&
                    (profileuploadedimage == null || profileenable == false)
                ? profileenable == false
                    ? SizedBox.shrink()
                    : Positioned(
                        left: 5,
                        bottom: 0,
                        child: Image.asset(
                          "assets/dfp.png",
                          width: profilesize,
                          height: profilesize,
                        ))
                : Positioned(
                    left: 5,
                    bottom: 0,
                    child: Container(
                      width: profilesize,
                      height: profilesize,
                      child: profileuploadedimage != null
                          ? Image.file(profileuploadedimage)
                          : CachedNetworkImage(
                              imageUrl:
                                  "$weburl/${profilevalue["profile_img"]}",
                              fit: BoxFit.fitWidth),
                    ),
                  ),
          ],
        ),
      ],
    );
  }
  if (frameno == 3) {
    //print(namesize);
    //print(instagramsize);
    return Column(
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                profileenable == false
                    ? SizedBox.shrink()
                    : Container(
                        width: profilesize,
                        child: Text(""),
                      ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15, top: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        profilevalue["name"] == null || nameenable == false
                            ? SizedBox.shrink()
                            : Text(
                                profilevalue == null
                                    ? 'शुभेच्छुक: शुभम खत्री'
                                    : "${profilevalue['name']}",
                                softWrap: true,
                                style: TextStyle(
                                  color: namecolor ?? Color(0xffefd900),
                                  fontSize: namesize.toDouble() + 5,
                                  fontFamily: namefont != null
                                      ? namefont['font']
                                      : "balbharati",
                                ),
                              ),
                        addressenable == false ||
                                profilevalue['address'] == null
                            ? SizedBox.shrink()
                            : RichText(
                                text: TextSpan(children: [
                                WidgetSpan(
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: whitecolor,
                                        borderRadius: BorderRadius.circular(3)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(2.0),
                                      child: Icon(
                                        Icons.location_on,
                                        size: addresssize - 1,
                                        color: blackcolor,
                                      ),
                                    ),
                                  ),
                                ),
                                WidgetSpan(child: w(5)),
                                TextSpan(
                                  text: profilevalue['address'],
                                  style: TextStyle(
                                    color: addresscolor ?? whitecolor,
                                    fontSize: addresssize.toDouble(),
                                    fontFamily: addressfont != null
                                        ? addressfont['font']
                                        : 'Mukta-Semibold',
                                  ),
                                )
                              ])),
                        numberenable == false &&
                                    whatsappnumberenable == false ||
                                addressenable == false
                            ? SizedBox.shrink()
                            : Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: Divider(
                                  height: 8,
                                  thickness: 1,
                                  color: whitecolor,
                                ),
                              ),
                        numberenable == false && whatsappnumberenable == false
                            ? SizedBox.shrink()
                            : Wrap(
                                children: [
                                  RichText(
                                      text: TextSpan(children: [
                                    profilevalue['mobileno'] == null ||
                                            numberenable == false
                                        ? WidgetSpan(child: SizedBox.shrink())
                                        : TextSpan(children: [
                                            WidgetSpan(
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    color: whitecolor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            3)),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(2.0),
                                                  child: Icon(
                                                    Icons.call,
                                                    size: numbersize - 1,
                                                    color: blackcolor,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            WidgetSpan(child: w(5)),
                                            TextSpan(
                                              text: profilevalue['mobileno'],
                                              style: TextStyle(
                                                color:
                                                    numbercolor ?? whitecolor,
                                                fontSize: numbersize,
                                                fontFamily: numberfont != null
                                                    ? numberfont['font']
                                                    : 'Mukta-Semibold',
                                              ),
                                            ),
                                          ]),
                                  ])),
                                  numberenable == false ||
                                          whatsappnumberenable == false
                                      ? SizedBox.shrink()
                                      : w(10),
                                  profilevalue['whatsapp_num'] == null ||
                                          whatsappnumberenable == false
                                      ? SizedBox.shrink()
                                      : RichText(
                                          text: TextSpan(children: [
                                            WidgetSpan(
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    color: Color(0xFF2CAD30),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            3)),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(2.0),
                                                  child: FaIcon(
                                                    FontAwesomeIcons.whatsapp,
                                                    size:
                                                        whatsappnumbersize - 1,
                                                    color: whitecolor,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            WidgetSpan(child: w(5)),
                                            TextSpan(
                                              text:
                                                  profilevalue['whatsapp_num'],
                                              style: TextStyle(
                                                color: whatsappnumbercolor ??
                                                    whitecolor,
                                                fontSize: whatsappnumbersize,
                                                fontFamily:
                                                    whatsappnumberfont != null
                                                        ? whatsappnumberfont[
                                                            'font']
                                                        : 'Mukta-Semibold',
                                              ),
                                            ),
                                          ]),
                                        )
                                ],
                              ),
                        h(5),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            (profilevalue["profile_img"] == null || profileenable == false) &&
                    (profileuploadedimage == null || profileenable == false)
                ? profileenable == false
                    ? SizedBox.shrink()
                    : Positioned(
                        left: 5,
                        bottom: 0,
                        child: Image.asset(
                          "assets/dfp.png",
                          width: profilesize,
                          height: profilesize,
                        ))
                : Positioned(
                    left: 5,
                    bottom: 0,
                    child: Container(
                      width: profilesize,
                      height: profilesize,
                      child: profileuploadedimage != null
                          ? Image.file(profileuploadedimage)
                          : CachedNetworkImage(
                              imageUrl:
                                  "$weburl/${profilevalue["profile_img"]}",
                              fit: BoxFit.fitWidth),
                    ),
                  ),
          ],
        ),
      ],
    );
  }
  if (frameno == 4) {
    //print(namesize);
    //print(instagramsize);
    return Column(
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                profileenable == false
                    ? SizedBox.shrink()
                    : Container(
                        width: profilesize,
                        child: Text(""),
                      ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15, top: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        profilevalue["name"] == null || nameenable == false
                            ? SizedBox.shrink()
                            : Text(
                                profilevalue == null
                                    ? 'शुभेच्छुक: शुभम खत्री'
                                    : "${profilevalue['name']}",
                                softWrap: true,
                                style: TextStyle(
                                    color: namecolor ?? Color(0xffefd900),
                                    fontSize: namesize.toDouble() + 2,
                                    fontFamily: namefont != null
                                        ? namefont['font']
                                        : "Gotu-Regular",
                                    fontWeight: FontWeight.bold),
                              ),
                        addressenable == false ||
                                profilevalue['address'] == null
                            ? SizedBox.shrink()
                            : RichText(
                                text: TextSpan(children: [
                                WidgetSpan(
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: whitecolor,
                                        borderRadius: BorderRadius.circular(3)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(2.0),
                                      child: Icon(
                                        Icons.location_on,
                                        size: addresssize - 1,
                                        color: blackcolor,
                                      ),
                                    ),
                                  ),
                                ),
                                WidgetSpan(child: w(5)),
                                TextSpan(
                                  text: profilevalue['address'],
                                  style: TextStyle(
                                    color: addresscolor ?? whitecolor,
                                    fontSize: addresssize.toDouble(),
                                    fontFamily: addressfont != null
                                        ? addressfont['font']
                                        : 'Mukta-Semibold',
                                  ),
                                )
                              ])),
                        numberenable == false &&
                                    whatsappnumberenable == false ||
                                addressenable == false
                            ? SizedBox.shrink()
                            : Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: Divider(
                                  height: 8,
                                  thickness: 1,
                                  color: whitecolor,
                                ),
                              ),
                        numberenable == false && whatsappnumberenable == false
                            ? SizedBox.shrink()
                            : Wrap(
                                children: [
                                  RichText(
                                      text: TextSpan(children: [
                                    profilevalue['mobileno'] == null ||
                                            numberenable == false
                                        ? WidgetSpan(child: SizedBox.shrink())
                                        : TextSpan(children: [
                                            WidgetSpan(
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    color: whitecolor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            3)),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(2.0),
                                                  child: Icon(
                                                    Icons.call,
                                                    size: numbersize - 1,
                                                    color: blackcolor,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            WidgetSpan(child: w(5)),
                                            TextSpan(
                                              text: profilevalue['mobileno'],
                                              style: TextStyle(
                                                color:
                                                    numbercolor ?? whitecolor,
                                                fontSize: numbersize,
                                                fontFamily: numberfont != null
                                                    ? numberfont['font']
                                                    : 'Mukta-Semibold',
                                              ),
                                            ),
                                          ]),
                                  ])),
                                  numberenable == false ||
                                          whatsappnumberenable == false
                                      ? SizedBox.shrink()
                                      : w(20),
                                  profilevalue['whatsapp_num'] == null ||
                                          whatsappnumberenable == false
                                      ? SizedBox.shrink()
                                      : RichText(
                                          text: TextSpan(children: [
                                            WidgetSpan(
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    color: Color(0xFF2CAD30),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            3)),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(2.0),
                                                  child: FaIcon(
                                                    FontAwesomeIcons.whatsapp,
                                                    size:
                                                        whatsappnumbersize - 1,
                                                    color: whitecolor,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            WidgetSpan(child: w(5)),
                                            TextSpan(
                                              text:
                                                  profilevalue['whatsapp_num'],
                                              style: TextStyle(
                                                color: whatsappnumbercolor ??
                                                    whitecolor,
                                                fontSize: whatsappnumbersize,
                                                fontFamily:
                                                    whatsappnumberfont != null
                                                        ? whatsappnumberfont[
                                                            'font']
                                                        : 'Mukta-Semibold',
                                              ),
                                            ),
                                          ]),
                                        )
                                ],
                              ),
                        h(5),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            (profilevalue["profile_img"] == null || profileenable == false) &&
                    (profileuploadedimage == null || profileenable == false)
                ? profileenable == false
                    ? SizedBox.shrink()
                    : Positioned(
                        left: 5,
                        bottom: 15,
                        child: CircleAvatar(
                          radius: profilesize / 2,
                          backgroundColor: whitecolor,
                          backgroundImage: Image.asset(
                            "assets/dfp.png",
                            width: profilesize,
                            height: profilesize,
                          ).image,
                        ))
                : Positioned(
                    left: 5,
                    bottom: 15,
                    child: CircleAvatar(
                      radius: profilesize / 2,
                      backgroundColor: whitecolor,
                      backgroundImage: profileuploadedimage != null
                          ? Image.file(profileuploadedimage).image
                          : CachedNetworkImageProvider(
                              "$weburl/${profilevalue["profile_img"]}",
                            ),
                    )),
          ],
        ),
      ],
    );
  }
  if (frameno == 5) {
    print(logosize);
    //print(instagramsize);
    return Column(
      children: [
        Container(
          height: 3,
          color: Colors.orange,
        ),
        Container(
          height: 3,
          color: Colors.white,
        ),
        Container(
          height: 3,
          color: Colors.green,
        ),
        Stack(
          clipBehavior: Clip.none,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                profileenable == false
                    ? SizedBox.shrink()
                    : Container(
                        width: profilesize - 10,
                        child: Text(""),
                      ),
                Expanded(
                    child: Padding(
                  padding: EdgeInsets.all(5),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      h(5),
                      profilevalue["name"] == null || nameenable == false
                          ? SizedBox.shrink()
                          : Text(
                              profilevalue == null
                                  ? 'शुभेच्छुक: शुभम खत्री'
                                  : "${profilevalue['name']}",
                              softWrap: true,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: namecolor ?? redcolor,
                                fontSize: namesize.toDouble() + 2,
                                fontFamily: namefont != null
                                    ? namefont['font']
                                    : "Poppins-Bold",
                              ),
                            ),
                      profilevalue["designation"] == null ||
                              designationenable == false
                          ? SizedBox.shrink()
                          : Text(
                              profilevalue == null
                                  ? 'शुभेच्छुक: शुभम खत्री'
                                  : "${profilevalue['designation']}",
                              textAlign: TextAlign.center,
                              softWrap: true,
                              style: TextStyle(
                                color: designationcolor ?? blackcolor,
                                fontSize: designationsize.toDouble() + 2,
                                fontFamily: designationfont != null
                                    ? designationfont['font']
                                    : "Poppins-SemiBold",
                              ),
                            ),
                    ],
                  ),
                )),
                logoenable == false
                    ? SizedBox.shrink()
                    : Container(
                        width: logosize - 5,
                        child: Text(""),
                      ),
              ],
            ),
            (profilevalue["festival_logo"] == null || logoenable == false)
                ? logoenable == false
                    ? SizedBox.shrink()
                    : Positioned(
                        right: 5,
                        bottom: 10,
                        child: CircleAvatar(
                          radius: (logosize - 5) / 2,
                          backgroundColor: whitecolor,
                          backgroundImage: Image.asset(
                            "assets/3D-Logo.png",
                            width: profilesize,
                            height: profilesize,
                          ).image,
                        ))
                : Positioned(
                    right: 5,
                    bottom: 10,
                    child: CircleAvatar(
                      radius: (logosize - 5) / 2,
                      backgroundColor: whitecolor,
                      backgroundImage: CachedNetworkImageProvider(
                        "$weburl/${profilevalue["festival_logo"]}",
                      ),
                    )),
            (profilevalue["profile_img"] == null || profileenable == false) &&
                    (profileuploadedimage == null || profileenable == false)
                ? profileenable == false
                    ? SizedBox.shrink()
                    : Positioned(
                        left: 5,
                        bottom: 10,
                        child: CircleAvatar(
                          radius: (profilesize - 10) / 2,
                          backgroundColor: whitecolor,
                          backgroundImage: Image.asset(
                            "assets/dfp.png",
                            width: profilesize,
                            height: profilesize,
                          ).image,
                        ))
                : Positioned(
                    left: 5,
                    bottom: 10,
                    child: CircleAvatar(
                      radius: (profilesize - 10) / 2,
                      backgroundColor: whitecolor,
                      backgroundImage: profileuploadedimage != null
                          ? Image.file(profileuploadedimage).image
                          : CachedNetworkImageProvider(
                              "$weburl/${profilevalue["profile_img"]}"),
                    )),
          ],
        ),
      ],
    );
  }
  if (frameno == 6) {
    print(logosize);
    //print(instagramsize);
    return Column(
      children: [
        Container(
          height: 2,
          color: Colors.orange,
        ),
        Stack(
          clipBehavior: Clip.none,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                profileenable == false
                    ? SizedBox.shrink()
                    : Container(
                        width: profilesize,
                        child: Text(""),
                      ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        h(5),
                        profilevalue["name"] == null || nameenable == false
                            ? SizedBox.shrink()
                            : Text(
                                profilevalue == null
                                    ? 'शुभेच्छुक: शुभम खत्री'
                                    : "${profilevalue['name']}",
                                softWrap: true,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: namecolor ?? redcolor,
                                  fontSize: namesize.toDouble() + 2,
                                  fontFamily: namefont != null
                                      ? namefont['font']
                                      : "Poppins-SemiBold",
                                ),
                              ),
                        profilevalue["designation"] == null ||
                                designationenable == false
                            ? SizedBox.shrink()
                            : Text(
                                profilevalue == null
                                    ? 'शुभेच्छुक: शुभम खत्री'
                                    : "${profilevalue['designation']}",
                                softWrap: true,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: designationcolor ?? blackcolor,
                                  fontSize: designationsize.toDouble() + 2,
                                  fontFamily: designationfont != null
                                      ? designationfont['font']
                                      : "Poppins-SemiBold",
                                ),
                              ),
                      ],
                    ),
                  ),
                ),
                logoenable == false
                    ? SizedBox.shrink()
                    : Container(
                        width: logosize - 10,
                        child: Text(""),
                      ),
              ],
            ),
            (profilevalue["festival_logo"] == null || logoenable == false)
                ? logoenable == false
                    ? SizedBox.shrink()
                    : Positioned(
                        right: 5,
                        bottom: 10,
                        child: CircleAvatar(
                          radius: (logosize - 10) / 2,
                          backgroundColor: Colors.transparent,
                          backgroundImage: Image.asset(
                            "assets/3D-Logo.png",
                          ).image,
                        ))
                : Positioned(
                    right: 5,
                    bottom: 10,
                    child: CircleAvatar(
                      radius: (logosize - 10) / 2,
                      backgroundColor: Colors.transparent,
                      backgroundImage: CachedNetworkImageProvider(
                          "$weburl/${profilevalue["festival_logo"]}"),
                    )),
            (profilevalue["profile_img"] == null || profileenable == false) &&
                    (profileuploadedimage == null || profileenable == false)
                ? profileenable == false
                    ? SizedBox.shrink()
                    : Positioned(
                        left: 5,
                        bottom: 0,
                        child: Container(
                          width: profilesize,
                          height: profilesize,
                          child: Image.asset(
                            "assets/dfp.png",
                            width: profilesize,
                            height: profilesize,
                          ),
                        ),
                      )
                : Positioned(
                    left: 5,
                    bottom: 0,
                    child: Container(
                      width: profilesize,
                      height: profilesize,
                      child: profileuploadedimage != null
                          ? Image.file(profileuploadedimage)
                          : CachedNetworkImage(
                              imageUrl:
                                  "$weburl/${profilevalue["profile_img"]}",
                              fit: BoxFit.fitWidth),
                    ),
                  ),
          ],
        ),
        Container(
          height: 2,
          color: Colors.green,
        ),
      ],
    );
  }
  if (frameno == 7) {
    print(profilevalue['web_url']);
    return Padding(
      padding: EdgeInsets.only(left: 10.0, top: 5, bottom: 5, right: 10),
      child: Row(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                profilevalue['name'] == null || nameenable == false
                    ? SizedBox.shrink()
                    : RichText(
                        text: TextSpan(children: [
                        TextSpan(children: [
                          TextSpan(
                            text: profilevalue['name'],
                            style: TextStyle(
                              color: namecolor ?? blackcolor,
                              fontSize: namesize + 8,
                              fontFamily: namefont != null
                                  ? numberfont['font']
                                  : 'Mukta-Semibold',
                            ),
                          ),
                        ]),
                      ])),
                (profilevalue['name'] == null || nameenable == false) ||
                        (numberenable == false && whatsappnumberenable == false)
                    ? SizedBox.shrink()
                    : Divider(
                        thickness: .4,
                        height: 5,
                        color: blackcolor,
                      ),
                numberenable == false && whatsappnumberenable == false
                    ? SizedBox.shrink()
                    : Wrap(
                        children: [
                          profilevalue['mobileno'] == null ||
                                  numberenable == false
                              ? SizedBox.shrink()
                              : RichText(
                                  text: TextSpan(children: [
                                  TextSpan(children: [
                                    WidgetSpan(
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: blackcolor,
                                            borderRadius:
                                                BorderRadius.circular(3)),
                                        child: Padding(
                                          padding: const EdgeInsets.all(2.0),
                                          child: Icon(
                                            Icons.call,
                                            size: numbersize - 1,
                                            color: whitecolor,
                                          ),
                                        ),
                                      ),
                                    ),
                                    WidgetSpan(child: w(5)),
                                    TextSpan(
                                      text: profilevalue['mobileno'],
                                      style: TextStyle(
                                        color: numbercolor ?? blackcolor,
                                        fontSize: numbersize,
                                        fontFamily: numberfont != null
                                            ? numberfont['font']
                                            : 'Mukta-Semibold',
                                      ),
                                    ),
                                  ]),
                                ])),
                          w(20),
                          profilevalue['whatsapp_num'] == null ||
                                  whatsappnumberenable == false
                              ? SizedBox.shrink()
                              : RichText(
                                  text: TextSpan(children: [
                                    WidgetSpan(
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: Color(0xFF2CAD30),
                                            borderRadius:
                                                BorderRadius.circular(3)),
                                        child: Padding(
                                          padding: const EdgeInsets.all(2.0),
                                          child: FaIcon(
                                            FontAwesomeIcons.whatsapp,
                                            size: whatsappnumbersize - 1,
                                            color: whitecolor,
                                          ),
                                        ),
                                      ),
                                    ),
                                    WidgetSpan(child: w(5)),
                                    TextSpan(
                                      text: profilevalue['whatsapp_num'],
                                      style: TextStyle(
                                        color:
                                            whatsappnumbercolor ?? blackcolor,
                                        fontSize: whatsappnumbersize,
                                        fontFamily: whatsappnumberfont != null
                                            ? whatsappnumberfont['font']
                                            : 'Mukta-Semibold',
                                      ),
                                    ),
                                  ]),
                                ),
                        ],
                      ),
                weblinkenable == false ||
                        numberenable == false && whatsappnumberenable == false
                    ? SizedBox.shrink()
                    : Divider(
                        thickness: .4,
                        height: 5,
                        color: blackcolor,
                      ),
                weblinkenable == false
                    ? SizedBox.shrink()
                    : Wrap(
                        children: [
                          RichText(
                              text: TextSpan(children: [
                            TextSpan(children: [
                              WidgetSpan(
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: blackcolor,
                                      borderRadius: BorderRadius.circular(3)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: Icon(
                                      Icons.language,
                                      size: weblinksize + 1,
                                      color: whitecolor,
                                    ),
                                  ),
                                ),
                              ),
                              WidgetSpan(child: w(5)),
                              TextSpan(
                                text: profilevalue['web_url'] == null ||
                                        profilevalue['web_url'] == "null" ||
                                        profilevalue['web_url'] == ""
                                    ? "www.csckisan.com"
                                    : profilevalue['web_url'],
                                style: TextStyle(
                                  color: weblinkcolor ?? blackcolor,
                                  fontSize: weblinksize + 2,
                                  fontFamily: weblinkfont != null
                                      ? weblinkfont['font']
                                      : 'Mukta-Semibold',
                                ),
                              ),
                            ]),
                          ])),
                          w(20),
                          RichText(
                            text: TextSpan(children: [
                              WidgetSpan(
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: blackcolor,
                                      borderRadius: BorderRadius.circular(3)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: Icon(
                                      Icons.language,
                                      size: weblinksize + 1,
                                      color: whitecolor,
                                    ),
                                  ),
                                ),
                              ),
                              WidgetSpan(child: w(5)),
                              TextSpan(
                                text: profilevalue['web_url2'] == null ||
                                        profilevalue['web_url2'] == "null" ||
                                        profilevalue['web_url2'] == ""
                                    ? "www.cscjob.com"
                                    : profilevalue['web_url2'],
                                style: TextStyle(
                                  color: weblinkcolor ?? blackcolor,
                                  fontSize: weblinksize + 2,
                                  fontFamily: weblinkfont != null
                                      ? weblinkfont['font']
                                      : 'Mukta-Semibold',
                                ),
                              ),
                            ]),
                          )
                        ],
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  if (frameno == 2) {
    return SizedBox(
      width: width,
      height: height,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Column(
            children: [
              Container(
                height: height / 25,
                color: Colors.orange,
              ),
              Container(
                height: height / 25,
                color: whitecolor,
              ),
              Container(
                height: height / 25,
                color: Colors.green,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  profileenable == false
                      ? SizedBox.shrink()
                      : Expanded(
                          flex: double.parse(
                                  "${profilesize / (width / 30).toInt()}")
                              .toInt(),
                          child: Container()),
                  Expanded(
                    flex: 12,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          h(10),
                          profilevalue["name"] == null || nameenable == false
                              ? SizedBox.shrink()
                              : Text(
                                  profilevalue == null
                                      ? 'शुभेच्छुक: शुभम खत्री'
                                      : "${profilevalue['name']}",
                                  softWrap: true,
                                  style: TextStyle(
                                    color: namecolor ?? redcolor,
                                    fontSize: namesize.toDouble() + 2,
                                    fontFamily: namefont != null
                                        ? namefont['font']
                                        : "Poppins-SemiBold",
                                  ),
                                ),
                          profilevalue["designation"] == null ||
                                  designationenable == false
                              ? SizedBox.shrink()
                              : Text(
                                  profilevalue['designation'],
                                  style: TextStyle(
                                    color: designationcolor,
                                    fontSize: designationsize.toDouble() + 2,
                                    fontFamily: designationfont != null
                                        ? designationfont['font']
                                        : null,
                                  ),
                                ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          (profilevalue["profile_img"] == null || profileenable == false) &&
                  (profileuploadedimage == null || profileenable == false)
              ? profileenable == false
                  ? SizedBox.shrink()
                  : Positioned(
                      left: 0,
                      bottom: 0,
                      child: Image.asset(
                        "assets/dfp.png",
                        width: profilesize,
                        height: profilesize,
                      ))
              : Positioned(
                  left: 0,
                  bottom: 0,
                  child: Container(
                    width: profilesize,
                    height: profilesize,
                    child: profileuploadedimage != null
                        ? Image.file(profileuploadedimage)
                        : CachedNetworkImage(
                            imageUrl: "$weburl/${profilevalue["profile_img"]}",
                            fit: BoxFit.fitWidth),
                  ),
                ),
        ],
      ),
    );
  }
  if (frameno == 3) {
    //print(profilevalue);
    return SizedBox(
      width: width,
      height: height,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Row(
            children: [
              Expanded(
                flex: 12,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    profilevalue["name"] == null || nameenable == false
                        ? SizedBox.shrink()
                        : Text(
                            profilevalue == null
                                ? 'शुभेच्छुक: शुभम खत्री'
                                : "${profilevalue['name']}",
                            softWrap: true,
                            style: TextStyle(
                              color: namecolor ?? redcolor,
                              fontSize: namesize.toDouble() + 2,
                              fontFamily: namefont != null
                                  ? namefont['font']
                                  : "Poppins-SemiBold",
                            ),
                          ),
                    profilevalue["designation"] == null ||
                            designationenable == false
                        ? SizedBox.shrink()
                        : Text(
                            profilevalue['designation'],
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: designationcolor,
                              fontSize: designationsize.toDouble() + 2,
                              fontFamily: designationfont != null
                                  ? designationfont['font']
                                  : null,
                            ),
                          ),
                    profilevalue['whatsapp_num'] == null ||
                            whatsappnumberenable == false
                        ? SizedBox.shrink()
                        : Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 15.0),
                            child: Divider(
                              thickness: 1,
                              color: blackcolor,
                            ),
                          ),
                    profilevalue['whatsapp_num'] == null ||
                            whatsappnumberenable == false
                        ? SizedBox.shrink()
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              FaIcon(
                                FontAwesomeIcons.whatsapp,
                                size: whatsappnumbersize + 2,
                                color: whatsappnumbercolor,
                              ),
                              w(1),
                              Text(
                                profilevalue['whatsapp_num'],
                                style: TextStyle(
                                  color: whatsappnumbercolor,
                                  fontSize: whatsappnumbersize,
                                  fontFamily: whatsappnumberfont != null
                                      ? whatsappnumberfont['font']
                                      : null,
                                ),
                              ),
                            ],
                          ),
                  ],
                ),
              ),
              profileenable == false
                  ? SizedBox.shrink()
                  : Expanded(
                      flex:
                          double.parse("${profilesize / (width / 25).toInt()}")
                              .toInt(),
                      child: Container()),
            ],
          ),
          (profilevalue["profile_img"] == null || profileenable == false) &&
                  (profileuploadedimage == null || profileenable == false)
              ? profileenable == false
                  ? SizedBox.shrink()
                  : Positioned(
                      right: 0,
                      bottom: 0,
                      child: Image.asset(
                        "assets/dfp.png",
                        width: profilesize,
                        height: profilesize,
                      ))
              : Positioned(
                  right: 0,
                  bottom: 0,
                  child: Container(
                    width: profilesize,
                    height: profilesize,
                    child: profileuploadedimage != null
                        ? Image.file(profileuploadedimage)
                        : CachedNetworkImage(
                            imageUrl: "$weburl/${profilevalue["profile_img"]}",
                            fit: BoxFit.fitWidth),
                  ),
                ),
        ],
      ),
    );
  }
  if (frameno == 4) {
    //print(namesize);
    //print(instagramsize);
    return SizedBox(
      width: width,
      height: height,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              profileenable == false
                  ? SizedBox.shrink()
                  : Expanded(
                      flex:
                          double.parse("${profilesize / (width / 30).toInt()}")
                              .toInt(),
                      child: Container()),
              Expanded(
                flex: 12,
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      profilevalue["name"] == null || nameenable == false
                          ? SizedBox.shrink()
                          : Text(
                              profilevalue == null
                                  ? 'शुभेच्छुक: शुभम खत्री'
                                  : "${profilevalue['name']}",
                              softWrap: true,
                              style: TextStyle(
                                color: namecolor ?? redcolor,
                                fontSize: namesize.toDouble() + 2,
                                fontFamily: namefont != null
                                    ? namefont['font']
                                    : "Poppins-SemiBold",
                              ),
                            ),
                      profilevalue["designation"] == null ||
                              designationenable == false
                          ? SizedBox.shrink()
                          : Text(
                              profilevalue['designation'],
                              style: TextStyle(
                                color: designationcolor,
                                fontSize: designationsize.toDouble() + 2,
                                fontFamily: designationfont != null
                                    ? designationfont['font']
                                    : null,
                              ),
                            ),
                      profilevalue['whatsapp_num'] == null ||
                              whatsappnumberenable == false
                          ? SizedBox.shrink()
                          : Padding(
                              padding: const EdgeInsets.only(right: 15.0),
                              child: Divider(
                                thickness: 1,
                                color: blackcolor,
                              ),
                            ),
                      profilevalue['whatsapp_num'] == null ||
                              whatsappnumberenable == false
                          ? SizedBox.shrink()
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                FaIcon(
                                  FontAwesomeIcons.whatsapp,
                                  size: whatsappnumbersize + 3,
                                  color: whatsappnumbercolor,
                                ),
                                w(5),
                                Text(
                                  profilevalue['whatsapp_num'],
                                  style: TextStyle(
                                    color: whatsappnumbercolor,
                                    fontSize: whatsappnumbersize,
                                    fontFamily: whatsappnumberfont != null
                                        ? whatsappnumberfont['font']
                                        : null,
                                  ),
                                ),
                              ],
                            ),
                    ],
                  ),
                ),
              ),
              Container(
                  width: width / 40,
                  height: height,
                  decoration: BoxDecoration(
                    color: primaryColor,
                  )),
            ],
          ),
          (profilevalue["profile_img"] == null || profileenable == false) &&
                  (profileuploadedimage == null || profileenable == false)
              ? profileenable == false
                  ? SizedBox.shrink()
                  : Positioned(
                      left: 0,
                      bottom: 0,
                      child: Image.asset(
                        "assets/dfp.png",
                        width: profilesize,
                        height: profilesize,
                      ))
              : Positioned(
                  left: 0,
                  bottom: 0,
                  child: Container(
                    width: profilesize,
                    height: profilesize,
                    child: profileuploadedimage != null
                        ? Image.file(profileuploadedimage)
                        : CachedNetworkImage(
                            imageUrl: "$weburl/${profilevalue["profile_img"]}",
                            fit: BoxFit.fitWidth),
                  ),
                ),
        ],
      ),
    );
  }

  if (frameno == 5) {
    return SizedBox(
      width: width,
      height: height,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Column(
            children: [
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 11,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          profilevalue["name"] == null || nameenable == false
                              ? SizedBox.shrink()
                              : Text(
                                  profilevalue == null
                                      ? 'शुभेच्छुक: शुभम खत्री'
                                      : "${profilevalue['name']}",
                                  softWrap: true,
                                  style: TextStyle(
                                    color: namecolor ?? Colors.red,
                                    fontSize: namesize.toDouble() + 2,
                                    fontFamily: namefont != null
                                        ? namefont['font']
                                        : "Poppins-SemiBold",
                                  ),
                                ),
                          profilevalue["designation"] == null ||
                                  designationenable == false
                              ? SizedBox.shrink()
                              : Text(
                                  profilevalue['designation'],
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: designationcolor,
                                    fontSize: designationsize.toDouble() + 2,
                                    fontFamily: designationfont != null
                                        ? designationfont['font']
                                        : null,
                                  ),
                                ),
                          profilevalue['whatsapp_num'] == null ||
                                  whatsappnumberenable == false
                              ? SizedBox.shrink()
                              : Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    FaIcon(
                                      FontAwesomeIcons.whatsapp,
                                      size: whatsappnumbersize + 2,
                                      color: whatsappnumbercolor,
                                    ),
                                    w(1),
                                    Text(
                                      profilevalue['whatsapp_num'],
                                      style: TextStyle(
                                        color: whatsappnumbercolor,
                                        fontSize: whatsappnumbersize + 3,
                                        fontFamily: whatsappnumberfont != null
                                            ? whatsappnumberfont['font']
                                            : null,
                                      ),
                                    ),
                                  ],
                                ),
                        ],
                      ),
                    ),
                    profileenable == false
                        ? SizedBox.shrink()
                        : Expanded(
                            flex: double.parse(
                                    "${profilesize / (width / 25).toInt()}")
                                .toInt(),
                            child: Container()),
                  ],
                ),
              ),
            ],
          ),
          (profilevalue["profile_img"] == null || profileenable == false) &&
                  (profileuploadedimage == null || profileenable == false)
              ? profileenable == false
                  ? SizedBox.shrink()
                  : Positioned(
                      right: 0,
                      bottom: 0,
                      child: Image.asset(
                        "assets/dfp.png",
                        width: profilesize,
                        height: profilesize,
                      ))
              : Positioned(
                  right: 0,
                  bottom: 0,
                  child: Container(
                    width: profilesize,
                    height: profilesize,
                    child: profileuploadedimage != null
                        ? Image.file(profileuploadedimage)
                        : CachedNetworkImage(
                            imageUrl: "$weburl/${profilevalue["profile_img"]}",
                            fit: BoxFit.fitWidth),
                  ),
                ),
        ],
      ),
    );
  }
  if (frameno == 6) {
    //print(namesize);
    //print(instagramsize);
    return SizedBox(
      width: width,
      height: height,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Column(
            children: [
              // Container(
              //     width: width,
              //     height: height * .1,
              //     decoration: BoxDecoration(
              //       color: Colors.orange,
              //     )),
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    profileenable == false
                        ? SizedBox.shrink()
                        : Expanded(
                            flex: double.parse(
                                    "${profilesize / (width / 25).toInt()}")
                                .toInt(),
                            child: Container()),
                    Expanded(
                      flex: 11,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          profilevalue["name"] == null || nameenable == false
                              ? SizedBox.shrink()
                              : Text(
                                  profilevalue == null
                                      ? 'शुभेच्छुक: शुभम खत्री'
                                      : "${profilevalue['name']}",
                                  softWrap: true,
                                  style: TextStyle(
                                    color: namecolor ?? Colors.red,
                                    fontSize: namesize.toDouble() + 2,
                                    fontFamily: namefont != null
                                        ? namefont['font']
                                        : "Poppins-SemiBold",
                                  ),
                                ),
                          profilevalue["designation"] == null ||
                                  designationenable == false
                              ? SizedBox.shrink()
                              : Text(
                                  profilevalue['designation'],
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: designationcolor,
                                    fontSize: designationsize.toDouble() + 2,
                                    fontFamily: designationfont != null
                                        ? designationfont['font']
                                        : null,
                                  ),
                                ),
                          // h(2),
                          // instagramenable == false &&
                          //     emailenable == false &&
                          //     facebookenable == false &&
                          //     whatsappnumberenable == false &&
                          //     weblinkenable == false
                          // ? SizedBox.shrink()
                          // : Row(
                          //     mainAxisAlignment:
                          //         MainAxisAlignment.center,
                          //     children: [
                          //       instagramenable == false ||
                          //               profilevalue[
                          //                       'instagram_username'] ==
                          //                   null
                          //           ? SizedBox.shrink()
                          //           : CachedNetworkImageProvider(
                          //               "https://upload.wikimedia.org/wikipedia/commons/thumb/a/a5/Instagram_icon.png/2048px-Instagram_icon.png",
                          //               width: instagramsize,
                          //             ),
                          //       instagramenable == false ||
                          //               profilevalue[
                          //                       'instagram_username'] ==
                          //                   null
                          //           ? SizedBox.shrink()
                          //           : SizedBox(width: 2),
                          //       facebookenable == false ||
                          //               profilevalue[
                          //                       'facebook_username'] ==
                          //                   null
                          //           ? SizedBox.shrink()
                          //           : CachedNetworkImageProvider(
                          //               "https://cdn-icons-png.flaticon.com/512/124/124010.png",
                          //               width: facebooksize,
                          //             ),
                          //       facebookenable == false ||
                          //               profilevalue[
                          //                       'facebook_username'] ==
                          //                   null
                          //           ? SizedBox.shrink()
                          //           : SizedBox(width: 2),
                          //       whatsappnumberenable == false ||
                          //               profilevalue['whatsapp_num'] ==
                          //                   null
                          //           ? SizedBox.shrink()
                          //           : CachedNetworkImageProvider(
                          //               "https://png.pngtree.com/png-vector/20221018/ourmid/pngtree-whatsapp-mobile-software-icon-png-image_6315991.png",
                          //               width: whatsappnumbersize,
                          //             ),
                          //       whatsappnumberenable == false ||
                          //               profilevalue['whatsapp_num'] ==
                          //                   null
                          //           ? SizedBox.shrink()
                          //           : SizedBox(width: 2),
                          //       weblinkenable == false ||
                          //               profilevalue['web_url2'] == null
                          //           ? SizedBox.shrink()
                          //           : Icon(Icons.language,
                          //               size: weblinksize),
                          //       emailenable == false ||
                          //               profilevalue['email'] == null
                          //           ? SizedBox.shrink()
                          //           : Icon(Icons.email, size: emailsize)
                          //     ],
                          //   ),
                        ],
                      ),
                    ),
                    // profilevalue["festival_logo"] == null || logoenable == false
                    //     ? SizedBox.shrink()
                    //     : Expanded(
                    //         flex: 4,
                    //         child: Padding(
                    //           padding: const EdgeInsets.all(10.0),
                    //           child: ClipRRect(
                    //             borderRadius: BorderRadius.circular(logosize),
                    //             child: CachedNetworkImageProvider(
                    //                 profilevalue == null
                    //                     ? url
                    //                     : "$weburl/${profilevalue["festival_logo"]}",
                    //                 fit: BoxFit.fitWidth),
                    //           ),
                    //         ),
                    //       ),
                  ],
                ),
              ),
              // Container(
              //     width: width,
              //     height: height * .1,
              //     decoration: BoxDecoration(
              //       color: Colors.green,
              //     )),
            ],
          ),
          (profilevalue["profile_img"] == null || profileenable == false) &&
                  (profileuploadedimage == null || profileenable == false)
              ? profileenable == false
                  ? SizedBox.shrink()
                  : Positioned(
                      left: 0,
                      bottom: 0,
                      child: Image.asset(
                        "assets/dfp.png",
                        width: profilesize,
                        height: profilesize,
                      ))
              : Positioned(
                  left: 0,
                  bottom: 0,
                  child: Container(
                    width: profilesize,
                    height: profilesize,
                    child: profileuploadedimage != null
                        ? Image.file(profileuploadedimage)
                        : CachedNetworkImage(
                            imageUrl: "$weburl/${profilevalue["profile_img"]}",
                            fit: BoxFit.fitWidth),
                  ),
                ),
        ],
      ),
    );
  }
  if (frameno == 7) {
    return SizedBox(
      width: width,
      height: height,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Column(
            children: [
              // Container(
              //     width: width,
              //     height: height * .1,
              //     decoration: BoxDecoration(
              //       color: Colors.orange,
              //     )),
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 11,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            profilevalue["name"] == null || nameenable == false
                                ? SizedBox.shrink()
                                : Text(
                                    profilevalue == null
                                        ? 'शुभेच्छुक: शुभम खत्री'
                                        : "${profilevalue['name']}",
                                    softWrap: true,
                                    style: TextStyle(
                                      color: namecolor ?? redcolor,
                                      fontSize: namesize.toDouble() + 2,
                                      fontFamily: namefont != null
                                          ? namefont['font']
                                          : "Poppins-SemiBold",
                                    ),
                                  ),
                            profilevalue["designation"] == null ||
                                    designationenable == false
                                ? SizedBox.shrink()
                                : Text(
                                    profilevalue['designation'],
                                    style: TextStyle(
                                      color: designationcolor,
                                      fontSize: designationsize.toDouble() + 2,
                                      fontFamily: designationfont != null
                                          ? designationfont['font']
                                          : null,
                                    ),
                                  ),
                            profilevalue['whatsapp_num'] == null ||
                                    whatsappnumberenable == false
                                ? SizedBox.shrink()
                                : Padding(
                                    padding: const EdgeInsets.only(right: 15.0),
                                    child: Divider(
                                      thickness: 1,
                                      color: blackcolor,
                                    ),
                                  ),
                            profilevalue['whatsapp_num'] == null ||
                                    whatsappnumberenable == false
                                ? SizedBox.shrink()
                                : Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      FaIcon(
                                        FontAwesomeIcons.whatsapp,
                                        size: whatsappnumbersize + 3,
                                        color: whatsappnumbercolor,
                                      ),
                                      w(5),
                                      Text(
                                        profilevalue['whatsapp_num'],
                                        style: TextStyle(
                                          color: whatsappnumbercolor,
                                          fontSize: whatsappnumbersize,
                                          fontFamily: whatsappnumberfont != null
                                              ? whatsappnumberfont['font']
                                              : null,
                                        ),
                                      ),
                                    ],
                                  ),
                          ],
                        ),
                      ),
                    ),
                    profileenable == false
                        ? SizedBox.shrink()
                        : Expanded(
                            flex: double.parse(
                                    "${profilesize / (width / 25).toInt()}")
                                .toInt(),
                            child: Container()),
                  ],
                ),
              ),
            ],
          ),
          (profilevalue["profile_img"] == null || profileenable == false) &&
                  (profileuploadedimage == null || profileenable == false)
              ? profileenable == false
                  ? SizedBox.shrink()
                  : Positioned(
                      right: 5,
                      bottom: 5,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(width / 3),
                        child: Container(
                          color: Colors.orange,
                          width: profilesize,
                          height: profilesize,
                          child: Image.asset(
                            "assets/dfp.png",
                            width: profilesize,
                            height: profilesize,
                          ),
                        ),
                      ))
              : Positioned(
                  right: 5,
                  bottom: 5,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(width / 3),
                    child: Container(
                      color: Colors.orange,
                      width: profilesize,
                      height: profilesize,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: profileuploadedimage != null
                            ? Image.file(profileuploadedimage)
                            : CachedNetworkImage(
                                imageUrl:
                                    "$weburl/${profilevalue["profile_img"]}",
                                fit: BoxFit.fitWidth),
                      ),
                    ),
                  ),
                ),
        ],
      ),
    );
  }
  if (frameno == 8) {
    return SizedBox(
      width: width,
      height: height,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Column(
            children: [
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    profileenable == false
                        ? SizedBox.shrink()
                        : Expanded(
                            flex: double.parse(
                                    "${profilesize / (width / 25).toInt()}")
                                .toInt(),
                            child: Container()),
                    Expanded(
                      flex: 11,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            profilevalue["name"] == null || nameenable == false
                                ? SizedBox.shrink()
                                : Text(
                                    profilevalue == null
                                        ? 'शुभेच्छुक: शुभम खत्री'
                                        : "${profilevalue['name']}",
                                    softWrap: true,
                                    style: TextStyle(
                                      color: namecolor ?? redcolor,
                                      fontSize: namesize.toDouble() + 2,
                                      fontFamily: namefont != null
                                          ? namefont['font']
                                          : "Poppins-SemiBold",
                                    ),
                                  ),
                            profilevalue["designation"] == null ||
                                    designationenable == false
                                ? SizedBox.shrink()
                                : Text(
                                    profilevalue['designation'],
                                    style: TextStyle(
                                      color: designationcolor,
                                      fontSize: designationsize.toDouble() + 2,
                                      fontFamily: designationfont != null
                                          ? designationfont['font']
                                          : null,
                                    ),
                                  ),
                            profilevalue['whatsapp_num'] == null ||
                                    whatsappnumberenable == false
                                ? SizedBox.shrink()
                                : Padding(
                                    padding: const EdgeInsets.only(right: 15.0),
                                    child: Divider(
                                      thickness: 1,
                                      color: blackcolor,
                                    ),
                                  ),
                            profilevalue['whatsapp_num'] == null ||
                                    whatsappnumberenable == false
                                ? SizedBox.shrink()
                                : Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      FaIcon(
                                        FontAwesomeIcons.whatsapp,
                                        size: whatsappnumbersize + 3,
                                        color: whatsappnumbercolor,
                                      ),
                                      w(5),
                                      Text(
                                        profilevalue['whatsapp_num'],
                                        style: TextStyle(
                                          color: whatsappnumbercolor,
                                          fontSize: whatsappnumbersize,
                                          fontFamily: whatsappnumberfont != null
                                              ? whatsappnumberfont['font']
                                              : null,
                                        ),
                                      ),
                                    ],
                                  ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          (profilevalue["profile_img"] == null || profileenable == false) &&
                  (profileuploadedimage == null || profileenable == false)
              ? profileenable == false
                  ? SizedBox.shrink()
                  : Positioned(
                      left: 5,
                      bottom: 5,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(width / 3),
                        child: Container(
                          color: Colors.orange,
                          width: profilesize,
                          height: profilesize,
                          child: Image.asset(
                            "assets/dfp.png",
                            width: profilesize,
                            height: profilesize,
                          ),
                        ),
                      ))
              : Positioned(
                  left: 5,
                  bottom: 5,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(width / 3),
                    child: Container(
                      color: Colors.orange,
                      width: profilesize,
                      height: profilesize,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: profileuploadedimage != null
                            ? Image.file(profileuploadedimage)
                            : CachedNetworkImage(
                                imageUrl:
                                    "$weburl/${profilevalue["profile_img"]}",
                                fit: BoxFit.fitWidth),
                      ),
                    ),
                  ),
                ),
        ],
      ),
    );
  }
  // if (frameno == 1) {
  //   var height = MediaQuery.of(context).size.width / 4.37;
  //   var width = MediaQuery.of(context).size.width * 0.93;
  //   return SizedBox(
  //       width: width,
  //       height: height,
  //       child: Stack(children: <Widget>[
  //         Positioned(
  //             top: 0,
  //             left: 0,
  //             child: Container(
  //                 width: width,
  //                 height: height,
  //                 decoration: const BoxDecoration(
  //                   image: DecorationImage(
  //                       image: AssetImage('assets/festivalframe/festival1.png'),
  //                       fit: BoxFit.fitWidth),
  //                 ))),
  //         Positioned(
  //             top: height / 18,
  //             left: width / 35,
  //             child:
  //                 // CachedNetworkImageProvider(
  //                 //   profilevalue == null
  //                 //       ? url
  //                 //       : "$weburl/${profilevalue["profile_img"]}",
  //                 //   // : "https://images.rawpixel.com/image_png_800/czNmcy1wcml2YXRlL3Jhd3BpeGVsX2ltYWdlcy93ZWJzaXRlX2NvbnRlbnQvNDc5LW1rLTk2OTAucG5n.png?s=mE2kuezlYwHlyYN49pIebbPqB5Kyz9HNqd3b0U6TkHk",
  //                 //   width: width / 4,
  //                 // ),
  //                 Container(
  //                     width: width / 9,
  //                     height: width / 9,
  //                     decoration: BoxDecoration(
  //                       borderRadius: BorderRadius.circular(width / 13),
  //                       image: DecorationImage(
  //                           image: NetworkImage(
  //                             profilevalue == null
  //                                 ? url
  //                                 // : "$weburl/${profilevalue["profile_img"]}",
  //                                 : "https://images.rawpixel.com/image_png_800/czNmcy1wcml2YXRlL3Jhd3BpeGVsX2ltYWdlcy93ZWJzaXRlX2NvbnRlbnQvNDc5LW1rLTk2OTAucG5n.png?s=mE2kuezlYwHlyYN49pIebbPqB5Kyz9HNqd3b0U6TkHk",
  //                           ),
  //                           fit: BoxFit.fitWidth),
  //                     ))),
  //         Positioned(
  //             top: height / 2.3,
  //             left: width / 1.27,
  //             child: Container(
  //                 width: width / 9,
  //                 height: width / 9,
  //                 decoration: BoxDecoration(
  //                   borderRadius: BorderRadius.circular(width / 13),
  //                   image: DecorationImage(
  //                       image: profileuploadedimage != null
  //                           ? FileImage(profileuploadedimage)
  //                           : CachedNetworkImageProvider(
  //                               profilevalue == null
  //                                   ? url
  //                                   : "$weburl/${profilevalue["profile_img"]}",
  //                             ).image,
  //                       fit: BoxFit.cover),
  //                 ))),
  //         Positioned(
  //             top: width / 20,
  //             left: width / 12.84,
  //             child: SizedBox(
  //               height: height - height / 10,
  //               width: width,
  //               child: Row(
  //                 mainAxisAlignment: MainAxisAlignment.spaceAround,
  //                 children: [
  //                   const Expanded(flex: 3, child: SizedBox()),
  //                   Expanded(
  //                     flex: 9,
  //                     child: FittedBox(
  //                       fit: BoxFit.fill,
  //                       child: Column(
  //                         mainAxisAlignment: MainAxisAlignment.spaceAround,
  //                         crossAxisAlignment: CrossAxisAlignment.start,
  //                         children: [
  //                           Text(
  //                             profilevalue == null
  //                                 ? 'शुभेच्छुक: शुभम खत्री'
  //                                 : "शुभेच्छुक: ${profilevalue['name']}",
  //                             softWrap: true,
  //                             maxLines: 1,
  //                             style: TextStyle(
  //                               color: namecolor,
  //                               fontSize: namesize.toDouble(),
  //                               fontFamily: namefont != null
  //                                   ? namefont['font']
  //                                   : "Poppins-SemiBold",
  //                             ),
  //                           ),
  //                           FittedBox(
  //                             child: Text(
  //                               'तालुका अध्यक्ष: तालुक्याचे नाव',
  //                               textAlign: TextAlign.center,
  //                               maxLines: 1,
  //                               style: TextStyle(
  //                                 color: emailcolor,
  //                                 fontSize: emailsize.toDouble(),
  //                                 fontFamily: emailfont != null
  //                                     ? emailfont['font']
  //                                     : null,
  //                               ),
  //                             ),
  //                           )
  //                         ],
  //                       ),
  //                     ),
  //                   ),
  //                   const Expanded(flex: 4, child: SizedBox()),
  //                   const Expanded(child: SizedBox(width: 10)),
  //                 ],
  //               ),
  //             )),
  //       ]));
  // }
  // if (frameno == 2) {
  //   var height = MediaQuery.of(context).size.width / 7.4;
  //   var width = MediaQuery.of(context).size.width * 0.93;
  //   return SizedBox(
  //       width: width,
  //       height: height,
  //       child: Stack(children: <Widget>[
  //         Positioned(
  //             bottom: 0,
  //             left: 0,
  //             child: Container(
  //                 width: width,
  //                 height: height,
  //                 decoration: const BoxDecoration(
  //                   image: DecorationImage(
  //                       image: AssetImage('assets/festivalframe/festival2.png'),
  //                       fit: BoxFit.fitWidth),
  //                 ))),
  //         Positioned(
  //             top: height / 15,
  //             left: width / 14.6,
  //             child: Container(
  //                 width: width / 8.1,
  //                 height: width / 8.1,
  //                 decoration: BoxDecoration(
  //                   borderRadius: BorderRadius.circular(width / 13),
  //                   image: DecorationImage(
  //                       image: profileuploadedimage != null
  //                           ? FileImage(profileuploadedimage)
  //                           : CachedNetworkImageProvider(
  //                               profilevalue == null
  //                                   ? url
  //                                   : "$weburl/${profilevalue["profile_img"]}",
  //                             ).image,
  //                       fit: BoxFit.cover),
  //                 ))),
  //         Positioned(
  //             top: height / 13,
  //             left: width / 1.21,
  //             child: Container(
  //                 width: width / 8.3,
  //                 height: width / 8.3,
  //                 decoration: BoxDecoration(
  //                   borderRadius: BorderRadius.circular(width / 13),
  //                   image: DecorationImage(
  //                       image: profileuploadedimage != null
  //                           ? FileImage(profileuploadedimage)
  //                           : CachedNetworkImageProvider(
  //                               profilevalue == null
  //                                   ? url
  //                                   : "$weburl/${profilevalue["profile_img"]}",
  //                             ).image,
  //                       fit: BoxFit.cover),
  //                 ))),
  //         Positioned(
  //             top: height / 13,
  //             left: width / 5.5,
  //             child: SizedBox(
  //               height: height - height / 10,
  //               width: width / 1.3,
  //               child: Row(
  //                 mainAxisAlignment: MainAxisAlignment.spaceAround,
  //                 children: [
  //                   const Expanded(flex: 3, child: SizedBox()),
  //                   Expanded(
  //                     flex: 9,
  //                     child: FittedBox(
  //                       fit: BoxFit.fill,
  //                       child: Column(
  //                         mainAxisAlignment: MainAxisAlignment.center,
  //                         crossAxisAlignment: CrossAxisAlignment.center,
  //                         children: [
  //                           Text(
  //                             profilevalue == null
  //                                 ? 'शुभेच्छुक: शुभम खत्री'
  //                                 : "शुभेच्छुक: ${profilevalue['name']}",
  //                             softWrap: true,
  //                             maxLines: 1,
  //                             style: TextStyle(
  //                               color: emailcolor,
  //                               fontSize: emailsize.toDouble(),
  //                               fontFamily: emailfont != null
  //                                   ? emailfont['font']
  //                                   : null,
  //                             ),
  //                           ),
  //                           FittedBox(
  //                             child: Text(
  //                               'तालुका अध्यक्ष: तालुक्याचे नाव',
  //                               textAlign: TextAlign.center,
  //                               maxLines: 1,
  //                               style: TextStyle(
  //                                 color: emailcolor,
  //                                 fontSize: emailsize.toDouble(),
  //                                 fontFamily: emailfont != null
  //                                     ? emailfont['font']
  //                                     : null,
  //                               ),
  //                             ),
  //                           )
  //                         ],
  //                       ),
  //                     ),
  //                   ),
  //                   const Expanded(flex: 4, child: SizedBox()),
  //                   const Expanded(child: SizedBox(width: 10)),
  //                 ],
  //               ),
  //             )),
  //       ]));
  // }
  // if (frameno == 3) {
  //   var height = MediaQuery.of(context).size.width / 4.37;
  //   var width = MediaQuery.of(context).size.width * 0.93;
  //   //print(width / 20);
  //   return SizedBox(
  //       width: width,
  //       height: height,
  //       child: Stack(children: <Widget>[
  //         Positioned(
  //             top: 0,
  //             left: 0,
  //             child: Container(
  //                 width: width,
  //                 height: height,
  //                 decoration: const BoxDecoration(
  //                   image: DecorationImage(
  //                       image: AssetImage('assets/festivalframe/festival3.png'),
  //                       fit: BoxFit.fitWidth),
  //                 ))),
  //         Positioned(
  //             top: height / 7.9,
  //             left: width / 19,
  //             child: Container(
  //                 width: width / 6.4,
  //                 height: width / 6.4,
  //                 decoration: BoxDecoration(
  //                   borderRadius: BorderRadius.circular(width / 13),
  //                   image: DecorationImage(
  //                       image: profileuploadedimage != null
  //                           ? FileImage(profileuploadedimage)
  //                           : CachedNetworkImageProvider(
  //                               profilevalue == null
  //                                   ? url
  //                                   : "$weburl/${profilevalue["profile_img"]}",
  //                             ).image,
  //                       fit: BoxFit.cover),
  //                 ))),
  //         Positioned(
  //             top: height / 5.2,
  //             left: width / 1.21,
  //             child: Container(
  //                 width: width / 8.4,
  //                 height: width / 8.4,
  //                 decoration: BoxDecoration(
  //                   borderRadius: BorderRadius.circular(width / 13),
  //                   image: DecorationImage(
  //                       image: profileuploadedimage != null
  //                           ? FileImage(profileuploadedimage)
  //                           : CachedNetworkImageProvider(
  //                               profilevalue == null
  //                                   ? url
  //                                   : "$weburl/${profilevalue["profile_img"]}",
  //                             ).image,
  //                       fit: BoxFit.cover),
  //                 ))),
  //         Positioned(
  //             top: height / 1.7,
  //             left: width / 1.23,
  //             child: Container(
  //               width: width / 3,
  //               height: width / 8.4,
  //               child: Row(
  //                 children: [
  //                   CachedNetworkImageProvider(
  //                     "https://upload.wikimedia.org/wikipedia/commons/thumb/a/a5/Instagram_icon.png/2048px-Instagram_icon.png",
  //                     width: width / 20,
  //                   ),
  //                   SizedBox(width: 2),
  //                   CachedNetworkImageProvider(
  //                     "https://cdn-icons-png.flaticon.com/512/124/124010.png",
  //                     width: width / 20,
  //                   ),
  //                   SizedBox(width: 2),
  //                   CachedNetworkImageProvider(
  //                     "https://cdn-icons-png.flaticon.com/512/124/124021.png",
  //                     width: width / 20,
  //                   )
  //                 ],
  //               ),
  //             )),
  //         Positioned(
  //             top: height / 3.2,
  //             left: width / 5.5,
  //             child: SizedBox(
  //               height: height - height / 10,
  //               width: width / 1.3,
  //               child: Row(
  //                 mainAxisAlignment: MainAxisAlignment.spaceAround,
  //                 children: [
  //                   const Expanded(flex: 3, child: SizedBox()),
  //                   Expanded(
  //                     flex: 9,
  //                     child: FittedBox(
  //                       fit: BoxFit.fill,
  //                       child: Column(
  //                         mainAxisAlignment: MainAxisAlignment.center,
  //                         crossAxisAlignment: CrossAxisAlignment.center,
  //                         children: [
  //                           Text(
  //                             profilevalue == null
  //                                 ? 'शुभेच्छुक: शुभम खत्री'
  //                                 : "शुभेच्छुक: ${profilevalue['name']}",
  //                             softWrap: true,
  //                             maxLines: 1,
  //                             style: TextStyle(
  //                               color: emailcolor,
  //                               fontSize: emailsize.toDouble(),
  //                               fontFamily: emailfont != null
  //                                   ? emailfont['font']
  //                                   : null,
  //                             ),
  //                           ),
  //                           FittedBox(
  //                             child: Text(
  //                               'तालुका अध्यक्ष: तालुक्याचे नाव',
  //                               textAlign: TextAlign.center,
  //                               maxLines: 1,
  //                               style: TextStyle(
  //                                 color: emailcolor,
  //                                 fontSize: emailsize.toDouble(),
  //                                 fontFamily: emailfont != null
  //                                     ? emailfont['font']
  //                                     : null,
  //                               ),
  //                             ),
  //                           )
  //                         ],
  //                       ),
  //                     ),
  //                   ),
  //                   const Expanded(flex: 4, child: SizedBox()),
  //                   const Expanded(child: SizedBox(width: 10)),
  //                 ],
  //               ),
  //             )),
  //       ]));
  // }
  // if (frameno == 4) {
  //   var height = MediaQuery.of(context).size.width / 4.37;
  //   var width = MediaQuery.of(context).size.width * 0.93;
  //   //print(width / 20);
  //   return SizedBox(
  //       width: width,
  //       height: height,
  //       child: Stack(children: <Widget>[
  //         Positioned(
  //             top: 0,
  //             left: 0,
  //             child: Container(
  //                 width: width,
  //                 height: height,
  //                 decoration: const BoxDecoration(
  //                   image: DecorationImage(
  //                       image: AssetImage('assets/festivalframe/festival4.png'),
  //                       fit: BoxFit.fitWidth),
  //                 ))),
  //         Positioned(
  //             top: height / 7.9,
  //             left: width / 27,
  //             child: Container(
  //                 width: width / 6.4,
  //                 height: width / 6.4,
  //                 decoration: BoxDecoration(
  //                   borderRadius: BorderRadius.circular(width / 13),
  //                   border: Border.all(color: Colors.grey.shade300, width: 2),
  //                   image: DecorationImage(
  //                       image: profileuploadedimage != null
  //                           ? FileImage(profileuploadedimage)
  //                           : CachedNetworkImageProvider(
  //                               profilevalue == null
  //                                   ? url
  //                                   : "$weburl/${profilevalue["profile_img"]}",
  //                             ).image,
  //                       fit: BoxFit.cover),
  //                 ))),
  //         Positioned(
  //             top: height / 5.2,
  //             left: width / 1.21,
  //             child: Container(
  //                 width: width / 8.4,
  //                 height: width / 8.4,
  //                 decoration: BoxDecoration(
  //                   borderRadius: BorderRadius.circular(width / 13),
  //                   image: DecorationImage(
  //                       image: profileuploadedimage != null
  //                           ? FileImage(profileuploadedimage)
  //                           : CachedNetworkImageProvider(
  //                               profilevalue == null
  //                                   ? url
  //                                   : "$weburl/${profilevalue["profile_img"]}",
  //                             ).image,
  //                       fit: BoxFit.cover),
  //                 ))),
  //         Positioned(
  //             top: height / 15,
  //             left: width / 13,
  //             child: SizedBox(
  //               height: height - height / 10,
  //               width: width,
  //               child: Row(
  //                 mainAxisAlignment: MainAxisAlignment.spaceAround,
  //                 children: [
  //                   const Expanded(flex: 2, child: SizedBox()),
  //                   Expanded(
  //                     flex: 10,
  //                     child: FittedBox(
  //                       child: Row(
  //                         children: [
  //                           Column(
  //                             mainAxisAlignment: MainAxisAlignment.center,
  //                             crossAxisAlignment: CrossAxisAlignment.center,
  //                             children: [
  //                               Text(
  //                                 profilevalue == null
  //                                     ? 'शुभेच्छुक: शुभम खत्री'
  //                                     : "शुभेच्छुक: ${profilevalue['name']}",
  //                                 softWrap: true,
  //                                 maxLines: 1,
  //                                 style: TextStyle(
  //                                   color: emailcolor,
  //                                   fontSize: emailsize.toDouble(),
  //                                   fontFamily: emailfont != null
  //                                       ? emailfont['font']
  //                                       : null,
  //                                 ),
  //                               ),
  //                               FittedBox(
  //                                 child: Text(
  //                                   'तालुका अध्यक्ष: तालुक्याचे नाव',
  //                                   textAlign: TextAlign.center,
  //                                   maxLines: 1,
  //                                   style: TextStyle(
  //                                     color: emailcolor,
  //                                     fontSize: emailsize.toDouble(),
  //                                     fontFamily: emailfont != null
  //                                         ? emailfont['font']
  //                                         : null,
  //                                   ),
  //                                 ),
  //                               )
  //                             ],
  //                           ),
  //                           const SizedBox(width: 10),
  //                           Column(
  //                             mainAxisAlignment: MainAxisAlignment.start,
  //                             crossAxisAlignment: CrossAxisAlignment.start,
  //                             children: [
  //                               Row(
  //                                 children: [
  //                                   CachedNetworkImageProvider(
  //                                     "https://upload.wikimedia.org/wikipedia/commons/thumb/a/a5/Instagram_icon.png/2048px-Instagram_icon.png",
  //                                     width: width / 20,
  //                                   ),
  //                                   Text(
  //                                     profilevalue == null
  //                                         ? 'शुभेच्छुक: शुभम खत्री'
  //                                         : " ${profilevalue['instagram_username']}",
  //                                     softWrap: true,
  //                                     maxLines: 1,
  //                                     style: TextStyle(
  //                                       color: emailcolor,
  //                                       fontSize: emailsize.toDouble(),
  //                                       fontFamily: emailfont != null
  //                                           ? emailfont['font']
  //                                           : null,
  //                                     ),
  //                                   ),
  //                                 ],
  //                               ),
  //                               SizedBox(height: 3),
  //                               Row(
  //                                 children: [
  //                                   CachedNetworkImageProvider(
  //                                     "https://cdn-icons-png.flaticon.com/512/124/124010.png",
  //                                     width: width / 20,
  //                                   ),
  //                                   Text(
  //                                     profilevalue == null
  //                                         ? 'शुभेच्छुक: शुभम खत्री'
  //                                         : " ${profilevalue['facebook_username']}",
  //                                     softWrap: true,
  //                                     maxLines: 1,
  //                                     style: TextStyle(
  //                                       color: emailcolor,
  //                                       fontSize: emailsize.toDouble(),
  //                                       fontFamily: emailfont != null
  //                                           ? emailfont['font']
  //                                           : null,
  //                                     ),
  //                                   ),
  //                                 ],
  //                               ),
  //                               SizedBox(height: 3),
  //                               Row(
  //                                 children: [
  //                                   CachedNetworkImageProvider(
  //                                     "https://cdn-icons-png.flaticon.com/512/124/124021.png",
  //                                     width: width / 20,
  //                                   ),
  //                                   Text(
  //                                     profilevalue == null
  //                                         ? 'शुभेच्छुक: शुभम खत्री'
  //                                         : " ${profilevalue['twitter_username']}",
  //                                     softWrap: true,
  //                                     maxLines: 1,
  //                                     style: TextStyle(
  //                                       color: emailcolor,
  //                                       fontSize: emailsize.toDouble(),
  //                                       fontFamily: emailfont != null
  //                                           ? emailfont['font']
  //                                           : null,
  //                                     ),
  //                                   ),
  //                                 ],
  //                               ),
  //                               SizedBox(height: 3),
  //                               Row(
  //                                 children: [
  //                                   CachedNetworkImageProvider(
  //                                     "https://www.seekpng.com/png/detail/41-415678_email-icon-vector-circle.png",
  //                                     width: width / 20,
  //                                   ),
  //                                   Text(
  //                                     profilevalue == null
  //                                         ? 'शुभेच्छुक: शुभम खत्री'
  //                                         : " ${profilevalue['email']}",
  //                                     softWrap: true,
  //                                     maxLines: 1,
  //                                     style: TextStyle(
  //                                       color: emailcolor,
  //                                       fontSize: emailsize.toDouble(),
  //                                       fontFamily: emailfont != null
  //                                           ? emailfont['font']
  //                                           : null,
  //                                     ),
  //                                   ),
  //                                 ],
  //                               ),
  //                               SizedBox(height: 3),
  //                               Row(
  //                                 children: [
  //                                   CachedNetworkImageProvider(
  //                                     "https://www.transparentpng.com/thumb/browsers/uEski3-browsers-transparent.png",
  //                                     width: width / 20,
  //                                   ),
  //                                   Text(
  //                                     profilevalue == null
  //                                         ? 'शुभेच्छुक: शुभम खत्री'
  //                                         : " ${profilevalue['web_url']}",
  //                                     softWrap: true,
  //                                     maxLines: 1,
  //                                     style: TextStyle(
  //                                       color: emailcolor,
  //                                       fontSize: emailsize.toDouble(),
  //                                       fontFamily: emailfont != null
  //                                           ? emailfont['font']
  //                                           : null,
  //                                     ),
  //                                   ),
  //                                 ],
  //                               )
  //                             ],
  //                           ),
  //                         ],
  //                       ),
  //                     ),
  //                   ),
  //                   const Expanded(flex: 4, child: SizedBox()),
  //                   const Expanded(child: SizedBox(width: 10)),
  //                 ],
  //               ),
  //             )),
  //       ]));
  // }
  // if (frameno == 5) {
  //   var height = MediaQuery.of(context).size.width / 7.5;
  //   var width = MediaQuery.of(context).size.width * 0.93;
  //   return SizedBox(
  //       width: width,
  //       height: height,
  //       child: Stack(children: <Widget>[
  //         Positioned(
  //             top: 0,
  //             left: 0,
  //             child: Container(
  //                 width: width,
  //                 height: height,
  //                 decoration: const BoxDecoration(
  //                   image: DecorationImage(
  //                       image: AssetImage('assets/festivalframe/festival5.png'),
  //                       fit: BoxFit.fitWidth),
  //                 ))),
  //         Positioned(
  //             top: height / 9,
  //             left: width / 1.2,
  //             child: Container(
  //                 width: width / 8,
  //                 height: width / 8,
  //                 decoration: BoxDecoration(
  //                   borderRadius: BorderRadius.circular(width / 13),
  //                   image: DecorationImage(
  //                       image: profileuploadedimage != null
  //                           ? FileImage(profileuploadedimage)
  //                           : CachedNetworkImageProvider(
  //                               profilevalue == null
  //                                   ? url
  //                                   : "$weburl/${profilevalue["profile_img"]}",
  //                             ).image,
  //                       fit: BoxFit.cover),
  //                 ))),
  //         Positioned(
  //             top: height / 9,
  //             left: width / 40,
  //             child: Container(
  //                 width: width / 9,
  //                 height: width / 9,
  //                 decoration: BoxDecoration(
  //                   borderRadius: BorderRadius.circular(width / 13),
  //                   image: DecorationImage(
  //                       image: profileuploadedimage != null
  //                           ? FileImage(profileuploadedimage)
  //                           : CachedNetworkImageProvider(
  //                               profilevalue == null
  //                                   ? url
  //                                   : "$weburl/${profilevalue["profile_img"]}",
  //                             ).image,
  //                       fit: BoxFit.cover),
  //                 ))),
  //         Positioned(
  //             top: width / 50,
  //             left: width / 18,
  //             child: SizedBox(
  //               height: height - height / 10,
  //               width: width,
  //               child: Row(
  //                 mainAxisAlignment: MainAxisAlignment.spaceAround,
  //                 children: [
  //                   const Expanded(flex: 2, child: SizedBox()),
  //                   Expanded(
  //                     flex: 9,
  //                     child: FittedBox(
  //                       fit: BoxFit.fill,
  //                       child: Column(
  //                         mainAxisAlignment: MainAxisAlignment.spaceAround,
  //                         crossAxisAlignment: CrossAxisAlignment.start,
  //                         children: [
  //                           Text(
  //                             profilevalue == null
  //                                 ? 'शुभेच्छुक: शुभम खत्री'
  //                                 : "शुभेच्छुक: ${profilevalue['name']}",
  //                             softWrap: true,
  //                             maxLines: 1,
  //                             style: TextStyle(
  //                               color: emailcolor,
  //                               fontSize: emailsize.toDouble(),
  //                               fontFamily: emailfont != null
  //                                   ? emailfont['font']
  //                                   : null,
  //                             ),
  //                           ),
  //                           FittedBox(
  //                             child: Text(
  //                               'तालुका अध्यक्ष: तालुक्याचे नाव',
  //                               textAlign: TextAlign.center,
  //                               maxLines: 1,
  //                               style: TextStyle(
  //                                 color: emailcolor,
  //                                 fontSize: emailsize.toDouble(),
  //                                 fontFamily: emailfont != null
  //                                     ? emailfont['font']
  //                                     : null,
  //                               ),
  //                             ),
  //                           )
  //                         ],
  //                       ),
  //                     ),
  //                   ),
  //                   const Expanded(flex: 4, child: SizedBox()),
  //                   const Expanded(child: SizedBox(width: 10)),
  //                 ],
  //               ),
  //             )),
  //       ]));
  // }
  // if (frameno == 6) {
  //   var height = MediaQuery.of(context).size.width / 5.5;
  //   var width = MediaQuery.of(context).size.width * 0.93;
  //   //print(width / 20);
  //   return SizedBox(
  //       width: width,
  //       height: height,
  //       child: Stack(children: <Widget>[
  //         Positioned(
  //             bottom: 0,
  //             left: 0,
  //             child: Container(
  //                 width: width,
  //                 height: height / 2,
  //                 decoration: const BoxDecoration(
  //                   image: DecorationImage(
  //                       image: AssetImage('assets/festivalframe/festival6.png'),
  //                       fit: BoxFit.fitWidth),
  //                 ))),
  //         // Positioned(
  //         //     top: height / 7.9,
  //         //     left: width / 19,
  //         //     child: Container(
  //         //         width: width / 6.4,
  //         //         height: width / 6.4,
  //         //         decoration: BoxDecoration(
  //         //           borderRadius: BorderRadius.circular(width / 13),
  //         //           image: DecorationImage(
  //         //               image: NetworkImage(
  //         //                 profilevalue == null
  //         //                     ? url
  //         //                     : "$weburl/${profilevalue["profile_img"]}",
  //         //               ),
  //         //               fit: BoxFit.fitWidth),
  //         //         ))),
  //         Positioned(
  //             top: height / 3,
  //             left: width / 1.21,
  //             child: Container(
  //                 width: width / 8.4,
  //                 height: width / 8.4,
  //                 decoration: BoxDecoration(
  //                   border: Border.all(color: whitecolor, width: 3),
  //                   borderRadius: BorderRadius.circular(width / 13),
  //                   image: DecorationImage(
  //                       image: profileuploadedimage != null
  //                           ? FileImage(profileuploadedimage)
  //                           : CachedNetworkImageProvider(
  //                               profilevalue == null
  //                                   ? url
  //                                   : "$weburl/${profilevalue["profile_img"]}",
  //                             ).image,
  //                       fit: BoxFit.cover),
  //                 ))),
  //         Positioned(
  //             top: height / 2,
  //             left: width / 3,
  //             child: Container(
  //               width: width / 2,
  //               height: width / 8.4,
  //               child: FittedBox(
  //                 child: Row(
  //                   children: [
  //                     FittedBox(
  //                       child: Row(
  //                         children: [
  //                           CachedNetworkImageProvider(
  //                             "https://upload.wikimedia.org/wikipedia/commons/thumb/a/a5/Instagram_icon.png/2048px-Instagram_icon.png",
  //                             width: width / 20,
  //                           ),
  //                           Text(
  //                             profilevalue == null
  //                                 ? 'शुभेच्छुक: शुभम खत्री'
  //                                 : " ${profilevalue['instagram_username']}",
  //                             softWrap: true,
  //                             maxLines: 1,
  //                             style: TextStyle(
  //                               color: emailcolor,
  //                               fontSize: emailsize.toDouble(),
  //                               fontFamily: emailfont != null
  //                                   ? emailfont['font']
  //                                   : null,
  //                             ),
  //                           ),
  //                         ],
  //                       ),
  //                     ),
  //                     SizedBox(width: 10),
  //                     FittedBox(
  //                       child: Row(
  //                         children: [
  //                           CachedNetworkImageProvider(
  //                             "https://cdn-icons-png.flaticon.com/512/124/124010.png",
  //                             width: width / 20,
  //                           ),
  //                           Text(
  //                             profilevalue == null
  //                                 ? 'शुभेच्छुक: शुभम खत्री'
  //                                 : " ${profilevalue['facebook_username']}",
  //                             softWrap: true,
  //                             maxLines: 1,
  //                             style: TextStyle(
  //                               color: emailcolor,
  //                               fontSize: emailsize.toDouble(),
  //                               fontFamily: emailfont != null
  //                                   ? emailfont['font']
  //                                   : null,
  //                             ),
  //                           ),
  //                         ],
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //             )),
  //         Positioned(
  //             top: height / 3,
  //             left: width / 30,
  //             child: SizedBox(
  //               height: height - height / 10,
  //               width: width / 2.5,
  //               child: Row(
  //                 mainAxisAlignment: MainAxisAlignment.spaceAround,
  //                 children: [
  //                   Expanded(
  //                     flex: 10,
  //                     child: FittedBox(
  //                       fit: BoxFit.fill,
  //                       child: Column(
  //                         mainAxisAlignment: MainAxisAlignment.center,
  //                         crossAxisAlignment: CrossAxisAlignment.center,
  //                         children: [
  //                           Text(
  //                             profilevalue == null
  //                                 ? 'शुभेच्छुक: शुभम खत्री'
  //                                 : "शुभेच्छुक: ${profilevalue['name']}",
  //                             softWrap: true,
  //                             maxLines: 1,
  //                             style: TextStyle(
  //                               color: emailcolor,
  //                               fontSize: emailsize.toDouble(),
  //                               fontFamily: emailfont != null
  //                                   ? emailfont['font']
  //                                   : null,
  //                             ),
  //                           ),
  //                           FittedBox(
  //                             child: Text(
  //                               'तालुका अध्यक्ष: तालुक्याचे नाव',
  //                               textAlign: TextAlign.center,
  //                               maxLines: 1,
  //                               style: TextStyle(
  //                                 color: emailcolor,
  //                                 fontSize: emailsize.toDouble(),
  //                                 fontFamily: emailfont != null
  //                                     ? emailfont['font']
  //                                     : null,
  //                               ),
  //                             ),
  //                           )
  //                         ],
  //                       ),
  //                     ),
  //                   ),
  //                   const Expanded(flex: 4, child: SizedBox()),
  //                   const Expanded(child: SizedBox(width: 10)),
  //                 ],
  //               ),
  //             )),
  //       ]));
  // }
  // if (frameno == 7) {
  //   var height = MediaQuery.of(context).size.width / 4.37;
  //   var width = MediaQuery.of(context).size.width * 0.93;
  //   return SizedBox(
  //       width: width,
  //       height: height,
  //       child: Stack(children: <Widget>[
  //         Positioned(
  //             bottom: 0,
  //             left: 0,
  //             child: Container(
  //                 width: width,
  //                 height: height / 1.4,
  //                 decoration: const BoxDecoration(
  //                   image: DecorationImage(
  //                       image: AssetImage('assets/festivalframe/festival7.png'),
  //                       fit: BoxFit.fitWidth),
  //                 ))),
  //         Positioned(
  //             top: height / 2.5,
  //             left: width / 14.6,
  //             child: Container(
  //                 width: width / 8.1,
  //                 height: width / 8.1,
  //                 decoration: BoxDecoration(
  //                   borderRadius: BorderRadius.circular(width / 13),
  //                   image: DecorationImage(
  //                       image: profileuploadedimage != null
  //                           ? FileImage(profileuploadedimage)
  //                           : CachedNetworkImageProvider(
  //                               profilevalue == null
  //                                   ? url
  //                                   : "$weburl/${profilevalue["profile_img"]}",
  //                             ).image,
  //                       fit: BoxFit.cover),
  //                 ))),
  //         Positioned(
  //             top: height / 5,
  //             left: width / 5.5,
  //             child: SizedBox(
  //               height: height - height / 10,
  //               width: width / 1.3,
  //               child: Row(
  //                 mainAxisAlignment: MainAxisAlignment.spaceAround,
  //                 children: [
  //                   const Expanded(flex: 3, child: SizedBox()),
  //                   Expanded(
  //                     flex: 9,
  //                     child: FittedBox(
  //                       fit: BoxFit.fill,
  //                       child: Column(
  //                         mainAxisAlignment: MainAxisAlignment.center,
  //                         crossAxisAlignment: CrossAxisAlignment.center,
  //                         children: [
  //                           Text(
  //                             profilevalue == null
  //                                 ? 'शुभेच्छुक: शुभम खत्री'
  //                                 : "शुभेच्छुक: ${profilevalue['name']}",
  //                             softWrap: true,
  //                             maxLines: 1,
  //                             style: TextStyle(
  //                               color: emailcolor,
  //                               fontSize: emailsize.toDouble(),
  //                               fontFamily: emailfont != null
  //                                   ? emailfont['font']
  //                                   : null,
  //                             ),
  //                           ),
  //                           FittedBox(
  //                             child: Text(
  //                               'तालुका अध्यक्ष: तालुक्याचे नाव',
  //                               textAlign: TextAlign.center,
  //                               maxLines: 1,
  //                               style: TextStyle(
  //                                 color: emailcolor,
  //                                 fontSize: emailsize.toDouble(),
  //                                 fontFamily: emailfont != null
  //                                     ? emailfont['font']
  //                                     : null,
  //                               ),
  //                             ),
  //                           )
  //                         ],
  //                       ),
  //                     ),
  //                   ),
  //                   const Expanded(child: SizedBox(width: 10)),
  //                 ],
  //               ),
  //             )),
  //       ]));
  // }
  // if (frameno == 8) {
  //   var height = MediaQuery.of(context).size.width / 4.37;
  //   var width = MediaQuery.of(context).size.width * 0.93;
  //   return SizedBox(
  //       width: width,
  //       height: height,
  //       child: Stack(children: <Widget>[
  //         Positioned(
  //             bottom: 0,
  //             left: 0,
  //             child: Container(
  //                 width: width,
  //                 height: height / 1.4,
  //                 decoration: const BoxDecoration(
  //                   image: DecorationImage(
  //                       image: AssetImage('assets/festivalframe/festival8.png'),
  //                       fit: BoxFit.fitWidth),
  //                 ))),
  //         Positioned(
  //             top: height / 2.5,
  //             left: width / 14.6,
  //             child: Container(
  //                 width: width / 8.1,
  //                 height: width / 8.1,
  //                 decoration: BoxDecoration(
  //                   borderRadius: BorderRadius.circular(width / 13),
  //                   image: DecorationImage(
  //                       image: profileuploadedimage != null
  //                           ? FileImage(profileuploadedimage)
  //                           : CachedNetworkImageProvider(
  //                               profilevalue == null
  //                                   ? url
  //                                   : "$weburl/${profilevalue["profile_img"]}",
  //                             ).image,
  //                       fit: BoxFit.cover),
  //                 ))),
  //         Positioned(
  //             top: height / 5,
  //             left: width / 7,
  //             child: SizedBox(
  //               height: height - height / 10,
  //               width: width / 1.3,
  //               child: Row(
  //                 mainAxisAlignment: MainAxisAlignment.spaceAround,
  //                 children: [
  //                   const Expanded(flex: 3, child: SizedBox()),
  //                   Expanded(
  //                     flex: 9,
  //                     child: FittedBox(
  //                       fit: BoxFit.fill,
  //                       child: Column(
  //                         mainAxisAlignment: MainAxisAlignment.center,
  //                         crossAxisAlignment: CrossAxisAlignment.center,
  //                         children: [
  //                           Text(
  //                             profilevalue == null
  //                                 ? 'शुभेच्छुक: शुभम खत्री'
  //                                 : "शुभेच्छुक: ${profilevalue['name']}",
  //                             softWrap: true,
  //                             maxLines: 1,
  //                             style: TextStyle(
  //                               color: emailcolor,
  //                               fontSize: emailsize.toDouble(),
  //                               fontFamily: emailfont != null
  //                                   ? emailfont['font']
  //                                   : null,
  //                             ),
  //                           ),
  //                           FittedBox(
  //                             child: Text(
  //                               'तालुका अध्यक्ष: तालुक्याचे नाव',
  //                               textAlign: TextAlign.center,
  //                               maxLines: 1,
  //                               style: TextStyle(
  //                                 color: emailcolor,
  //                                 fontSize: emailsize.toDouble(),
  //                                 fontFamily: emailfont != null
  //                                     ? emailfont['font']
  //                                     : null,
  //                               ),
  //                             ),
  //                           )
  //                         ],
  //                       ),
  //                     ),
  //                   ),
  //                   const Expanded(flex: 2, child: SizedBox()),
  //                   const Expanded(child: SizedBox(width: 10)),
  //                 ],
  //               ),
  //             )),
  //       ]));
  // }
  // if (frameno == 9) {
  //   var height = MediaQuery.of(context).size.width / 4.37;
  //   var width = MediaQuery.of(context).size.width * 0.93;
  //   return SizedBox(
  //       width: width,
  //       height: height,
  //       child: Stack(children: <Widget>[
  //         Positioned(
  //             bottom: 0,
  //             left: 0,
  //             child: Container(
  //                 width: width,
  //                 height: height,
  //                 decoration: const BoxDecoration(
  //                   image: DecorationImage(
  //                       image: AssetImage('assets/festivalframe/festival9.png'),
  //                       fit: BoxFit.fitWidth),
  //                 ))),
  //         Positioned(
  //             top: height / 10.6,
  //             left: width / 15.5,
  //             child: Container(
  //                 width: width / 5.9,
  //                 height: width / 5.9,
  //                 decoration: BoxDecoration(
  //                   borderRadius: BorderRadius.circular(width / 13),
  //                   image: DecorationImage(
  //                       image: profileuploadedimage != null
  //                           ? FileImage(profileuploadedimage)
  //                           : CachedNetworkImageProvider(
  //                               profilevalue == null
  //                                   ? url
  //                                   : "$weburl/${profilevalue["profile_img"]}",
  //                             ).image,
  //                       fit: BoxFit.cover),
  //                 ))),
  //         Positioned(
  //             top: height / 5.2,
  //             left: width / 7,
  //             child: SizedBox(
  //               height: height - height / 10,
  //               width: width / 1.3,
  //               child: Row(
  //                 mainAxisAlignment: MainAxisAlignment.spaceAround,
  //                 children: [
  //                   const Expanded(flex: 3, child: SizedBox()),
  //                   Expanded(
  //                     flex: 9,
  //                     child: FittedBox(
  //                       fit: BoxFit.fill,
  //                       child: Column(
  //                         mainAxisAlignment: MainAxisAlignment.center,
  //                         crossAxisAlignment: CrossAxisAlignment.center,
  //                         children: [
  //                           Text(
  //                             profilevalue == null
  //                                 ? 'शुभेच्छुक: शुभम खत्री'
  //                                 : "शुभेच्छुक: ${profilevalue['name']}",
  //                             softWrap: true,
  //                             maxLines: 1,
  //                             style: TextStyle(
  //                               color: emailcolor,
  //                               fontSize: emailsize.toDouble(),
  //                               fontFamily: emailfont != null
  //                                   ? emailfont['font']
  //                                   : null,
  //                             ),
  //                           ),
  //                           FittedBox(
  //                             child: Text(
  //                               'तालुका अध्यक्ष: तालुक्याचे नाव',
  //                               textAlign: TextAlign.center,
  //                               maxLines: 1,
  //                               style: TextStyle(
  //                                 color: emailcolor,
  //                                 fontSize: emailsize.toDouble(),
  //                                 fontFamily: emailfont != null
  //                                     ? emailfont['font']
  //                                     : null,
  //                               ),
  //                             ),
  //                           )
  //                         ],
  //                       ),
  //                     ),
  //                   ),
  //                   const Expanded(flex: 2, child: SizedBox()),
  //                   const Expanded(child: SizedBox(width: 10)),
  //                 ],
  //               ),
  //             )),
  //       ]));
  // }
  // if (frameno == 10) {
  //   var height = MediaQuery.of(context).size.width / 13;
  //   var width = MediaQuery.of(context).size.width * 0.93;
  //   return SizedBox(
  //       width: width,
  //       height: height,
  //       child: Stack(children: <Widget>[
  //         Positioned(
  //             bottom: 0,
  //             left: 0,
  //             child: Container(
  //                 width: width,
  //                 height: height,
  //                 decoration: const BoxDecoration(
  //                   image: DecorationImage(
  //                       image:
  //                           AssetImage('assets/festivalframe/festival10.png'),
  //                       fit: BoxFit.fitWidth),
  //                 ))),
  //         Positioned(
  //             top: height / 20,
  //             child: SizedBox(
  //               height: height - height / 10,
  //               width: width,
  //               child: Padding(
  //                 padding: const EdgeInsets.all(3.0),
  //                 child: Row(
  //                   mainAxisAlignment: MainAxisAlignment.spaceAround,
  //                   children: [
  //                     Expanded(
  //                       flex: 4,
  //                       child: FittedBox(
  //                         fit: BoxFit.fill,
  //                         child: Row(
  //                           mainAxisAlignment: MainAxisAlignment.spaceAround,
  //                           crossAxisAlignment: CrossAxisAlignment.center,
  //                           children: [
  //                             Text(
  //                               profilevalue == null
  //                                   ? 'Mauli computers & multi Service'
  //                                   : profilevalue['name'],
  //                               softWrap: true,
  //                               maxLines: 1,
  //                               style: TextStyle(
  //                                 color: emailcolor,
  //                                 fontSize: emailsize.toDouble(),
  //                                 fontFamily: emailfont != null
  //                                     ? emailfont['font']
  //                                     : null,
  //                               ),
  //                             ),
  //                           ],
  //                         ),
  //                       ),
  //                     ),
  //                     const SizedBox(width: 7),
  //                     Expanded(
  //                       flex: 4,
  //                       child: FittedBox(
  //                         child: Row(
  //                           children: [
  //                             CircleAvatar(
  //                                 radius: 8,
  //                                 backgroundColor: emailcolor,
  //                                 child: Icon(
  //                                   Icons.location_on,
  //                                   size: 15,
  //                                   color: whitecolor,
  //                                 )),
  //                             const SizedBox(width: 5),
  //                             Text(
  //                               'Near SBI Bank,Keshav Nagar',
  //                               maxLines: 1,
  //                               style: TextStyle(
  //                                 color: emailcolor,
  //                                 fontSize: emailsize.toDouble(),
  //                                 fontFamily: emailfont != null
  //                                     ? emailfont['font']
  //                                     : null,
  //                               ),
  //                             ),
  //                           ],
  //                         ),
  //                       ),
  //                     ),
  //                     const SizedBox(width: 7),
  //                     Expanded(
  //                       flex: 2,
  //                       child: FittedBox(
  //                         fit: BoxFit.fill,
  //                         child: Column(
  //                           children: [
  //                             Row(
  //                               children: [
  //                                 CircleAvatar(
  //                                     radius: 8,
  //                                     backgroundColor: emailcolor,
  //                                     child: Icon(
  //                                       Icons.call,
  //                                       size: 15,
  //                                       color: whitecolor,
  //                                     )),
  //                                 const SizedBox(width: 5),
  //                                 Text(
  //                                   profilevalue == null
  //                                       ? '1234567890'
  //                                       : profilevalue['mobileno'],
  //                                   style: TextStyle(
  //                                     color: emailcolor,
  //                                     fontSize: emailsize.toDouble(),
  //                                     fontFamily: emailfont != null
  //                                         ? emailfont['font']
  //                                         : null,
  //                                   ),
  //                                 ),
  //                               ],
  //                             ),
  //                             Row(
  //                               children: [
  //                                 CircleAvatar(
  //                                   radius: 8,
  //                                   backgroundColor: emailcolor,
  //                                   child: CachedNetworkImageProvider(
  //                                     "https://img.icons8.com/color/512/whatsapp--v1.png",
  //                                     width: 35,
  //                                   ),
  //                                 ),
  //                                 const SizedBox(width: 5),
  //                                 Text(
  //                                   profilevalue == null
  //                                       ? '1234567890'
  //                                       : profilevalue['whatsapp_num'] ??
  //                                           '1234567890',
  //                                   style: TextStyle(
  //                                     color: emailcolor,
  //                                     fontSize: emailsize.toDouble(),
  //                                     fontFamily: emailfont != null
  //                                         ? emailfont['font']
  //                                         : null,
  //                                   ),
  //                                 ),
  //                               ],
  //                             ),
  //                           ],
  //                         ),
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //             )),
  //       ]));
  // }
  // if (frameno == 11) {
  //   var height = MediaQuery.of(context).size.width / 13;
  //   var width = MediaQuery.of(context).size.width * 0.93;
  //   return SizedBox(
  //       width: width,
  //       height: height,
  //       child: Stack(children: <Widget>[
  //         Positioned(
  //             bottom: 0,
  //             left: 0,
  //             child: Container(
  //                 width: width,
  //                 height: height,
  //                 decoration: const BoxDecoration(
  //                   image: DecorationImage(
  //                       image:
  //                           AssetImage('assets/festivalframe/festival12.png'),
  //                       fit: BoxFit.fitWidth),
  //                 ))),
  //         Positioned(
  //             top: height / 20,
  //             child: SizedBox(
  //               height: height - height / 10,
  //               width: width,
  //               child: Padding(
  //                 padding: const EdgeInsets.all(3.0),
  //                 child: Row(
  //                   mainAxisAlignment: MainAxisAlignment.spaceAround,
  //                   children: [
  //                     Expanded(
  //                       flex: 4,
  //                       child: FittedBox(
  //                         fit: BoxFit.fill,
  //                         child: Row(
  //                           mainAxisAlignment: MainAxisAlignment.spaceAround,
  //                           crossAxisAlignment: CrossAxisAlignment.center,
  //                           children: [
  //                             Text(
  //                               profilevalue == null
  //                                   ? 'Mauli computers & multi Service'
  //                                   : profilevalue['name'],
  //                               softWrap: true,
  //                               maxLines: 1,
  //                               style: TextStyle(
  //                                 color: emailcolor,
  //                                 fontSize: emailsize.toDouble(),
  //                                 fontFamily: emailfont != null
  //                                     ? emailfont['font']
  //                                     : null,
  //                               ),
  //                             ),
  //                           ],
  //                         ),
  //                       ),
  //                     ),
  //                     const SizedBox(width: 20),
  //                     Expanded(
  //                       flex: 4,
  //                       child: FittedBox(
  //                         child: Row(
  //                           children: [
  //                             CircleAvatar(
  //                                 radius: 8,
  //                                 backgroundColor: emailcolor,
  //                                 child: Icon(
  //                                   Icons.location_on,
  //                                   size: 15,
  //                                   color: whitecolor,
  //                                 )),
  //                             const SizedBox(width: 5),
  //                             Text(
  //                               'Near SBI Bank,Keshav Nagar',
  //                               maxLines: 1,
  //                               style: TextStyle(
  //                                 color: emailcolor,
  //                                 fontSize: emailsize.toDouble(),
  //                                 fontFamily: emailfont != null
  //                                     ? emailfont['font']
  //                                     : null,
  //                               ),
  //                             ),
  //                           ],
  //                         ),
  //                       ),
  //                     ),
  //                     const SizedBox(width: 20),
  //                     Expanded(
  //                       flex: 2,
  //                       child: FittedBox(
  //                         fit: BoxFit.fill,
  //                         child: Column(
  //                           children: [
  //                             Row(
  //                               children: [
  //                                 CircleAvatar(
  //                                     radius: 8,
  //                                     backgroundColor: emailcolor,
  //                                     child: Icon(
  //                                       Icons.call,
  //                                       size: 15,
  //                                       color: whitecolor,
  //                                     )),
  //                                 const SizedBox(width: 5),
  //                                 Text(
  //                                   profilevalue == null
  //                                       ? '1234567890'
  //                                       : profilevalue['mobileno'],
  //                                   style: TextStyle(
  //                                     color: emailcolor,
  //                                     fontSize: emailsize.toDouble(),
  //                                     fontFamily: emailfont != null
  //                                         ? emailfont['font']
  //                                         : null,
  //                                   ),
  //                                 ),
  //                               ],
  //                             ),
  //                             Row(
  //                               children: [
  //                                 CircleAvatar(
  //                                   radius: 8,
  //                                   backgroundColor: emailcolor,
  //                                   child: CachedNetworkImageProvider(
  //                                     "https://img.icons8.com/color/512/whatsapp--v1.png",
  //                                     width: 35,
  //                                   ),
  //                                 ),
  //                                 const SizedBox(width: 5),
  //                                 Text(
  //                                   profilevalue == null
  //                                       ? '1234567890'
  //                                       : profilevalue['whatsapp_num'] ??
  //                                           '1234567890',
  //                                   style: TextStyle(
  //                                     color: emailcolor,
  //                                     fontSize: emailsize.toDouble(),
  //                                     fontFamily: emailfont != null
  //                                         ? emailfont['font']
  //                                         : null,
  //                                   ),
  //                                 ),
  //                               ],
  //                             ),
  //                           ],
  //                         ),
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //             )),
  //       ]));
  // }
  // if (frameno == 12) {
  //   var height = MediaQuery.of(context).size.width / 13;
  //   var width = MediaQuery.of(context).size.width * 0.93;
  //   return SizedBox(
  //       width: width,
  //       height: height,
  //       child: Stack(children: <Widget>[
  //         Positioned(
  //             bottom: 0,
  //             left: 0,
  //             child: Container(
  //                 width: width,
  //                 height: height,
  //                 decoration: const BoxDecoration(
  //                   image: DecorationImage(
  //                       image:
  //                           AssetImage('assets/festivalframe/festival11.png'),
  //                       fit: BoxFit.fitWidth),
  //                 ))),
  //         Positioned(
  //             top: height / 20,
  //             child: SizedBox(
  //               height: height - height / 10,
  //               width: width,
  //               child: Padding(
  //                 padding: const EdgeInsets.all(3.0),
  //                 child: Row(
  //                   mainAxisAlignment: MainAxisAlignment.spaceAround,
  //                   children: [
  //                     Expanded(
  //                       flex: 4,
  //                       child: FittedBox(
  //                         fit: BoxFit.fill,
  //                         child: Row(
  //                           mainAxisAlignment: MainAxisAlignment.spaceAround,
  //                           crossAxisAlignment: CrossAxisAlignment.center,
  //                           children: [
  //                             Text(
  //                               profilevalue == null
  //                                   ? 'Mauli computers & multi Service'
  //                                   : profilevalue['name'],
  //                               softWrap: true,
  //                               maxLines: 1,
  //                               style: TextStyle(
  //                                 color: emailcolor,
  //                                 fontSize: emailsize.toDouble(),
  //                                 fontFamily: emailfont != null
  //                                     ? emailfont['font']
  //                                     : null,
  //                               ),
  //                             ),
  //                           ],
  //                         ),
  //                       ),
  //                     ),
  //                     const SizedBox(width: 20),
  //                     Expanded(
  //                       flex: 4,
  //                       child: FittedBox(
  //                         child: Row(
  //                           children: [
  //                             CircleAvatar(
  //                                 radius: 8,
  //                                 backgroundColor: emailcolor,
  //                                 child: Icon(
  //                                   Icons.location_on,
  //                                   size: 15,
  //                                   color: whitecolor,
  //                                 )),
  //                             const SizedBox(width: 5),
  //                             Text(
  //                               'Near SBI Bank,Keshav Nagar',
  //                               maxLines: 1,
  //                               style: TextStyle(
  //                                 color: emailcolor,
  //                                 fontSize: emailsize.toDouble(),
  //                                 fontFamily: emailfont != null
  //                                     ? emailfont['font']
  //                                     : null,
  //                               ),
  //                             ),
  //                           ],
  //                         ),
  //                       ),
  //                     ),
  //                     const SizedBox(width: 20),
  //                     Expanded(
  //                       flex: 2,
  //                       child: FittedBox(
  //                         fit: BoxFit.fill,
  //                         child: Column(
  //                           children: [
  //                             Row(
  //                               children: [
  //                                 CircleAvatar(
  //                                     radius: 8,
  //                                     backgroundColor: emailcolor,
  //                                     child: Icon(
  //                                       Icons.call,
  //                                       size: 15,
  //                                       color: whitecolor,
  //                                     )),
  //                                 const SizedBox(width: 5),
  //                                 Text(
  //                                   profilevalue == null
  //                                       ? '1234567890'
  //                                       : profilevalue['mobileno'],
  //                                   style: TextStyle(
  //                                     color: emailcolor,
  //                                     fontSize: emailsize.toDouble(),
  //                                     fontFamily: emailfont != null
  //                                         ? emailfont['font']
  //                                         : null,
  //                                   ),
  //                                 ),
  //                               ],
  //                             ),
  //                             Row(
  //                               children: [
  //                                 CircleAvatar(
  //                                   radius: 8,
  //                                   backgroundColor: emailcolor,
  //                                   child: CachedNetworkImageProvider(
  //                                     "https://img.icons8.com/color/512/whatsapp--v1.png",
  //                                     width: 35,
  //                                   ),
  //                                 ),
  //                                 const SizedBox(width: 5),
  //                                 Text(
  //                                   profilevalue == null
  //                                       ? '1234567890'
  //                                       : profilevalue['whatsapp_num'] ??
  //                                           '1234567890',
  //                                   style: TextStyle(
  //                                     color: emailcolor,
  //                                     fontSize: emailsize.toDouble(),
  //                                     fontFamily: emailfont != null
  //                                         ? emailfont['font']
  //                                         : null,
  //                                   ),
  //                                 ),
  //                               ],
  //                             ),
  //                           ],
  //                         ),
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //             )),
  //       ]));
  // }
  // if (frameno == 20) {
  //   return Container(
  //     height: height,
  //     alignment: Alignment.bottomCenter,
  //     child: Stack(
  //       clipBehavior: Clip.none,
  //       children: [
  //         ClipPath(
  //           clipper: MyWaveClipper6(),
  //           child: Container(
  //             color: Colors.yellow,
  //             height: height,
  //             width: width,
  //             child: Row(
  //               crossAxisAlignment: CrossAxisAlignment.end,
  //               children: [
  //                 // profilevalue["festival_logo"] == null || logoenable == false
  //                 //     ? SizedBox.shrink()
  //                 //     : Expanded(
  //                 //         flex: double.parse(
  //                 //                 "${logosize * 2 / (width / 20).toInt()}")
  //                 //             .toInt(),
  //                 //         child: Container()),
  //                 Expanded(
  //                   flex: 8,
  //                   child: Container(
  //                     height: height / 2,
  //                     child: FittedBox(
  //                       child: Column(
  //                         children: [
  //                           profilevalue["name"] == null || nameenable == false
  //                               ? SizedBox.shrink()
  //                               : Text(
  //                                   profilevalue == null
  //                                       ? 'शुभेच्छुक: शुभम खत्री'
  //                                       : "${profilevalue['name']}",
  //                                   softWrap: true,
  //                                   style: TextStyle(
  //                                     color: namecolor,
  //                                     fontSize: namesize.toDouble(),
  //                                     fontFamily: namefont != null
  //                                         ? namefont['font']
  //                                         : "Poppins-SemiBold",
  //                                   ),
  //                                 ),
  //                           profilevalue["designation"] == null ||
  //                                   designationenable == false
  //                               ? SizedBox.shrink()
  //                               : Text(
  //                                   profilevalue['designation'],
  //                                   textAlign: TextAlign.center,
  //                                   style: TextStyle(
  //                                     color: designationcolor,
  //                                     fontSize: designationsize.toDouble(),
  //                                     fontFamily: designationfont != null
  //                                         ? designationfont['font']
  //                                         : null,
  //                                   ),
  //                                 ),
  //                         ],
  //                       ),
  //                     ),
  //                   ),
  //                 ),
  //                 (profilevalue["profile_img"] == null ||
  //                             profileenable == false) &&
  //                         (profileuploadedimage == null ||
  //                             profileenable == false)
  //                     ? SizedBox.shrink()
  //                     : Expanded(
  //                         flex: double.parse(
  //                                 "${profilesize / (width / 25).toInt()}")
  //                             .toInt(),
  //                         child: Container()),
  //               ],
  //             ),
  //           ),
  //         ),
  //         // profilevalue["festival_logo"] == null || logoenable == false
  //         //     ? SizedBox.shrink()
  //         //     : Positioned(
  //         //         bottom: 15,
  //         //         left: 0,
  //         //         child: Padding(
  //         //           padding: const EdgeInsets.all(10.0),
  //         //           child: Container(
  //         //             height: logosize * 1.5,
  //         //             width: logosize * 1.5,
  //         //             decoration: BoxDecoration(
  //         //                 borderRadius: BorderRadius.circular(logosize / 2),
  //         //                 image: DecorationImage(
  //         //                     image: CachedNetworkImageProvider(
  //         //                             profilevalue == null
  //         //                                 ? url
  //         //                                 : "$weburl/${profilevalue["festival_logo"]}",
  //         //                             fit: BoxFit.fitWidth)
  //         //                         .image)),
  //         //           ),
  //         //         ),
  //         //       ),
  //         (profilevalue["profile_img"] == null || profileenable == false) &&
  //                 (profileuploadedimage == null || profileenable == false)
  //             ? SizedBox.shrink()
  //             : Positioned(
  //                 right: 0,
  //                 bottom: 0,
  //                 child: Container(
  //                   width: profilesize,
  //                   height: profilesize,
  //                   child: profileuploadedimage != null
  //                       ? Image.file(profileuploadedimage)
  //                       : CachedNetworkImageProvider(
  //                           "$weburl/${profilevalue["profile_img"]}",
  //                           fit: BoxFit.fitWidth),
  //                 ),
  //               ),
  //       ],
  //     ),
  //   );
  // }
}
