import 'package:cached_network_image/cached_network_image.dart';
import 'package:click/utils/constants.dart';
import 'package:click/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

getdefaultframe(
  BuildContext context, {
  var frameno,
  var profilevalue,
  var profileenable,
  var profilesize,
  var profileuploadedimage,
  var logoenable,
  var logosize,
  var numberenable,
  var numbersize,
  var numberfont,
  var numbercolor,
  var nameenable,
  var namesize,
  var namefont,
  var namecolor,
  var whatsappnumberenable,
  var whatsappnumbersize,
  var whatsappnumberfont,
  var whatsappnumbercolor,
  var emailenable,
  var emailsize,
  var emailfont,
  var emailcolor,
  var addressenable,
  var addresssize,
  var addressfont,
  var addresscolor,
}) {
  var height = MediaQuery.of(context).size.width / 3.5;
  var width = MediaQuery.of(context).size.width * 0.93;
  var logo = profilevalue['users_logo'] == null ? 'csc_logo' : 'users_logo';
  if (frameno == 1) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: IntrinsicHeight(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            (profilevalue["profile_img"] == null || profileenable == false) &&
                    (profileuploadedimage == null || profileenable == false)
                ? profileenable == false
                    ? SizedBox.shrink()
                    : Padding(
                        padding: const EdgeInsets.only(left: 5.0),
                        child: CircleAvatar(
                          radius: profilesize - 30,
                          backgroundImage: Image.asset(
                            "assets/dfp1.png",
                          ).image,
                        ),
                      )
                : Padding(
                    padding: const EdgeInsets.only(left: 5.0),
                    child: CircleAvatar(
                      radius: profilesize - 30,
                      backgroundImage: profileuploadedimage != null
                          ? Image.file(profileuploadedimage).image
                          : CachedNetworkImageProvider(
                              profilevalue == null
                                  ? url
                                  : "$weburl/${profilevalue["profile_img"]}",
                            ),
                    ),
                  ),
            profileenable == false
                ? SizedBox.shrink()
                : VerticalDivider(
                    color: Color(0xff00165d),
                    thickness: .6,
                  ),
            Expanded(
              child: IntrinsicWidth(
                child: Padding(
                  padding: const EdgeInsets.only(right: 8.0, left: 8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      profilevalue['name'] == null || nameenable == false
                          ? SizedBox.shrink()
                          : RichText(
                              maxLines: 10,
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: "${profilevalue['name']}",
                                    style: TextStyle(
                                      color: namecolor,
                                      fontSize: namesize.toDouble(),
                                      fontFamily: namefont != null
                                          ? namefont['font']
                                          : "Poppins-SemiBold",
                                    ),
                                  ),
                                ],
                              ),
                            ),
                      addressenable == false || profilevalue['address'] == null
                          ? SizedBox.shrink()
                          : Column(
                              children: [
                                h(3),
                                RichText(
                                  textAlign: TextAlign.justify,
                                  maxLines: 10,
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: profilevalue['address'],
                                        style: TextStyle(
                                          color: addresscolor ?? blackcolor,
                                          fontSize: addresssize.toDouble(),
                                          fontFamily: addressfont != null
                                              ? addressfont['font']
                                              : "Poppins-SemiBold",
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                      numberenable == false || profilevalue['mobileno'] == null
                          ? SizedBox.shrink()
                          : Column(
                              children: [
                                h(3),
                                Padding(
                                  padding: const EdgeInsets.only(right: 20.0),
                                  child: Divider(
                                    height: 2,
                                    thickness: .6,
                                    color: Color(0xff00165d),
                                  ),
                                ),
                              ],
                            ),
                      numberenable == false || profilevalue['mobileno'] == null
                          ? SizedBox.shrink()
                          : Column(
                              children: [
                                h(3),
                                RichText(
                                  maxLines: 10,
                                  text: TextSpan(children: [
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
                                            size: numbersize - 2,
                                            color: whitecolor,
                                          ),
                                        ),
                                      ),
                                    ),
                                    WidgetSpan(child: w(5)),
                                    TextSpan(
                                      text: profilevalue == null
                                          ? '1234567890'
                                          : profilevalue['mobileno'],
                                      style: TextStyle(
                                        color: numbercolor ?? blackcolor,
                                        fontSize: numbersize.toDouble() ?? 12.0,
                                        fontFamily: numberfont != null
                                            ? numberfont['font']
                                            : "Poppins-SemiBold",
                                      ),
                                    ),
                                  ]),
                                ),
                              ],
                            ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  // if (frameno == 1) {
  //   return Stack(
  //     clipBehavior: Clip.none,
  //     children: [
  //       Row(
  //         children: [
  //           Container(
  //             width: width / 50,
  //             decoration: BoxDecoration(
  //                 color: greyshade400,
  //                 borderRadius: BorderRadius.only(
  //                     topRight: Radius.circular(5),
  //                     bottomRight: Radius.circular(5))),
  //           ),
  //           Expanded(
  //             flex: 10,
  //             child: Padding(
  //               padding:
  //                   const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2),
  //               child: Column(
  //                 mainAxisAlignment: MainAxisAlignment.spaceAround,
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 children: [
  //                   profilevalue['name'] == null || nameenable == false
  //                       ? SizedBox.shrink()
  //                       : RichText(
  //                           maxLines: 10,
  //                           text: TextSpan(
  //                             children: [
  //                               TextSpan(
  //                                 text: "${profilevalue['name']}",
  //                                 style: TextStyle(
  //                                   color: namecolor,
  //                                   fontSize: namesize.toDouble(),
  //                                   fontFamily: namefont != null
  //                                       ? namefont['font']
  //                                       : "Poppins-SemiBold",
  //                                 ),
  //                               ),
  //                             ],
  //                           ),
  //                         ),
  //                   numberenable == false || profilevalue['mobileno'] == null
  //                       ? SizedBox.shrink()
  //                       : Column(
  //                           children: [
  //                             h(3),
  //                             RichText(
  //                               maxLines: 10,
  //                               text: TextSpan(children: [
  //                                 WidgetSpan(
  //                                   child: Container(
  //                                     decoration: BoxDecoration(
  //                                         color: blackcolor,
  //                                         borderRadius:
  //                                             BorderRadius.circular(3)),
  //                                     child: Padding(
  //                                       padding: const EdgeInsets.all(2.0),
  //                                       child: Icon(
  //                                         Icons.call,
  //                                         size: numbersize - 2,
  //                                         color: whitecolor,
  //                                       ),
  //                                     ),
  //                                   ),
  //                                 ),
  //                                 WidgetSpan(child: w(5)),
  //                                 TextSpan(
  //                                   text: profilevalue == null
  //                                       ? '1234567890'
  //                                       : profilevalue['mobileno'],
  //                                   style: TextStyle(
  //                                     color: numbercolor ?? blackcolor,
  //                                     fontSize: numbersize.toDouble() ?? 12.0,
  //                                     fontFamily: numberfont != null
  //                                         ? numberfont['font']
  //                                         : "Poppins-SemiBold",
  //                                   ),
  //                                 ),
  //                               ]),
  //                             ),
  //                           ],
  //                         ),
  //                   emailenable == false || profilevalue['email'] == null
  //                       ? SizedBox.shrink()
  //                       : Column(
  //                           children: [
  //                             h(3),
  //                             RichText(
  //                               maxLines: 10,
  //                               text: TextSpan(children: [
  //                                 WidgetSpan(
  //                                   child: Container(
  //                                     decoration: BoxDecoration(
  //                                         color: blackcolor,
  //                                         borderRadius:
  //                                             BorderRadius.circular(3)),
  //                                     child: Padding(
  //                                       padding: const EdgeInsets.all(2.0),
  //                                       child: Icon(
  //                                         Icons.email_sharp,
  //                                         size: emailsize,
  //                                         color: whitecolor,
  //                                       ),
  //                                     ),
  //                                   ),
  //                                 ),
  //                                 WidgetSpan(child: w(5)),
  //                                 TextSpan(
  //                                   text: profilevalue['email'],
  //                                   style: TextStyle(
  //                                     color: emailcolor ?? blackcolor,
  //                                     fontSize: emailsize.toDouble(),
  //                                     fontFamily: emailfont != null
  //                                         ? emailfont['font']
  //                                         : "Poppins-SemiBold",
  //                                   ),
  //                                 ),
  //                               ]),
  //                             ),
  //                           ],
  //                         ),
  //                   addressenable == false || profilevalue['address'] == null
  //                       ? SizedBox.shrink()
  //                       : Column(
  //                           children: [
  //                             h(3),
  //                             RichText(
  //                               textAlign: TextAlign.justify,
  //                               maxLines: 10,
  //                               text: TextSpan(
  //                                 children: [
  //                                   TextSpan(
  //                                     text: profilevalue['address'],
  //                                     style: TextStyle(
  //                                       color: addresscolor ?? blackcolor,
  //                                       fontSize: addresssize.toDouble(),
  //                                       fontFamily: addressfont != null
  //                                           ? addressfont['font']
  //                                           : null,
  //                                     ),
  //                                   ),
  //                                 ],
  //                               ),
  //                             ),
  //                           ],
  //                         ),
  //                 ],
  //               ),
  //             ),
  //           ),
  //           (profilevalue["$logo"] == null || logoenable == false) &&
  //                   (profileuploadedimage == null || logoenable == false)
  //               ? logoenable == false
  //                   ? SizedBox.shrink()
  //                   : Padding(
  //                       padding: const EdgeInsets.only(right: 5.0),
  //                       child: Container(
  //                           width: logosize,
  //                           height: logosize,
  //                           decoration: BoxDecoration(
  //                             image: DecorationImage(
  //                                 image: Image.asset(
  //                                   "assets/instapost.png",
  //                                 ).image,
  //                                 fit: BoxFit.fitWidth),
  //                           )),
  //                     )
  //               : Padding(
  //                   padding: const EdgeInsets.only(right: 5.0),
  //                   child: Container(
  //                       width: logosize,
  //                       height: logosize,
  //                       decoration: BoxDecoration(
  //                         image: DecorationImage(
  //                             image: CachedNetworkImageProvider(
  //                               profilevalue == null
  //                                   ? url
  //                                   : "$weburl/${profilevalue["$logo"]}",
  //                             ).image,
  //                             fit: BoxFit.fill),
  //                       )),
  //                 ),
  //           Container(
  //             width: width / 50,
  //             decoration: BoxDecoration(
  //                 color: greyshade400,
  //                 borderRadius: BorderRadius.only(
  //                     topLeft: Radius.circular(5),
  //                     bottomLeft: Radius.circular(5))),
  //           ),
  //         ],
  //       ),
  //     ],
  //   );
  // }
  if (frameno == 2) {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          (profilevalue["$logo"] == null || logoenable == false) &&
                  (profileuploadedimage == null || logoenable == false)
              ? logoenable == false
                  ? SizedBox.shrink()
                  : Padding(
                      padding: const EdgeInsets.only(left: 5.0),
                      child: Container(
                          width: logosize,
                          height: logosize,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: Image.asset(
                                  "assets/instapost.png",
                                ).image,
                                fit: BoxFit.fitWidth),
                          )),
                    )
              : Padding(
                  padding: const EdgeInsets.only(left: 5.0),
                  child: Container(
                      width: logosize,
                      height: logosize,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: CachedNetworkImageProvider(
                              profilevalue == null
                                  ? url
                                  : "$weburl/${profilevalue["$logo"]}",
                            ),
                            fit: BoxFit.fitWidth),
                      )),
                ),
          w(10),
          Expanded(
            flex: 11,
            child: IntrinsicWidth(
              child: Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    profilevalue['name'] == null || nameenable == false
                        ? SizedBox.shrink()
                        : RichText(
                            maxLines: 10,
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: "${profilevalue['name']}",
                                  style: TextStyle(
                                    color: namecolor,
                                    fontSize: namesize.toDouble(),
                                    fontFamily: namefont != null
                                        ? namefont['font']
                                        : "Poppins-SemiBold",
                                  ),
                                ),
                              ],
                            ),
                          ),
                    addressenable == false || profilevalue['address'] == null
                        ? SizedBox.shrink()
                        : Column(
                            children: [
                              h(3),
                              RichText(
                                textAlign: TextAlign.justify,
                                maxLines: 10,
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: profilevalue['address'],
                                      style: TextStyle(
                                        color: addresscolor ?? blackcolor,
                                        fontSize: addresssize.toDouble(),
                                        fontFamily: addressfont != null
                                            ? addressfont['font']
                                            : "Poppins-SemiBold",
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                    numberenable == false || profilevalue['mobileno'] == null
                        ? SizedBox.shrink()
                        : Column(
                            children: [
                              h(3),
                              Padding(
                                padding: const EdgeInsets.only(right: 20.0),
                                child: Divider(
                                  height: 2,
                                  thickness: 1,
                                  color: redcolor,
                                ),
                              ),
                            ],
                          ),
                    numberenable == false || profilevalue['mobileno'] == null
                        ? SizedBox.shrink()
                        : Column(
                            children: [
                              h(3),
                              RichText(
                                maxLines: 10,
                                text: TextSpan(children: [
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
                                          size: numbersize - 2,
                                          color: whitecolor,
                                        ),
                                      ),
                                    ),
                                  ),
                                  WidgetSpan(child: w(5)),
                                  TextSpan(
                                    text: profilevalue == null
                                        ? '1234567890'
                                        : profilevalue['mobileno'],
                                    style: TextStyle(
                                      color: numbercolor ?? blackcolor,
                                      fontSize: numbersize.toDouble() ?? 12.0,
                                      fontFamily: numberfont != null
                                          ? numberfont['font']
                                          : "Poppins-SemiBold",
                                    ),
                                  ),
                                ]),
                              ),
                            ],
                          ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
  if (frameno == 3) {
    return Column(
      children: [
        Container(
          color: Colors.orange,
          height: 2,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: IntrinsicHeight(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                (profilevalue["profile_img"] == null ||
                            profileenable == false) &&
                        (profileuploadedimage == null || profileenable == false)
                    ? profileenable == false
                        ? SizedBox.shrink()
                        : Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: CircleAvatar(
                              radius: profilesize - 30,
                              backgroundImage: Image.asset(
                                "assets/dfp1.png",
                              ).image,
                            ),
                          )
                    : Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: CircleAvatar(
                          radius: profilesize - 30,
                          backgroundImage: profileuploadedimage != null
                              ? Image.file(profileuploadedimage).image
                              : CachedNetworkImageProvider(
                                  profilevalue == null
                                      ? url
                                      : "$weburl/${profilevalue["profile_img"]}",
                                ),
                        ),
                      ),
                profileenable == false
                    ? SizedBox.shrink()
                    : VerticalDivider(
                        color: Color(0xff00165d),
                        thickness: .6,
                      ),
                Expanded(
                  child: IntrinsicWidth(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 8.0, left: 8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          profilevalue['name'] == null || nameenable == false
                              ? SizedBox.shrink()
                              : RichText(
                                  maxLines: 10,
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: "${profilevalue['name']}",
                                        style: TextStyle(
                                          color: namecolor,
                                          fontSize: namesize.toDouble(),
                                          fontFamily: namefont != null
                                              ? namefont['font']
                                              : "Poppins-SemiBold",
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                          addressenable == false ||
                                  profilevalue['address'] == null
                              ? SizedBox.shrink()
                              : Column(
                                  children: [
                                    h(3),
                                    RichText(
                                      textAlign: TextAlign.center,
                                      maxLines: 10,
                                      text: TextSpan(
                                        children: [
                                          TextSpan(
                                            text: profilevalue['address'],
                                            style: TextStyle(
                                              color: addresscolor ?? blackcolor,
                                              fontSize: addresssize.toDouble(),
                                              fontFamily: addressfont != null
                                                  ? addressfont['font']
                                                  : "Poppins-SemiBold",
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                          numberenable == false ||
                                  profilevalue['mobileno'] == null
                              ? SizedBox.shrink()
                              : Column(
                                  children: [
                                    Divider(
                                      height: 2,
                                      thickness: .6,
                                      color: Color(0xff00165d),
                                    ),
                                  ],
                                ),
                          numberenable == false ||
                                  profilevalue['mobileno'] == null
                              ? SizedBox.shrink()
                              : Column(
                                  children: [
                                    RichText(
                                      maxLines: 10,
                                      text: TextSpan(children: [
                                        WidgetSpan(
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color: blackcolor,
                                                borderRadius:
                                                    BorderRadius.circular(3)),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(2.0),
                                              child: Icon(
                                                Icons.call,
                                                size: numbersize - 2,
                                                color: whitecolor,
                                              ),
                                            ),
                                          ),
                                        ),
                                        WidgetSpan(child: w(5)),
                                        TextSpan(
                                          text: profilevalue == null
                                              ? '1234567890'
                                              : profilevalue['mobileno'],
                                          style: TextStyle(
                                            color: numbercolor ?? blackcolor,
                                            fontSize:
                                                numbersize.toDouble() ?? 12.0,
                                            fontFamily: numberfont != null
                                                ? numberfont['font']
                                                : "Poppins-SemiBold",
                                          ),
                                        ),
                                      ]),
                                    ),
                                  ],
                                ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Container(
          color: Colors.green,
          height: 2,
        ),
      ],
    );
  }
  if (frameno == 4) {
    return Column(
      children: [
        Container(
          color: Colors.orange,
          height: 2,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: IntrinsicHeight(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                (profilevalue["$logo"] == null || logoenable == false) &&
                        (profileuploadedimage == null || logoenable == false)
                    ? logoenable == false
                        ? SizedBox.shrink()
                        : Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Container(
                                width: logosize,
                                height: logosize,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: Image.asset(
                                        "assets/instapost.png",
                                      ).image,
                                      fit: BoxFit.fitWidth),
                                )),
                          )
                    : Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Container(
                            width: logosize,
                            height: logosize,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: CachedNetworkImageProvider(
                                    profilevalue == null
                                        ? url
                                        : "$weburl/${profilevalue["$logo"]}",
                                  ),
                                  fit: BoxFit.fitWidth),
                            )),
                      ),
                logoenable == false
                    ? SizedBox.shrink()
                    : VerticalDivider(
                        color: Color(0xff00165d),
                        thickness: .6,
                      ),
                Expanded(
                  child: IntrinsicWidth(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 8.0, left: 8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          profilevalue['name'] == null || nameenable == false
                              ? SizedBox.shrink()
                              : RichText(
                                  maxLines: 10,
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: "${profilevalue['name']}",
                                        style: TextStyle(
                                          color: namecolor,
                                          fontSize: namesize.toDouble(),
                                          fontFamily: namefont != null
                                              ? namefont['font']
                                              : "Poppins-SemiBold",
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                          addressenable == false ||
                                  profilevalue['address'] == null
                              ? SizedBox.shrink()
                              : Column(
                                  children: [
                                    h(3),
                                    RichText(
                                      textAlign: TextAlign.center,
                                      maxLines: 10,
                                      text: TextSpan(
                                        children: [
                                          TextSpan(
                                            text: profilevalue['address'],
                                            style: TextStyle(
                                              color: addresscolor ?? blackcolor,
                                              fontSize: addresssize.toDouble(),
                                              fontFamily: addressfont != null
                                                  ? addressfont['font']
                                                  : "Poppins-SemiBold",
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                          numberenable == false ||
                                  profilevalue['mobileno'] == null
                              ? SizedBox.shrink()
                              : Column(
                                  children: [
                                    Divider(
                                      height: 2,
                                      thickness: .6,
                                      color: Color(0xff00165d),
                                    ),
                                  ],
                                ),
                          numberenable == false ||
                                  profilevalue['mobileno'] == null
                              ? SizedBox.shrink()
                              : Column(
                                  children: [
                                    RichText(
                                      maxLines: 10,
                                      text: TextSpan(children: [
                                        WidgetSpan(
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color: blackcolor,
                                                borderRadius:
                                                    BorderRadius.circular(3)),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(2.0),
                                              child: Icon(
                                                Icons.call,
                                                size: numbersize - 2,
                                                color: whitecolor,
                                              ),
                                            ),
                                          ),
                                        ),
                                        WidgetSpan(child: w(5)),
                                        TextSpan(
                                          text: profilevalue == null
                                              ? '1234567890'
                                              : profilevalue['mobileno'],
                                          style: TextStyle(
                                            color: numbercolor ?? blackcolor,
                                            fontSize:
                                                numbersize.toDouble() ?? 12.0,
                                            fontFamily: numberfont != null
                                                ? numberfont['font']
                                                : "Poppins-SemiBold",
                                          ),
                                        ),
                                      ]),
                                    ),
                                  ],
                                ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Container(
          color: Colors.green,
          height: 2,
        ),
      ],
    );
  }

  if (frameno == 5) {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          (profilevalue["$logo"] == null || logoenable == false) &&
                  (profileuploadedimage == null || logoenable == false)
              ? logoenable == false
                  ? SizedBox.shrink()
                  : Padding(
                      padding: const EdgeInsets.only(left: 5.0),
                      child: Container(
                          width: logosize,
                          height: logosize,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: Image.asset(
                                  "assets/instapost.png",
                                ).image,
                                fit: BoxFit.fitWidth),
                          )),
                    )
              : Padding(
                  padding: const EdgeInsets.only(left: 5.0),
                  child: Container(
                      width: logosize,
                      height: logosize,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: CachedNetworkImageProvider(
                              profilevalue == null
                                  ? url
                                  : "$weburl/${profilevalue["$logo"]}",
                            ),
                            fit: BoxFit.fitWidth),
                      )),
                ),
          w(10),
          Expanded(
            flex: 11,
            child: IntrinsicWidth(
              child: Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    profilevalue['name'] == null || nameenable == false
                        ? SizedBox.shrink()
                        : RichText(
                            maxLines: 10,
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: "${profilevalue['name']}",
                                  style: TextStyle(
                                    color: namecolor != redcolor
                                        ? namecolor
                                        : Color(0xfffed312),
                                    fontSize: namesize.toDouble(),
                                    fontFamily: namefont != null
                                        ? namefont['font']
                                        : "Poppins-SemiBold",
                                  ),
                                ),
                              ],
                            ),
                          ),
                    addressenable == false || profilevalue['address'] == null
                        ? SizedBox.shrink()
                        : Column(
                            children: [
                              h(3),
                              RichText(
                                textAlign: TextAlign.justify,
                                maxLines: 10,
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: profilevalue['address'],
                                      style: TextStyle(
                                        color: addresscolor ?? whitecolor,
                                        fontSize: addresssize.toDouble(),
                                        fontFamily: addressfont != null
                                            ? addressfont['font']
                                            : "Poppins-SemiBold",
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                    numberenable == false || profilevalue['mobileno'] == null
                        ? SizedBox.shrink()
                        : Column(
                            children: [
                              h(3),
                              Padding(
                                padding: const EdgeInsets.only(right: 20.0),
                                child: Divider(
                                  height: 2,
                                  thickness: 1,
                                  color: whitecolor,
                                ),
                              ),
                            ],
                          ),
                    numberenable == false || profilevalue['mobileno'] == null
                        ? SizedBox.shrink()
                        : Column(
                            children: [
                              h(3),
                              RichText(
                                maxLines: 10,
                                text: TextSpan(children: [
                                  WidgetSpan(
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: whitecolor,
                                          borderRadius:
                                              BorderRadius.circular(3)),
                                      child: Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: Icon(
                                          Icons.call,
                                          size: numbersize - 2,
                                          color: blackcolor,
                                        ),
                                      ),
                                    ),
                                  ),
                                  WidgetSpan(child: w(5)),
                                  TextSpan(
                                    text: profilevalue == null
                                        ? '1234567890'
                                        : profilevalue['mobileno'],
                                    style: TextStyle(
                                      color: numbercolor ?? whitecolor,
                                      fontSize: numbersize.toDouble() ?? 12.0,
                                      fontFamily: numberfont != null
                                          ? numberfont['font']
                                          : "Poppins-SemiBold",
                                    ),
                                  ),
                                ]),
                              ),
                            ],
                          ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
  // if (frameno == 3) {
  //   //print(profilevalue);
  //   return SizedBox(
  //       width: width,
  //       height: height,
  //       child: Row(
  //         mainAxisAlignment: MainAxisAlignment.spaceAround,
  //         children: [
  //           Container(
  //               width: width / 70,
  //               height: height,
  //               decoration: BoxDecoration(
  //                 color: blackcolor,
  //               )),
  //           nameenable == false || profilevalue['business_name'] == null
  //               ? SizedBox.shrink()
  //               : Expanded(
  //                   flex: 5,
  //                   child: Padding(
  //                     padding: const EdgeInsets.only(left: 8.0, top: 2),
  //                     child: Text(
  //                       profilevalue['business_name'] ??
  //                           'Mauli computers & multi Service',
  //                       textAlign: TextAlign.center,
  //                       style: TextStyle(
  //                         color: namecolor,
  //                         fontSize: namesize.toDouble(),
  //                         fontFamily: namefont != null
  //                             ? namefont['font']
  //                             : "Poppins-SemiBold",
  //                       ),
  //                     ),
  //                   )),
  //           nameenable == false || profilevalue['business_name'] == null
  //               ? SizedBox.shrink()
  //               : VerticalDivider(
  //                   color: blackcolor,
  //                   thickness: 1,
  //                 ),
  //           Expanded(
  //             flex: 8,
  //             child: Padding(
  //               padding: const EdgeInsets.only(right: 8.0),
  //               child: IntrinsicWidth(
  //                 child: FittedBox(
  //                   child: Column(
  //                     mainAxisAlignment: MainAxisAlignment.spaceAround,
  //                     crossAxisAlignment: CrossAxisAlignment.start,
  //                     children: [
  //                       Row(
  //                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                         children: [
  //                           profilevalue['name'] == null || nameenable == false
  //                               ? SizedBox.shrink()
  //                               : Row(
  //                                   children: [
  //                                     Icon(
  //                                       Icons.person,
  //                                       size: namesize,
  //                                       color: namecolor,
  //                                     ),
  //                                     w(1),
  //                                     Text(
  //                                       profilevalue['name'],
  //                                       style: TextStyle(
  //                                         color: namecolor,
  //                                         fontSize: namesize.toDouble(),
  //                                         fontFamily: namefont != null
  //                                             ? namefont['font']
  //                                             : null,
  //                                       ),
  //                                     ),
  //                                   ],
  //                                 ),
  //                           profilevalue['name'] == null || nameenable == false
  //                               ? SizedBox.shrink()
  //                               : w(15),
  //                           numberenable == false ||
  //                                   profilevalue['mobileno'] == null
  //                               ? SizedBox.shrink()
  //                               : Row(
  //                                   children: [
  //                                     Icon(
  //                                       Icons.call,
  //                                       size: numbersize,
  //                                       color: numbercolor,
  //                                     ),
  //                                     w(1),
  //                                     Text(
  //                                       profilevalue['mobileno'],
  //                                       style: TextStyle(
  //                                         color: numbercolor,
  //                                         fontSize: numbersize.toDouble(),
  //                                         fontFamily: numberfont != null
  //                                             ? numberfont['font']
  //                                             : null,
  //                                       ),
  //                                     ),
  //                                   ],
  //                                 ),
  //                         ],
  //                       ),
  //                       Divider(
  //                         thickness: .5,
  //                         color: blackcolor,
  //                       ),
  //                       addressenable == false ||
  //                               profilevalue['address'] == null
  //                           ? SizedBox.shrink()
  //                           : Row(
  //                               children: [
  //                                 Icon(
  //                                   Icons.location_on,
  //                                   size: addresssize,
  //                                   color: addresscolor,
  //                                 ),
  //                                 w(1),
  //                                 Text(
  //                                   profilevalue['address'],
  //                                   style: TextStyle(
  //                                     color: addresscolor,
  //                                     fontSize: addresssize.toDouble(),
  //                                     fontFamily: addressfont != null
  //                                         ? addressfont['font']
  //                                         : null,
  //                                   ),
  //                                 ),
  //                               ],
  //                             ),
  //                     ],
  //                   ),
  //                 ),
  //               ),
  //             ),
  //           ),
  //           Container(
  //               width: width / 30,
  //               height: height * .9,
  //               decoration: BoxDecoration(
  //                   color: blackcolor,
  //                   borderRadius: BorderRadius.only(
  //                       topLeft: Radius.circular(15),
  //                       bottomLeft: Radius.circular(15)))),
  //         ],
  //       ));
  // }
  if (frameno == 4) {
    return Container(
      width: width,
      height: height,
      child: Row(
        children: [
          profilevalue["$logo"] == null || logoenable == false
              ? logoenable == false
                  ? SizedBox.shrink()
                  : Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        child: Text(
                          "Your \nLogo",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    )
              : Expanded(
                  flex: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: logosize,
                      height: logosize,
                      child: CachedNetworkImage(
                        imageUrl: "$weburl/${profilevalue["$logo"]}",
                      ),
                    ),
                  )),
          logoenable == false
              ? SizedBox(width: 5)
              : Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: VerticalDivider(
                    color: blackcolor,
                    thickness: .5,
                  ),
                ),
          Expanded(
              flex: 11,
              child: Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: FittedBox(
                  child: IntrinsicWidth(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        nameenable == false || profilevalue['name'] == null
                            ? SizedBox.shrink()
                            : Container(
                                child: Text(
                                  profilevalue['name'] ??
                                      'Mauli computers & multi Service',
                                  style: TextStyle(
                                    color: namecolor,
                                    fontSize: namesize.toDouble(),
                                    fontFamily: namefont != null
                                        ? namefont['font']
                                        : "Poppins-SemiBold",
                                  ),
                                ),
                              ),
                        IntrinsicHeight(
                          child: Row(
                            children: [
                              profilevalue['name'] == null ||
                                      nameenable == false ||
                                      profilevalue['business_name'] == null
                                  ? SizedBox.shrink()
                                  : Row(
                                      children: [
                                        Icon(
                                          Icons.person,
                                          size: namesize,
                                          color: namecolor,
                                        ),
                                        w(1),
                                        Text(
                                          profilevalue['name'],
                                          style: TextStyle(
                                            color: namecolor,
                                            fontSize: namesize.toDouble(),
                                            fontFamily: namefont != null
                                                ? namefont['font']
                                                : null,
                                          ),
                                        ),
                                      ],
                                    ),
                              (profilevalue['name'] == null ||
                                          nameenable == false) ||
                                      (profilevalue['mobileno'] == null ||
                                              numberenable == false) &&
                                          (profilevalue['whatsapp_num'] ==
                                                  null ||
                                              whatsappnumberenable == false) ||
                                      profilevalue['business_name'] == null
                                  ? SizedBox.shrink()
                                  : VerticalDivider(
                                      color: blackcolor,
                                      thickness: 0.5,
                                    ),
                              numberenable == false &&
                                      whatsappnumberenable == false
                                  ? SizedBox.shrink()
                                  : Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        profilevalue['mobileno'] == null ||
                                                numberenable == false
                                            ? SizedBox.shrink()
                                            : Row(
                                                children: [
                                                  Icon(
                                                    Icons.call,
                                                    size: numbersize,
                                                    color: numbercolor,
                                                  ),
                                                  w(1),
                                                  Text(
                                                    profilevalue['mobileno'],
                                                    style: TextStyle(
                                                      color: numbercolor,
                                                      fontSize: numbersize,
                                                      fontFamily: numberfont !=
                                                              null
                                                          ? numberfont['font']
                                                          : null,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                        profilevalue['whatsapp_num'] == null ||
                                                whatsappnumberenable == false
                                            ? SizedBox.shrink()
                                            : Row(
                                                children: [
                                                  FaIcon(
                                                    FontAwesomeIcons.whatsapp,
                                                    size:
                                                        whatsappnumbersize + 2,
                                                    color: whatsappnumbercolor,
                                                  ),
                                                  w(1),
                                                  Text(
                                                    profilevalue[
                                                        'whatsapp_num'],
                                                    style: TextStyle(
                                                      color:
                                                          whatsappnumbercolor,
                                                      fontSize:
                                                          whatsappnumbersize,
                                                      fontFamily:
                                                          whatsappnumberfont !=
                                                                  null
                                                              ? whatsappnumberfont[
                                                                  'font']
                                                              : null,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                      ],
                                    ),
                            ],
                          ),
                        ),
                        (addressenable == false ||
                                profilevalue['address'] == null)
                            ? SizedBox.shrink()
                            : Divider(
                                height: 1,
                                color: blackcolor,
                                thickness: .7,
                              ),
                        addressenable == false ||
                                profilevalue['address'] == null
                            ? SizedBox.shrink()
                            : Row(
                                children: [
                                  Icon(
                                    Icons.location_on,
                                    size: addresssize,
                                    color: addresscolor,
                                  ),
                                  w(1),
                                  Text(
                                    profilevalue['address'],
                                    style: TextStyle(
                                      color: addresscolor,
                                      fontSize: addresssize.toDouble(),
                                      fontFamily: addressfont != null
                                          ? addressfont['font']
                                          : null,
                                    ),
                                  ),
                                ],
                              ),
                      ],
                    ),
                  ),
                ),
              )),
          Container(
              width: width / 30,
              height: height * .9,
              decoration: BoxDecoration(
                  color: blackcolor,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      bottomLeft: Radius.circular(15)))),
        ],
      ),
    );
  }
  if (frameno == 5) {
    return SizedBox(
      width: width,
      height: height,
      child: Row(
        children: [
          profilevalue["$logo"] == null || logoenable == false
              ? logoenable == false
                  ? SizedBox.shrink()
                  : Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        child: Text(
                          "Your \nLogo",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    )
              : Expanded(
                  flex: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: logosize,
                      height: logosize,
                      child: CachedNetworkImage(
                        imageUrl: "$weburl/${profilevalue["$logo"]}",
                      ),
                    ),
                  )),
          logoenable == false
              ? SizedBox(width: 5)
              : Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: VerticalDivider(
                    color: blackcolor,
                  ),
                ),
          Expanded(
              flex: 11,
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: FittedBox(
                  child: IntrinsicWidth(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        nameenable == false || profilevalue['name'] == null
                            ? SizedBox.shrink()
                            : Container(
                                child: Text(
                                  profilevalue['name'] ??
                                      'Mauli computers & multi Service',
                                  style: TextStyle(
                                    color: namecolor,
                                    fontSize: namesize.toDouble() + 2,
                                    fontFamily: namefont != null
                                        ? namefont['font']
                                        : "Poppins-SemiBold",
                                  ),
                                ),
                              ),
                        addressenable == false ||
                                profilevalue['address'] == null
                            ? SizedBox.shrink()
                            : Row(
                                children: [
                                  Icon(
                                    Icons.location_on,
                                    size: addresssize,
                                    color: addresscolor,
                                  ),
                                  w(1),
                                  Text(
                                    profilevalue['address'],
                                    style: TextStyle(
                                      color: addresscolor,
                                      fontSize: addresssize.toDouble() + 2,
                                      fontFamily: addressfont != null
                                          ? addressfont['font']
                                          : null,
                                    ),
                                  ),
                                ],
                              ),
                        (addressenable == false ||
                                    profilevalue['address'] == null) &&
                                (profilevalue['web_url'] == null)
                            ? SizedBox.shrink()
                            : Divider(
                                height: 1,
                                thickness: .9,
                                color: blackcolor,
                              ),
                        Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                profilevalue['mobileno'] == null ||
                                        numberenable == false
                                    ? SizedBox.shrink()
                                    : Row(
                                        children: [
                                          Icon(
                                            Icons.call,
                                            size: numbersize,
                                            color: numbercolor,
                                          ),
                                          w(1),
                                          Text(
                                            profilevalue['mobileno'],
                                            style: TextStyle(
                                              color: numbercolor,
                                              fontSize: numbersize + 2,
                                              fontFamily: numberfont != null
                                                  ? numberfont['font']
                                                  : null,
                                            ),
                                          ),
                                        ],
                                      ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              )),
          Container(
              width: width / 30,
              height: height * .9,
              decoration: BoxDecoration(
                  color: greyshade400,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      bottomLeft: Radius.circular(15)))),
        ],
      ),
    );
  }
  if (frameno == 6) {
    return Container(
      width: width,
      height: height,
      child: Row(
        children: [
          Container(
              width: width / 30,
              height: height * .9,
              decoration: BoxDecoration(
                  color: greyshade400,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(15),
                      bottomRight: Radius.circular(15)))),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: FittedBox(
              child: IntrinsicWidth(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    nameenable == false || profilevalue['name'] == null
                        ? SizedBox.shrink()
                        : Column(
                            children: [
                              Container(
                                child: Text(
                                  profilevalue['name'] ??
                                      'Mauli computers & multi Service',
                                  style: TextStyle(
                                    color: namecolor,
                                    fontSize: namesize.toDouble() - 5,
                                    fontFamily: namefont != null
                                        ? namefont['font']
                                        : "Poppins-SemiBold",
                                  ),
                                ),
                              ),
                              (profilevalue['whatsapp_num'] == null ||
                                          whatsappnumberenable == false) &&
                                      (profilevalue['mobileno'] == null ||
                                          numberenable == false)
                                  ? SizedBox.shrink()
                                  : Divider(
                                      height: 5,
                                      color: greyshade400,
                                      thickness: 1,
                                    ),
                            ],
                          ),
                    IntrinsicHeight(
                      child: Row(
                        mainAxisAlignment:
                            profilevalue['whatsapp_num'] == null ||
                                    whatsappnumberenable == false
                                ? MainAxisAlignment.center
                                : MainAxisAlignment.spaceBetween,
                        children: [
                          profilevalue['whatsapp_num'] == null ||
                                  whatsappnumberenable == false
                              ? SizedBox.shrink()
                              : Row(
                                  children: [
                                    FaIcon(
                                      FontAwesomeIcons.whatsapp,
                                      size: whatsappnumbersize,
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
                          (profilevalue['whatsapp_num'] == null ||
                                      whatsappnumberenable == false) ||
                                  (profilevalue['mobileno'] == null ||
                                      numberenable == false)
                              ? SizedBox.shrink()
                              : VerticalDivider(
                                  color: greyshade400,
                                  thickness: 1,
                                ),
                          profilevalue['mobileno'] == null ||
                                  numberenable == false
                              ? SizedBox.shrink()
                              : Row(
                                  children: [
                                    Icon(
                                      Icons.call,
                                      size: numbersize,
                                      color: numbercolor,
                                    ),
                                    w(1),
                                    Text(
                                      profilevalue['mobileno'],
                                      style: TextStyle(
                                        color: numbercolor,
                                        fontSize: numbersize,
                                        fontFamily: numberfont != null
                                            ? numberfont['font']
                                            : null,
                                      ),
                                    ),
                                  ],
                                ),
                        ],
                      ),
                    ),
                    (profilevalue['web_url'] == null) &&
                            (addressenable == false ||
                                profilevalue['address'] == null)
                        ? SizedBox.shrink()
                        : Divider(
                            height: 5,
                            color: greyshade400,
                            thickness: 1,
                          ),
                    IntrinsicHeight(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          addressenable == false ||
                                  profilevalue['address'] == null
                              ? SizedBox.shrink()
                              : Row(
                                  children: [
                                    Icon(
                                      Icons.location_on,
                                      size: addresssize,
                                      color: addresscolor,
                                    ),
                                    w(1),
                                    Text(
                                      profilevalue['address'],
                                      style: TextStyle(
                                        color: addresscolor,
                                        fontSize: addresssize.toDouble(),
                                        fontFamily: addressfont != null
                                            ? addressfont['font']
                                            : null,
                                      ),
                                    ),
                                  ],
                                ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )),
          Container(
              width: width / 30,
              height: height * .9,
              decoration: BoxDecoration(
                  color: greyshade400,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      bottomLeft: Radius.circular(15)))),
        ],
      ),
    );
  }
}
