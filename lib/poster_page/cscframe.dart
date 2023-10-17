import 'package:cached_network_image/cached_network_image.dart';
import 'package:click/poster_page/dottedclass.dart';
import 'package:click/utils/constants.dart';
import 'package:click/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

getcscframe(
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
  var weblinkenable,
  var weblinksize,
  var weblinkfont,
  var weblinkcolor,
  var buisnessnameenable,
  var buisnessnamesize,
  var buisnessnamefont,
  var buisnessnamecolor,
  var addressenable,
  var addresssize,
  var addressfont,
  var addresscolor,
  var numberenable,
  var numbersize,
  var numberfont,
  var numbercolor,
  var whatsappnumberenable,
  var whatsappnumbersize,
  var whatsappnumberfont,
  var whatsappnumbercolor,
  var emailenable,
  var emailsize,
  var emailfont,
  var emailcolor,
}) {
  var height = MediaQuery.of(context).size.width / 3.5;
  var width = MediaQuery.of(context).size.width * 0.93;
  var logo = profilevalue['users_logo'] == null ? 'csc_logo' : 'users_logo';
  var bname = profilevalue['business_name'] ?? profilevalue['name'];
  if (frameno == 1) {
    return IntrinsicHeight(
      child: Row(
        children: [
          (profilevalue["$logo"] == null || logoenable == false)
              ? logoenable == false
                  ? SizedBox.shrink()
                  : Padding(
                      padding: const EdgeInsets.only(
                          left: 8.0, top: 8, right: 2, bottom: 8),
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
                  padding: const EdgeInsets.only(
                      left: 8.0, top: 8, right: 2, bottom: 8),
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
                            fit: BoxFit.fill),
                      )),
                ),
          logoenable == false
              ? SizedBox.shrink()
              : Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: VerticalDivider(
                    thickness: 1,
                    color: blackcolor,
                  ),
                ),
          Expanded(
            flex: 10,
            child: Padding(
              padding: EdgeInsets.only(
                  left: (logoenable == false ? 10.0 : 5),
                  top: 5,
                  bottom: 5,
                  right: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  bname == null || buisnessnameenable == false
                      ? SizedBox.shrink()
                      : Column(
                          children: [
                            RichText(
                                text: TextSpan(
                              text: bname,
                              style: TextStyle(
                                color: buisnessnamecolor ?? redcolor,
                                fontSize: buisnessnamesize.toDouble(),
                                fontFamily: buisnessnamefont != null
                                    ? buisnessnamefont['font']
                                    : "EkMukta-Bold",
                              ),
                            )),
                          ],
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
                                  )
                          ],
                        ),
                  numberenable == false && whatsappnumberenable == false ||
                          weblinkenable == false
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
                                        size: weblinksize - 1,
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
                                    fontSize: weblinksize,
                                    fontFamily: weblinkfont != null
                                        ? weblinkfont['font']
                                        : 'Mukta-Semibold',
                                  ),
                                ),
                              ]),
                            ])),
                            w(8),
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
                                        size: weblinksize - 1,
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
                                    fontSize: weblinksize,
                                    fontFamily: weblinkfont != null
                                        ? weblinkfont['font']
                                        : 'Mukta-Semibold',
                                  ),
                                ),
                              ]),
                            )
                          ],
                        ),
                  addressenable == false || profilevalue['address'] == null
                      ? SizedBox.shrink()
                      : Divider(
                          thickness: .4,
                          height: 5,
                          color: blackcolor,
                        ),
                  addressenable == false || profilevalue['address'] == null
                      ? SizedBox.shrink()
                      : RichText(
                          text: TextSpan(children: [
                          WidgetSpan(
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Color(0xff1571f9),
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
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
  if (frameno == 2) {
    return Padding(
      padding: EdgeInsets.only(left: 10.0, top: 5, bottom: 5, right: 10),
      child: IntrinsicHeight(
        child: Row(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  bname == null || buisnessnameenable == false
                      ? SizedBox.shrink()
                      : Column(
                          children: [
                            RichText(
                                text: TextSpan(
                              text: bname,
                              style: TextStyle(
                                color: buisnessnamecolor ?? redcolor,
                                fontSize: buisnessnamesize.toDouble(),
                                fontFamily: buisnessnamefont != null
                                    ? buisnessnamefont['font']
                                    : "EkMukta-Bold",
                              ),
                            )),
                          ],
                        ),
                  bname == null || buisnessnameenable == false
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
                            w(5),
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
                  addressenable == false || profilevalue['address'] == null
                      ? SizedBox.shrink()
                      : RichText(
                          text: TextSpan(children: [
                          WidgetSpan(
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Color(0xff1571f9),
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
                  (addressenable == false || profilevalue['address'] == null) ||
                          weblinkenable == false
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
                            w(5),
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
            logoenable == false
                ? SizedBox.shrink()
                : Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: VerticalDivider(
                      thickness: .6,
                      color: blackcolor,
                    ),
                  ),
            (profilevalue["$logo"] == null || logoenable == false)
                ? logoenable == false
                    ? SizedBox.shrink()
                    : Padding(
                        padding: const EdgeInsets.only(
                            left: 8.0, top: 8, right: 2, bottom: 8),
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
                    padding: const EdgeInsets.only(
                        left: 8.0, top: 8, right: 2, bottom: 8),
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
                              fit: BoxFit.fill),
                        )),
                  ),
          ],
        ),
      ),
    );
  }
  if (frameno == 3) {
    return IntrinsicHeight(
      child: Row(
        children: [
          bname == null || buisnessnameenable == false
              ? SizedBox.shrink()
              : Expanded(
                  flex: 6,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 8.0, top: 8, right: 2, bottom: 8),
                    child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          text: bname,
                          style: TextStyle(
                            color: buisnessnamecolor ?? redcolor,
                            fontSize: buisnessnamesize.toDouble() + 4,
                            fontFamily: buisnessnamefont != null
                                ? buisnessnamefont['font']
                                : "Khand-Bold",
                          ),
                        )),
                  ),
                ),
          bname == null || buisnessnameenable == false
              ? SizedBox.shrink()
              : Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: VerticalDivider(
                    thickness: 1,
                    color: blackcolor,
                  ),
                ),
          Expanded(
            flex: 9,
            child: Padding(
              padding: EdgeInsets.only(
                  left: (logoenable == false ? 10.0 : 5),
                  top: 5,
                  bottom: 5,
                  right: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                                  )
                          ],
                        ),
                  numberenable == false && whatsappnumberenable == false ||
                          weblinkenable == false
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
                                        size: weblinksize - 1,
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
                                    fontSize: weblinksize,
                                    fontFamily: weblinkfont != null
                                        ? weblinkfont['font']
                                        : 'Mukta-Semibold',
                                  ),
                                ),
                              ]),
                            ])),
                            w(8),
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
                                        size: weblinksize - 1,
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
                                    fontSize: weblinksize,
                                    fontFamily: weblinkfont != null
                                        ? weblinkfont['font']
                                        : 'Mukta-Semibold',
                                  ),
                                ),
                              ]),
                            )
                          ],
                        ),
                  addressenable == false || profilevalue['address'] == null
                      ? SizedBox.shrink()
                      : Divider(
                          thickness: .4,
                          height: 5,
                          color: blackcolor,
                        ),
                  addressenable == false || profilevalue['address'] == null
                      ? SizedBox.shrink()
                      : RichText(
                          text: TextSpan(children: [
                          WidgetSpan(
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Color(0xff1571f9),
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
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
  if (frameno == 4) {
    return IntrinsicHeight(
      child: Row(
        children: [
          bname == null || buisnessnameenable == false
              ? SizedBox.shrink()
              : Expanded(
                  flex: 6,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 8.0, top: 8, right: 2, bottom: 8),
                    child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          text: bname,
                          style: TextStyle(
                            color: buisnessnamecolor ?? Color(0xffffdd1a),
                            fontSize: buisnessnamesize.toDouble() + 4,
                            fontFamily: buisnessnamefont != null
                                ? buisnessnamefont['font']
                                : "Khand-Bold",
                          ),
                        )),
                  ),
                ),
          bname == null || buisnessnameenable == false
              ? SizedBox.shrink()
              : Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: VerticalDivider(
                    thickness: 1,
                    color: whitecolor,
                  ),
                ),
          Expanded(
            flex: 9,
            child: Padding(
              padding: EdgeInsets.only(
                  left: (logoenable == false ? 10.0 : 5),
                  top: 5,
                  bottom: 5,
                  right: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                                              color: Color(0xffdadbea),
                                              borderRadius:
                                                  BorderRadius.circular(3)),
                                          child: Padding(
                                            padding: const EdgeInsets.all(2.0),
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
                                          color: numbercolor ?? whitecolor,
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
                                              whatsappnumbercolor ?? whitecolor,
                                          fontSize: whatsappnumbersize,
                                          fontFamily: whatsappnumberfont != null
                                              ? whatsappnumberfont['font']
                                              : 'Mukta-Semibold',
                                        ),
                                      ),
                                    ]),
                                  )
                          ],
                        ),
                  numberenable == false && whatsappnumberenable == false ||
                          weblinkenable == false
                      ? SizedBox.shrink()
                      : Divider(
                          thickness: .4,
                          height: 5,
                          color: whitecolor,
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
                                        color: Color(0xffdadbea),
                                        borderRadius: BorderRadius.circular(3)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(2.0),
                                      child: Icon(
                                        Icons.language,
                                        size: weblinksize - 1,
                                        color: blackcolor,
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
                                    color: weblinkcolor ?? whitecolor,
                                    fontSize: weblinksize,
                                    fontFamily: weblinkfont != null
                                        ? weblinkfont['font']
                                        : 'Mukta-Semibold',
                                  ),
                                ),
                              ]),
                            ])),
                            w(8),
                            RichText(
                              text: TextSpan(children: [
                                WidgetSpan(
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Color(0xffdadbea),
                                        borderRadius: BorderRadius.circular(3)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(2.0),
                                      child: Icon(
                                        Icons.language,
                                        size: weblinksize - 1,
                                        color: blackcolor,
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
                                    color: weblinkcolor ?? whitecolor,
                                    fontSize: weblinksize,
                                    fontFamily: weblinkfont != null
                                        ? weblinkfont['font']
                                        : 'Mukta-Semibold',
                                  ),
                                ),
                              ]),
                            )
                          ],
                        ),
                  addressenable == false || profilevalue['address'] == null
                      ? SizedBox.shrink()
                      : Divider(
                          thickness: .4,
                          height: 5,
                          color: whitecolor,
                        ),
                  addressenable == false || profilevalue['address'] == null
                      ? SizedBox.shrink()
                      : RichText(
                          text: TextSpan(children: [
                          WidgetSpan(
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Color(0xffdadbea),
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
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
  if (frameno == 5) {
    return IntrinsicHeight(
      child: Row(
        children: [
          (profilevalue["$logo"] == null || logoenable == false)
              ? logoenable == false
                  ? SizedBox.shrink()
                  : Padding(
                      padding: const EdgeInsets.only(
                          left: 8.0, top: 8, right: 2, bottom: 8),
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
                  padding: const EdgeInsets.only(
                      left: 8.0, top: 8, right: 2, bottom: 8),
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
                            fit: BoxFit.fill),
                      )),
                ),
          logoenable == false
              ? SizedBox.shrink()
              : Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8.0, horizontal: 5),
                  child: CustomPaint(
                      size: Size(1, double.infinity),
                      painter: DashedLineVerticalPainter())),
          Expanded(
            flex: 10,
            child: Padding(
              padding: EdgeInsets.only(
                  left: (logoenable == false ? 10.0 : 5),
                  top: 5,
                  bottom: 5,
                  right: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  bname == null || buisnessnameenable == false
                      ? SizedBox.shrink()
                      : Column(
                          children: [
                            RichText(
                                text: TextSpan(
                              text: bname,
                              style: TextStyle(
                                color: buisnessnamecolor ?? redcolor,
                                fontSize: buisnessnamesize.toDouble(),
                                fontFamily: buisnessnamefont != null
                                    ? buisnessnamefont['font']
                                    : "Mukta-Semibold-Bold",
                              ),
                            )),
                          ],
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
                                  )
                          ],
                        ),
                  numberenable == false && whatsappnumberenable == false ||
                          weblinkenable == false
                      ? SizedBox.shrink()
                      : Padding(
                          padding: EdgeInsets.symmetric(vertical: 3),
                          child: CustomPaint(
                              size: Size(double.infinity, 1),
                              painter: DrawDottedhorizontalline()),
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
                                        size: weblinksize - 1,
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
                                    fontSize: weblinksize,
                                    fontFamily: weblinkfont != null
                                        ? weblinkfont['font']
                                        : 'Mukta-Semibold',
                                  ),
                                ),
                              ]),
                            ])),
                            w(8),
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
                                        size: weblinksize - 1,
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
                                    fontSize: weblinksize,
                                    fontFamily: weblinkfont != null
                                        ? weblinkfont['font']
                                        : 'Mukta-Semibold',
                                  ),
                                ),
                              ]),
                            )
                          ],
                        ),
                  addressenable == false || profilevalue['address'] == null
                      ? SizedBox.shrink()
                      : Padding(
                          padding: EdgeInsets.symmetric(vertical: 3),
                          child: CustomPaint(
                              size: Size(double.infinity, 1),
                              painter: DrawDottedhorizontalline()),
                        ),
                  addressenable == false || profilevalue['address'] == null
                      ? SizedBox.shrink()
                      : RichText(
                          text: TextSpan(children: [
                          WidgetSpan(
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Color(0xff1571f9),
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
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
  if (frameno == 6) {
    return IntrinsicHeight(
      child: Row(
        children: [
          (profilevalue["$logo"] == null || logoenable == false)
              ? logoenable == false
                  ? SizedBox.shrink()
                  : Padding(
                      padding: const EdgeInsets.only(
                          left: 8.0, top: 8, right: 2, bottom: 8),
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
                  padding: const EdgeInsets.only(
                      left: 8.0, top: 8, right: 2, bottom: 8),
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
                            fit: BoxFit.fill),
                      )),
                ),
          logoenable == false
              ? SizedBox.shrink()
              : Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: VerticalDivider(
                    thickness: 1,
                    color: whitecolor,
                  ),
                ),
          Expanded(
            flex: 10,
            child: Padding(
              padding: EdgeInsets.only(
                  left: (logoenable == false ? 10.0 : 5),
                  top: 5,
                  bottom: 5,
                  right: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  bname == null || buisnessnameenable == false
                      ? SizedBox.shrink()
                      : Column(
                          children: [
                            RichText(
                                text: TextSpan(
                              text: bname,
                              style: TextStyle(
                                color: buisnessnamecolor ?? Color(0xffffdd1a),
                                fontSize: buisnessnamesize.toDouble(),
                                fontFamily: buisnessnamefont != null
                                    ? buisnessnamefont['font']
                                    : "Mukta-Semibold-Bold",
                              ),
                            )),
                          ],
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
                                      WidgetSpan(
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: Color(0xffdadbea),
                                              borderRadius:
                                                  BorderRadius.circular(3)),
                                          child: Padding(
                                            padding: const EdgeInsets.all(2.0),
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
                                          color: numbercolor ?? whitecolor,
                                          fontSize: numbersize,
                                          fontFamily: numberfont != null
                                              ? numberfont['font']
                                              : 'Mukta-Semibold',
                                        ),
                                      ),
                                    ]),
                                  ),
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
                                              whatsappnumbercolor ?? whitecolor,
                                          fontSize: whatsappnumbersize,
                                          fontFamily: whatsappnumberfont != null
                                              ? whatsappnumberfont['font']
                                              : 'Mukta-Semibold',
                                        ),
                                      ),
                                    ]),
                                  )
                          ],
                        ),
                  numberenable == false && whatsappnumberenable == false ||
                          weblinkenable == false
                      ? SizedBox.shrink()
                      : Divider(
                          thickness: .4,
                          height: 5,
                          color: whitecolor,
                        ),
                  weblinkenable == false
                      ? SizedBox.shrink()
                      : Wrap(
                          children: [
                            RichText(
                                text: TextSpan(children: [
                              weblinkenable == false
                                  ? WidgetSpan(child: SizedBox.shrink())
                                  : TextSpan(children: [
                                      WidgetSpan(
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: Color(0xffdadbea),
                                              borderRadius:
                                                  BorderRadius.circular(3)),
                                          child: Padding(
                                            padding: const EdgeInsets.all(2.0),
                                            child: Icon(
                                              Icons.language,
                                              size: weblinksize - 1,
                                              color: blackcolor,
                                            ),
                                          ),
                                        ),
                                      ),
                                      WidgetSpan(child: w(5)),
                                      TextSpan(
                                        text: profilevalue['web_url'] == null ||
                                                profilevalue['web_url'] ==
                                                    "null" ||
                                                profilevalue['web_url'] == ""
                                            ? "www.csckisan.com"
                                            : profilevalue['web_url'],
                                        style: TextStyle(
                                          color: weblinkcolor ?? whitecolor,
                                          fontSize: weblinksize,
                                          fontFamily: weblinkfont != null
                                              ? weblinkfont['font']
                                              : 'Mukta-Semibold',
                                        ),
                                      ),
                                    ]),
                            ])),
                            w(8),
                            RichText(
                              text: TextSpan(children: [
                                WidgetSpan(
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Color(0xffdadbea),
                                        borderRadius: BorderRadius.circular(3)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(2.0),
                                      child: Icon(
                                        Icons.language,
                                        size: weblinksize - 1,
                                        color: blackcolor,
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
                                    color: weblinkcolor ?? whitecolor,
                                    fontSize: weblinksize,
                                    fontFamily: weblinkfont != null
                                        ? weblinkfont['font']
                                        : 'Mukta-Semibold',
                                  ),
                                ),
                              ]),
                            )
                          ],
                        ),
                  addressenable == false || profilevalue['address'] == null
                      ? SizedBox.shrink()
                      : Divider(
                          thickness: .4,
                          height: 5,
                          color: whitecolor,
                        ),
                  addressenable == false || profilevalue['address'] == null
                      ? SizedBox.shrink()
                      : RichText(
                          text: TextSpan(children: [
                          WidgetSpan(
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Color(0xffdadbea),
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
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
  if (frameno == 7) {
    return Padding(
      padding: EdgeInsets.only(left: 10.0, top: 5, bottom: 5, right: 10),
      child: Row(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                numberenable == false &&
                        whatsappnumberenable == false &&
                        nameenable == false
                    ? SizedBox.shrink()
                    : Wrap(
                        children: [
                          profilevalue['name'] == null || nameenable == false
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
                                            Icons.person,
                                            size: namesize - 2,
                                            color: whitecolor,
                                          ),
                                        ),
                                      ),
                                    ),
                                    WidgetSpan(child: w(5)),
                                    TextSpan(
                                      text: profilevalue['name'],
                                      style: TextStyle(
                                        color: namecolor ?? blackcolor,
                                        fontSize: namesize - 0.5,
                                        fontFamily: namefont != null
                                            ? numberfont['font']
                                            : 'Mukta-Semibold',
                                      ),
                                    ),
                                  ]),
                                ])),
                          w(10),
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
                          w(10),
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
                (addressenable == false || profilevalue['address'] == null) ||
                        (numberenable == false && whatsappnumberenable == false)
                    ? SizedBox.shrink()
                    : Divider(
                        thickness: .4,
                        height: 5,
                        color: blackcolor,
                      ),
                addressenable == false || profilevalue['address'] == null
                    ? SizedBox.shrink()
                    : RichText(
                        text: TextSpan(children: [
                        WidgetSpan(
                          child: Container(
                            decoration: BoxDecoration(
                                color: Color(0xff1571f9),
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
                (addressenable == false || profilevalue['address'] == null) ||
                        weblinkenable == false
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
                          w(10),
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
  if (frameno == 8) {
    return Padding(
      padding: EdgeInsets.only(left: 10.0, top: 5, bottom: 5, right: 10),
      child: Row(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                numberenable == false &&
                        whatsappnumberenable == false &&
                        nameenable == false
                    ? SizedBox.shrink()
                    : Wrap(
                        children: [
                          profilevalue['name'] == null || nameenable == false
                              ? SizedBox.shrink()
                              : RichText(
                                  text: TextSpan(children: [
                                  TextSpan(children: [
                                    WidgetSpan(
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: Color(0xffffd014),
                                            borderRadius:
                                                BorderRadius.circular(3)),
                                        child: Padding(
                                          padding: const EdgeInsets.all(2.0),
                                          child: Icon(
                                            Icons.person,
                                            size: namesize - 2,
                                            color: blackcolor,
                                          ),
                                        ),
                                      ),
                                    ),
                                    WidgetSpan(child: w(5)),
                                    TextSpan(
                                      text: profilevalue['name'],
                                      style: TextStyle(
                                        color: namecolor ?? whitecolor,
                                        fontSize: namesize - 0.5,
                                        fontFamily: namefont != null
                                            ? numberfont['font']
                                            : 'Mukta-Semibold',
                                      ),
                                    ),
                                  ]),
                                ])),
                          w(10),
                          profilevalue['mobileno'] == null ||
                                  numberenable == false
                              ? SizedBox.shrink()
                              : RichText(
                                  text: TextSpan(children: [
                                  TextSpan(children: [
                                    WidgetSpan(
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: Color(0xffffd014),
                                            borderRadius:
                                                BorderRadius.circular(3)),
                                        child: Padding(
                                          padding: const EdgeInsets.all(2.0),
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
                                        color: numbercolor ?? whitecolor,
                                        fontSize: numbersize,
                                        fontFamily: numberfont != null
                                            ? numberfont['font']
                                            : 'Mukta-Semibold',
                                      ),
                                    ),
                                  ]),
                                ])),
                          w(10),
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
                                            whatsappnumbercolor ?? whitecolor,
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
                (addressenable == false || profilevalue['address'] == null) ||
                        (numberenable == false && whatsappnumberenable == false)
                    ? SizedBox.shrink()
                    : Divider(
                        thickness: .4,
                        height: 5,
                        color: whitecolor,
                      ),
                addressenable == false || profilevalue['address'] == null
                    ? SizedBox.shrink()
                    : RichText(
                        text: TextSpan(children: [
                        WidgetSpan(
                          child: Container(
                            decoration: BoxDecoration(
                                color: Color(0xffffd014),
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
                (addressenable == false || profilevalue['address'] == null) ||
                        weblinkenable == false
                    ? SizedBox.shrink()
                    : Divider(
                        thickness: .4,
                        height: 5,
                        color: whitecolor,
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
                                      color: Color(0xffffd014),
                                      borderRadius: BorderRadius.circular(3)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: Icon(
                                      Icons.language,
                                      size: weblinksize + 1,
                                      color: blackcolor,
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
                                  color: weblinkcolor ?? whitecolor,
                                  fontSize: weblinksize + 2,
                                  fontFamily: weblinkfont != null
                                      ? weblinkfont['font']
                                      : 'Mukta-Semibold',
                                ),
                              ),
                            ]),
                          ])),
                          w(10),
                          RichText(
                            text: TextSpan(children: [
                              WidgetSpan(
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Color(0xffffd014),
                                      borderRadius: BorderRadius.circular(3)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: Icon(
                                      Icons.language,
                                      size: weblinksize + 1,
                                      color: blackcolor,
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
                                  color: weblinkcolor ?? whitecolor,
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
    //print(profilevalue);
    return Row(
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
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.only(left: 5.0),
                  child: Container(
                    height: logosize,
                    width: logosize,
                    child: CachedNetworkImage(
                      imageUrl: profilevalue == null
                          ? url
                          : "$weburl/${profilevalue["$logo"]}",
                    ),
                  ),
                )),
        Expanded(
          flex: 10,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                bname == null || buisnessnameenable == false
                    ? SizedBox.shrink()
                    : RichText(
                        text: TextSpan(
                        text: bname,
                        style: TextStyle(
                          color: buisnessnamecolor ?? blackcolor,
                          fontSize: buisnessnamesize.toDouble(),
                          fontFamily: buisnessnamefont != null
                              ? buisnessnamefont['font']
                              : "Poppins-SemiBold",
                        ),
                      )),
                profilevalue['mobileno'] == null || numberenable == false
                    ? SizedBox.shrink()
                    : RichText(
                        text: TextSpan(
                        text: profilevalue['mobileno'],
                        style: TextStyle(
                          color: numbercolor ?? blackcolor,
                          fontSize: numbersize,
                          fontFamily:
                              numberfont != null ? numberfont['font'] : null,
                        ),
                      )),
                // Row(
                //   children: [
                //     Icon(
                //       Icons.call,
                //       size: numbersize,
                //       color: numbercolor,
                //     ),
                //     w(1),
                //     Text(
                //       profilevalue['mobileno'],
                //       style: TextStyle(
                //         color: numbercolor,
                //         fontSize: numbersize,
                //         fontFamily:
                //             numberfont != null ? numberfont['font'] : null,
                //       ),
                //     ),
                //   ],
                // ),
                addressenable == false || profilevalue['address'] == null
                    ? SizedBox.shrink()
                    : Column(
                        children: [
                          h(2),
                          RichText(
                              text: TextSpan(
                            text: profilevalue['address'],
                            style: TextStyle(
                              color: addresscolor ?? blackcolor,
                              fontSize: addresssize.toDouble(),
                              fontFamily: addressfont != null
                                  ? addressfont['font']
                                  : null,
                            ),
                          )),
                        ],
                      ),
                // addressenable == false || profilevalue['address'] == null
                //     ? SizedBox.shrink()
                //     : Row(
                //         children: [
                //           Icon(
                //             Icons.location_on,
                //             size: addresssize,
                //             color: addresscolor,
                //           ),
                //           w(1),
                //           Text(
                //             profilevalue['address'],
                //             style: TextStyle(
                //               color: addresscolor,
                //               fontSize: addresssize.toDouble(),
                //               fontFamily: addressfont != null
                //                   ? addressfont['font']
                //                   : null,
                //             ),
                //           ),
                //         ],
                //       ),
                profilevalue['web_url'] == null || weblinkenable == false
                    ? SizedBox.shrink()
                    : Column(
                        children: [
                          h(2),
                          RichText(
                              text: TextSpan(
                            text: profilevalue['web_url'],
                            style: TextStyle(
                              color: weblinkcolor ?? blackcolor,
                              fontSize: weblinksize.toDouble(),
                              fontFamily: weblinkfont != null
                                  ? weblinkfont['font']
                                  : null,
                            ),
                          )),
                        ],
                      ),
                // profilevalue['web_url'] == null || weblinkenable == false
                //     ? SizedBox.shrink()
                //     : Row(
                //         children: [
                //           Icon(
                //             Icons.language_sharp,
                //             size: weblinksize,
                //             color: weblinkcolor,
                //           ),
                //           w(1),
                //           Text(
                //             profilevalue['web_url'],
                //             style: TextStyle(
                //               color: weblinkcolor,
                //               fontSize: weblinksize.toDouble(),
                //               fontFamily: weblinkfont != null
                //                   ? weblinkfont['font']
                //                   : null,
                //             ),
                //           ),
                //         ],
                //       )
              ],
            ),
          ),
        ),
        (profilevalue["profile_img"] == null || profileenable == false) &&
                (profileuploadedimage == null || profileenable == false)
            ? profileenable == false
                ? SizedBox.shrink()
                : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      child: Text(
                        "Your \nProfile",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  )
            : Expanded(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Container(
                    height: profilesize,
                    width: profilesize,
                    child: profileuploadedimage != null
                        ? Image.file(
                            profileuploadedimage,
                            fit: BoxFit.fitWidth,
                          )
                        : CachedNetworkImage(
                            imageUrl: "$weburl/${profilevalue["profile_img"]}",
                          ),
                  ),
                )),
      ],
    );
  }
  if (frameno == 3) {
    //print(profilevalue);
    return Row(
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
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Color(0xffd1d1d1), width: 2),
                      borderRadius: BorderRadius.circular(width / 6),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(width / 6),
                        child: CachedNetworkImage(
                          imageUrl: profilevalue == null
                              ? url
                              : "$weburl/${profilevalue["$logo"]}",
                        ),
                      ),
                    ),
                  ),
                )),
        Expanded(
          flex: 10,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                bname == null || buisnessnameenable == false
                    ? SizedBox.shrink()
                    : RichText(
                        text: TextSpan(
                        text: bname,
                        style: TextStyle(
                          color: buisnessnamecolor ?? blackcolor,
                          fontSize: buisnessnamesize.toDouble(),
                          fontFamily: buisnessnamefont != null
                              ? buisnessnamefont['font']
                              : "Poppins-SemiBold",
                        ),
                      )),
                profilevalue['mobileno'] == null || numberenable == false
                    ? SizedBox.shrink()
                    : RichText(
                        text: TextSpan(
                        text: profilevalue['mobileno'],
                        style: TextStyle(
                          color: numbercolor ?? blackcolor,
                          fontSize: numbersize,
                          fontFamily:
                              numberfont != null ? numberfont['font'] : null,
                        ),
                      )),
                // Row(
                //   children: [
                //     Icon(
                //       Icons.call,
                //       size: numbersize,
                //       color: numbercolor,
                //     ),
                //     w(1),
                //     Text(
                //       profilevalue['mobileno'],
                //       style: TextStyle(
                //         color: numbercolor,
                //         fontSize: numbersize,
                //         fontFamily:
                //             numberfont != null ? numberfont['font'] : null,
                //       ),
                //     ),
                //   ],
                // ),
                addressenable == false || profilevalue['address'] == null
                    ? SizedBox.shrink()
                    : Column(
                        children: [
                          h(2),
                          RichText(
                              text: TextSpan(
                            text: profilevalue['address'],
                            style: TextStyle(
                              color: addresscolor ?? blackcolor,
                              fontSize: addresssize.toDouble(),
                              fontFamily: addressfont != null
                                  ? addressfont['font']
                                  : null,
                            ),
                          )),
                        ],
                      ),
                // addressenable == false || profilevalue['address'] == null
                //     ? SizedBox.shrink()
                //     : Row(
                //         children: [
                //           Icon(
                //             Icons.location_on,
                //             size: addresssize,
                //             color: addresscolor,
                //           ),
                //           w(1),
                //           Text(
                //             profilevalue['address'],
                //             style: TextStyle(
                //               color: addresscolor,
                //               fontSize: addresssize.toDouble(),
                //               fontFamily: addressfont != null
                //                   ? addressfont['font']
                //                   : null,
                //             ),
                //           ),
                //         ],
                //       ),
                profilevalue['web_url'] == null || weblinkenable == false
                    ? SizedBox.shrink()
                    : Column(
                        children: [
                          h(2),
                          RichText(
                              text: TextSpan(
                            text: profilevalue['web_url'],
                            style: TextStyle(
                              color: weblinkcolor ?? blackcolor,
                              fontSize: weblinksize.toDouble(),
                              fontFamily: weblinkfont != null
                                  ? weblinkfont['font']
                                  : null,
                            ),
                          )),
                        ],
                      ),
                // profilevalue['web_url'] == null || weblinkenable == false
                //     ? SizedBox.shrink()
                //     : Row(
                //         children: [
                //           Icon(
                //             Icons.language_sharp,
                //             size: weblinksize,
                //             color: weblinkcolor,
                //           ),
                //           w(1),
                //           Text(
                //             profilevalue['web_url'],
                //             style: TextStyle(
                //               color: weblinkcolor,
                //               fontSize: weblinksize.toDouble(),
                //               fontFamily: weblinkfont != null
                //                   ? weblinkfont['font']
                //                   : null,
                //             ),
                //           ),
                //         ],
                //       )
              ],
            ),
          ),
        ),
        (profilevalue["profile_img"] == null || profileenable == false) &&
                (profileuploadedimage == null || profileenable == false)
            ? profileenable == false
                ? SizedBox.shrink()
                : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      child: Text(
                        "Your \nProfile",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  )
            : Expanded(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Color(0xffd1d1d1), width: 2),
                      borderRadius: BorderRadius.circular(width / 6),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(width / 6),
                        child: CachedNetworkImage(
                          imageUrl: profilevalue == null
                              ? url
                              : "$weburl/${profilevalue["profile_img"]}",
                        ),
                      ),
                    ),
                  ),
                )),
      ],
    );
  }
  if (frameno == 4) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        (profilevalue["$logo"] == null || logoenable == false) &&
                (profileuploadedimage == null || logoenable == false)
            ? SizedBox.shrink()
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
        w(10),
        Expanded(
          flex: 11,
          child: FittedBox(
            child: Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: IntrinsicWidth(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    bname == null || buisnessnameenable == false
                        ? SizedBox.shrink()
                        : RichText(
                            text: TextSpan(
                            text: bname,
                            style: TextStyle(
                              color: buisnessnamecolor ?? blackcolor,
                              fontSize: buisnessnamesize.toDouble(),
                              fontFamily: buisnessnamefont != null
                                  ? buisnessnamefont['font']
                                  : "Poppins-SemiBold",
                            ),
                          )),
                    numberenable == false && whatsappnumberenable == false
                        ? SizedBox.shrink()
                        : Column(
                            children: [
                              h(2),
                              RichText(
                                  text: TextSpan(children: [
                                profilevalue['name'] == null ||
                                        nameenable == false
                                    ? WidgetSpan(child: SizedBox.shrink())
                                    : TextSpan(
                                        text: profilevalue['name'],
                                        style: TextStyle(
                                          color: namecolor ?? blackcolor,
                                          fontSize: namesize.toDouble(),
                                          fontFamily: namefont != null
                                              ? namefont['font']
                                              : null,
                                        ),
                                      ),
                                numberenable == false || nameenable == false
                                    ? WidgetSpan(child: SizedBox.shrink())
                                    : WidgetSpan(
                                        child: w(20),
                                      ),
                                numberenable == false ||
                                        profilevalue['mobileno'] == null
                                    ? WidgetSpan(child: SizedBox.shrink())
                                    : TextSpan(
                                        text: profilevalue == null
                                            ? '1234567890'
                                            : profilevalue['mobileno'],
                                        style: TextStyle(
                                          color: numbercolor ?? blackcolor,
                                          fontSize: numbersize.toDouble(),
                                          fontFamily: numberfont != null
                                              ? numberfont['font']
                                              : null,
                                        ),
                                      )
                              ])),
                            ],
                          ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: [
                    //     profilevalue['name'] == null || nameenable == false
                    //         ? SizedBox.shrink()
                    //         : Row(
                    //             children: [
                    //               Icon(
                    //                 Icons.person,
                    //                 size: namesize,
                    //                 color: namecolor,
                    //               ),
                    //               Text(
                    //                 profilevalue['name'],
                    //                 style: TextStyle(
                    //                   color: namecolor,
                    //                   fontSize: namesize.toDouble(),
                    //                   fontFamily: namefont != null
                    //                       ? namefont['font']
                    //                       : null,
                    //                 ),
                    //               ),
                    //             ],
                    //           ),
                    //     w(15),
                    //     numberenable == false ||
                    //             profilevalue['mobileno'] == null
                    //         ? SizedBox.shrink()
                    //         : Row(
                    //             children: [
                    //               Icon(
                    //                 Icons.call,
                    //                 size: numbersize,
                    //                 color: numbercolor,
                    //               ),
                    //               w(1),
                    //               Text(
                    //                 profilevalue == null
                    //                     ? '1234567890'
                    //                     : profilevalue['mobileno'],
                    //                 style: TextStyle(
                    //                   color: numbercolor,
                    //                   fontSize: numbersize.toDouble(),
                    //                   fontFamily: numberfont != null
                    //                       ? numberfont['font']
                    //                       : null,
                    //                 ),
                    //               ),
                    //             ],
                    //           ),
                    //   ],
                    // ),
                    (addressenable == false ||
                                profilevalue['address'] == null) &&
                            (profilevalue['web_url'] == null ||
                                weblinkenable == false)
                        ? SizedBox.shrink()
                        : Column(
                            children: [
                              h(2),
                              Divider(
                                height: 2,
                                thickness: .5,
                                color: blackcolor,
                              ),
                            ],
                          ),
                    addressenable == false || profilevalue['address'] == null
                        ? SizedBox.shrink()
                        : Column(
                            children: [
                              h(2),
                              RichText(
                                  text: TextSpan(
                                text: profilevalue['address'],
                                style: TextStyle(
                                  color: addresscolor ?? blackcolor,
                                  fontSize: addresssize.toDouble(),
                                  fontFamily: addressfont != null
                                      ? addressfont['font']
                                      : null,
                                ),
                              )),
                            ],
                          ),
                    // addressenable == false || profilevalue['address'] == null
                    //     ? SizedBox.shrink()
                    //     : Row(
                    //         children: [
                    //           Icon(
                    //             Icons.location_on,
                    //             size: addresssize,
                    //             color: addresscolor,
                    //           ),
                    //           w(1),
                    //           Text(
                    //             profilevalue['address'],
                    //             style: TextStyle(
                    //               color: addresscolor,
                    //               fontSize: addresssize.toDouble(),
                    //               fontFamily: addressfont != null
                    //                   ? addressfont['font']
                    //                   : null,
                    //             ),
                    //           ),
                    //         ],
                    //       ),
                    profilevalue['web_url'] == null || weblinkenable == false
                        ? SizedBox.shrink()
                        : Column(
                            children: [
                              h(2),
                              RichText(
                                  text: TextSpan(
                                text: profilevalue['web_url'],
                                style: TextStyle(
                                  color: weblinkcolor ?? blackcolor,
                                  fontSize: weblinksize.toDouble(),
                                  fontFamily: weblinkfont != null
                                      ? weblinkfont['font']
                                      : null,
                                ),
                              )),
                            ],
                          ),
                    // profilevalue['web_url'] == null || weblinkenable == false
                    //     ? SizedBox.shrink()
                    //     : Row(
                    //         children: [
                    //           Icon(
                    //             Icons.language_sharp,
                    //             size: weblinksize,
                    //             color: weblinkcolor,
                    //           ),
                    //           w(1),
                    //           Text(
                    //             profilevalue['web_url'],
                    //             style: TextStyle(
                    //               color: weblinkcolor,
                    //               fontSize: weblinksize.toDouble(),
                    //               fontFamily: weblinkfont != null
                    //                   ? weblinkfont['font']
                    //                   : null,
                    //             ),
                    //           ),
                    //         ],
                    //       )
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
  if (frameno == 5) {
    //print(profilevalue);
    return IntrinsicHeight(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
              width: width / 70,
              height: height,
              decoration: BoxDecoration(
                color: blackcolor,
              )),
          buisnessnameenable == false || profilevalue['business_name'] == null
              ? SizedBox.shrink()
              : Expanded(
                  flex: 4,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0, top: 2),
                    child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          text: bname,
                          style: TextStyle(
                            color: buisnessnamecolor ?? blackcolor,
                            fontSize: buisnessnamesize.toDouble(),
                            fontFamily: buisnessnamefont != null
                                ? buisnessnamefont['font']
                                : "Poppins-SemiBold",
                          ),
                        )),
                  )),
          buisnessnameenable == false || profilevalue['business_name'] == null
              ? SizedBox.shrink()
              : VerticalDivider(
                  color: blackcolor,
                  thickness: 1,
                ),
          Expanded(
            flex: 8,
            child: Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: IntrinsicWidth(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    numberenable == false && whatsappnumberenable == false
                        ? SizedBox.shrink()
                        : Column(
                            children: [
                              h(2),
                              RichText(
                                  text: TextSpan(children: [
                                profilevalue['name'] == null ||
                                        nameenable == false
                                    ? WidgetSpan(child: SizedBox.shrink())
                                    : TextSpan(
                                        text: profilevalue['name'],
                                        style: TextStyle(
                                          color: namecolor ?? blackcolor,
                                          fontSize: namesize.toDouble(),
                                          fontFamily: namefont != null
                                              ? namefont['font']
                                              : null,
                                        ),
                                      ),
                                numberenable == false || nameenable == false
                                    ? WidgetSpan(child: SizedBox.shrink())
                                    : WidgetSpan(
                                        child: w(20),
                                      ),
                                numberenable == false ||
                                        profilevalue['mobileno'] == null
                                    ? WidgetSpan(child: SizedBox.shrink())
                                    : TextSpan(
                                        text: profilevalue == null
                                            ? '1234567890'
                                            : profilevalue['mobileno'],
                                        style: TextStyle(
                                          color: numbercolor ?? blackcolor,
                                          fontSize: numbersize.toDouble(),
                                          fontFamily: numberfont != null
                                              ? numberfont['font']
                                              : null,
                                        ),
                                      )
                              ])),
                            ],
                          ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: [
                    //     profilevalue['name'] == null || nameenable == false
                    //         ? SizedBox.shrink()
                    //         : Row(
                    //             children: [
                    //               Icon(
                    //                 Icons.person,
                    //                 size: namesize,
                    //                 color: namecolor,
                    //               ),
                    //               w(1),
                    //               Text(
                    //                 profilevalue['name'],
                    //                 style: TextStyle(
                    //                   color: namecolor,
                    //                   fontSize: namesize.toDouble(),
                    //                   fontFamily: namefont != null
                    //                       ? namefont['font']
                    //                       : null,
                    //                 ),
                    //               ),
                    //             ],
                    //           ),
                    //     profilevalue['name'] == null || nameenable == false
                    //         ? SizedBox.shrink()
                    //         : w(15),
                    //     numberenable == false ||
                    //             profilevalue['mobileno'] == null
                    //         ? SizedBox.shrink()
                    //         : Row(
                    //             children: [
                    //               Icon(
                    //                 Icons.call,
                    //                 size: numbersize,
                    //                 color: numbercolor,
                    //               ),
                    //               w(1),
                    //               Text(
                    //                 profilevalue['mobileno'],
                    //                 style: TextStyle(
                    //                   color: numbercolor,
                    //                   fontSize: numbersize.toDouble(),
                    //                   fontFamily: numberfont != null
                    //                       ? numberfont['font']
                    //                       : null,
                    //                 ),
                    //               ),
                    //             ],
                    //           ),
                    //   ],
                    // ),
                    (addressenable == false ||
                                profilevalue['address'] == null) &&
                            (profilevalue['web_url'] == null ||
                                weblinkenable == false)
                        ? SizedBox.shrink()
                        : Column(
                            children: [
                              h(2),
                              Divider(
                                height: 2,
                                thickness: .5,
                                color: blackcolor,
                              ),
                            ],
                          ),
                    addressenable == false || profilevalue['address'] == null
                        ? SizedBox.shrink()
                        : Column(
                            children: [
                              h(2),
                              RichText(
                                  text: TextSpan(
                                text: profilevalue['address'],
                                style: TextStyle(
                                  color: addresscolor ?? blackcolor,
                                  fontSize: addresssize.toDouble(),
                                  fontFamily: addressfont != null
                                      ? addressfont['font']
                                      : null,
                                ),
                              )),
                            ],
                          ),
                    // addressenable == false || profilevalue['address'] == null
                    //     ? SizedBox.shrink()
                    //     : Row(
                    //         children: [
                    //           Icon(
                    //             Icons.location_on,
                    //             size: addresssize,
                    //             color: addresscolor,
                    //           ),
                    //           w(1),
                    //           Text(
                    //             profilevalue['address'],
                    //             style: TextStyle(
                    //               color: addresscolor,
                    //               fontSize: addresssize.toDouble(),
                    //               fontFamily: addressfont != null
                    //                   ? addressfont['font']
                    //                   : null,
                    //             ),
                    //           ),
                    //         ],
                    //       ),
                    profilevalue['web_url'] == null || weblinkenable == false
                        ? SizedBox.shrink()
                        : Column(
                            children: [
                              h(2),
                              RichText(
                                  text: TextSpan(
                                text: profilevalue['web_url'],
                                style: TextStyle(
                                  color: weblinkcolor ?? blackcolor,
                                  fontSize: weblinksize.toDouble(),
                                  fontFamily: weblinkfont != null
                                      ? weblinkfont['font']
                                      : null,
                                ),
                              )),
                            ],
                          ),
                    // profilevalue['web_url'] == null || weblinkenable == false
                    //     ? SizedBox.shrink()
                    //     : Row(
                    //         children: [
                    //           Icon(
                    //             Icons.language_sharp,
                    //             size: weblinksize,
                    //             color: weblinkcolor,
                    //           ),
                    //           w(1),
                    //           Text(
                    //             profilevalue['web_url'],
                    //             style: TextStyle(
                    //               color: weblinkcolor,
                    //               fontSize: weblinksize.toDouble(),
                    //               fontFamily: weblinkfont != null
                    //                   ? weblinksize['font']
                    //                   : null,
                    //             ),
                    //           ),
                    //         ],
                    //       )
                  ],
                ),
              ),
            ),
          ),
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
  if (frameno == 6) {
    return Row(
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
              child: IntrinsicWidth(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    buisnessnameenable == false || bname == null
                        ? SizedBox.shrink()
                        : RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              text: bname,
                              style: TextStyle(
                                color: buisnessnamecolor ?? blackcolor,
                                fontSize: buisnessnamesize.toDouble(),
                                fontFamily: buisnessnamefont != null
                                    ? buisnessnamefont['font']
                                    : "Poppins-SemiBold",
                              ),
                            )),
                    // Container(
                    //     child: Text(
                    //       bname ?? 'Mauli computers & multi Service',
                    //       style: TextStyle(
                    //         color: buisnessnamecolor,
                    //         fontSize: buisnessnamesize.toDouble(),
                    //         fontFamily: buisnessnamefont != null
                    //             ? buisnessnamefont['font']
                    //             : "Poppins-SemiBold",
                    //       ),
                    //     ),
                    //   ),
                    IntrinsicHeight(
                      child: Row(
                        children: [
                          profilevalue['name'] == null ||
                                  nameenable == false ||
                                  profilevalue['business_name'] == null
                              ? SizedBox.shrink()
                              : RichText(
                                  text: TextSpan(children: [
                                  TextSpan(
                                    text: profilevalue['name'],
                                    style: TextStyle(
                                      color: namecolor ?? blackcolor,
                                      fontSize: namesize.toDouble(),
                                      fontFamily: namefont != null
                                          ? namefont['font']
                                          : null,
                                    ),
                                  ),
                                ])),
                          // Row(
                          //     children: [
                          //       Icon(
                          //         Icons.person,
                          //         size: namesize,
                          //         color: namecolor,
                          //       ),
                          //       w(1),
                          //       Text(
                          //         profilevalue['name'],
                          //         style: TextStyle(
                          //           color: namecolor,
                          //           fontSize: namesize.toDouble(),
                          //           fontFamily: namefont != null
                          //               ? namefont['font']
                          //               : null,
                          //         ),
                          //       ),
                          //     ],
                          //   ),
                          (profilevalue['name'] == null ||
                                      nameenable == false) ||
                                  (profilevalue['mobileno'] == null ||
                                          numberenable == false) &&
                                      (profilevalue['whatsapp_num'] == null ||
                                          whatsappnumberenable == false) ||
                                  profilevalue['business_name'] == null
                              ? SizedBox.shrink()
                              : VerticalDivider(
                                  color: blackcolor,
                                  thickness: 0.5,
                                ),
                          numberenable == false && whatsappnumberenable == false
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
                                                  fontFamily: numberfont != null
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
                                                size: whatsappnumbersize + 2,
                                                color: whatsappnumbercolor,
                                              ),
                                              w(1),
                                              Text(
                                                profilevalue['whatsapp_num'],
                                                style: TextStyle(
                                                  color: whatsappnumbercolor,
                                                  fontSize: whatsappnumbersize,
                                                  fontFamily:
                                                      whatsappnumberfont != null
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
                                profilevalue['address'] == null) &&
                            (profilevalue['web_url'] == null ||
                                weblinkenable == false)
                        ? SizedBox.shrink()
                        : Divider(
                            height: 1,
                            color: blackcolor,
                            thickness: .7,
                          ),
                    addressenable == false || profilevalue['address'] == null
                        ? SizedBox.shrink()
                        : Column(
                            children: [
                              h(2),
                              RichText(
                                  textAlign: TextAlign.start,
                                  text: TextSpan(
                                    text: profilevalue['address'],
                                    style: TextStyle(
                                      color: addresscolor ?? blackcolor,
                                      fontSize: addresssize.toDouble(),
                                      fontFamily: addressfont != null
                                          ? addressfont['font']
                                          : null,
                                    ),
                                  )),
                            ],
                          ),
                    // Row(
                    //     children: [
                    //       Icon(
                    //         Icons.location_on,
                    //         size: addresssize,
                    //         color: addresscolor,
                    //       ),
                    //       w(1),
                    //       Text(
                    //         profilevalue['address'],
                    //         style: TextStyle(
                    //           color: addresscolor,
                    //           fontSize: addresssize.toDouble(),
                    //           fontFamily: addressfont != null
                    //               ? addressfont['font']
                    //               : null,
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    profilevalue['web_url'] == null || weblinkenable == false
                        ? SizedBox.shrink()
                        : Column(
                            children: [
                              h(2),
                              RichText(
                                  textAlign: TextAlign.start,
                                  text: TextSpan(
                                    text: profilevalue['web_url'],
                                    style: TextStyle(
                                      color: weblinkcolor ?? blackcolor,
                                      fontSize: weblinksize.toDouble(),
                                      fontFamily: weblinkfont != null
                                          ? weblinkfont['font']
                                          : null,
                                    ),
                                  )),
                            ],
                          ),
                    // Row(
                    //     children: [
                    //       Icon(
                    //         Icons.language_sharp,
                    //         size: weblinksize,
                    //         color: weblinkcolor,
                    //       ),
                    //       w(1),
                    //       Text(
                    //         profilevalue['web_url'],
                    //         style: TextStyle(
                    //           color: weblinkcolor,
                    //           fontSize: weblinksize.toDouble(),
                    //           fontFamily: weblinkfont != null
                    //               ? weblinksize['font']
                    //               : null,
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                  ],
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
    );
  }
  if (frameno == 7) {
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
                        buisnessnameenable == false || bname == null
                            ? SizedBox.shrink()
                            : Container(
                                child: Text(
                                  bname ?? 'Mauli computers & multi Service',
                                  style: TextStyle(
                                    color: buisnessnamecolor,
                                    fontSize: buisnessnamesize.toDouble() + 2,
                                    fontFamily: buisnessnamefont != null
                                        ? buisnessnamefont['font']
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
                                (profilevalue['web_url'] == null ||
                                    weblinkenable == false)
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
                                profilevalue['web_url'] == null ||
                                        weblinkenable == false
                                    ? SizedBox.shrink()
                                    : Row(
                                        children: [
                                          Icon(
                                            Icons.language_sharp,
                                            size: weblinksize,
                                            color: weblinkcolor,
                                          ),
                                          w(1),
                                          Text(
                                            profilevalue['web_url'],
                                            style: TextStyle(
                                              color: weblinkcolor,
                                              fontSize:
                                                  weblinksize.toDouble() + 2,
                                              fontFamily: weblinkfont != null
                                                  ? weblinksize['font']
                                                  : null,
                                            ),
                                          ),
                                        ],
                                      )
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
  if (frameno == 8) {
    return Container(
      width: width,
      height: height,
      child: Row(
        children: [
          Expanded(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: FittedBox(
              child: IntrinsicWidth(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    buisnessnameenable == false || bname == null
                        ? SizedBox.shrink()
                        : Column(
                            children: [
                              Container(
                                child: Text(
                                  bname ?? 'Mauli computers & multi Service',
                                  style: TextStyle(
                                    color: buisnessnamecolor,
                                    fontSize: buisnessnamesize.toDouble() - 5,
                                    fontFamily: buisnessnamefont != null
                                        ? buisnessnamefont['font']
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
                    (profilevalue['web_url'] == null ||
                                weblinkenable == false) &&
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
                          (addressenable == false ||
                                      profilevalue['address'] == null) ||
                                  (profilevalue['web_url'] == null ||
                                      weblinkenable == false)
                              ? SizedBox.shrink()
                              : VerticalDivider(
                                  color: greyshade400,
                                  thickness: 1,
                                ),
                          profilevalue['web_url'] == null ||
                                  weblinkenable == false
                              ? SizedBox.shrink()
                              : Row(
                                  children: [
                                    Icon(
                                      Icons.language_sharp,
                                      size: weblinksize,
                                      color: weblinkcolor,
                                    ),
                                    w(1),
                                    Text(
                                      profilevalue['web_url'],
                                      style: TextStyle(
                                        color: weblinkcolor,
                                        fontSize: weblinksize.toDouble(),
                                        fontFamily: weblinkfont != null
                                            ? weblinksize['font']
                                            : null,
                                      ),
                                    ),
                                  ],
                                )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )),
        ],
      ),
    );
  }
  if (frameno == 9) {
    var height = MediaQuery.of(context).size.width / 4.37;
    var width = MediaQuery.of(context).size.width * 0.93;
    return SizedBox(
        width: width,
        height: height,
        child: Stack(children: <Widget>[
          Positioned(
              top: 0,
              left: 0,
              child: Container(
                  width: width,
                  height: height,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/Design Only.png'),
                        fit: BoxFit.fitWidth),
                  ))),
          Positioned(
              top: height / 4.5,
              left: width / 1.211,
              child: Container(
                  width: width / 7.33,
                  height: width / 7.33,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(7),
                      topRight: Radius.circular(7),
                      bottomLeft: Radius.circular(7),
                      bottomRight: Radius.circular(7),
                    ),
                    image: DecorationImage(
                        image: profileuploadedimage != null
                            ? FileImage(profileuploadedimage)
                            : Image.network(
                                profilevalue == null
                                    ? url
                                    : "$weburl/${profilevalue["profile_img"]}",
                              ).image,
                        fit: BoxFit.fitWidth),
                  ))),
          Positioned(
              top: height / 4.5,
              left: width / 29.3,
              child: Container(
                  width: width / 7.33,
                  height: width / 7.33,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(7),
                      topRight: Radius.circular(7),
                      bottomLeft: Radius.circular(7),
                      bottomRight: Radius.circular(7),
                    ),
                    image: DecorationImage(
                        image: profileuploadedimage != null
                            ? FileImage(profileuploadedimage)
                            : Image.network(
                                profilevalue == null
                                    ? url
                                    : "$weburl/${profilevalue["profile_img"]}",
                              ).image,
                        fit: BoxFit.fitWidth),
                  ))),
          Positioned(
            child: SizedBox(
              height: height,
              width: width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Expanded(flex: 3, child: SizedBox()),
                  Expanded(
                    flex: 11,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FittedBox(
                        fit: BoxFit.fill,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              profilevalue == null
                                  ? 'Mauli computers & multi Service'
                                  : profilevalue['name'],
                              softWrap: true,
                              maxLines: 1,
                              style: TextStyle(
                                color: namecolor,
                                fontSize: namesize.toDouble(),
                                fontFamily:
                                    namefont != null ? namefont['font'] : null,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.person,
                                      size: 20,
                                      color: namecolor,
                                    ),
                                    const SizedBox(width: 5),
                                    Text(
                                      profilevalue == null
                                          ? 'Mauli computers & multi Service'
                                          : profilevalue['name'],
                                      maxLines: 1,
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
                                w(5),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.call,
                                      size: 20,
                                      color: numbercolor,
                                    ),
                                    const SizedBox(width: 5),
                                    Text(
                                      profilevalue == null
                                          ? '1234567890'
                                          : profilevalue['mobileno'],
                                      style: TextStyle(
                                        color: numbercolor,
                                        fontSize: numbersize.toDouble(),
                                        fontFamily: numberfont != null
                                            ? numberfont['font']
                                            : null,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            FittedBox(
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.email,
                                    size: 20,
                                    color: emailcolor,
                                  ),
                                  const SizedBox(width: 5),
                                  Text(
                                    profilevalue == null
                                        ? 'Clickonadd@gmail.com'
                                        : profilevalue['email'],
                                    maxLines: 1,
                                    style: TextStyle(
                                      color: emailcolor,
                                      fontSize: emailsize.toDouble(),
                                      fontFamily: emailfont != null
                                          ? emailfont['font']
                                          : null,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            FittedBox(
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.location_on,
                                    size: 20,
                                    color: addresscolor,
                                  ),
                                  const SizedBox(width: 5),
                                  Text(
                                    'Near SBI Bank,Keshav Nagar',
                                    maxLines: 1,
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
                            ),
                            FittedBox(
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.language_sharp,
                                    size: 20,
                                    color: emailcolor,
                                  ),
                                  const SizedBox(width: 5),
                                  Text(
                                    profilevalue == null
                                        ? 'www.clickonadd.com'
                                        : profilevalue['web_url'] ??
                                            'www.clickonadd.com',
                                    maxLines: 1,
                                    style: TextStyle(
                                      color: emailcolor,
                                      fontSize: emailsize.toDouble(),
                                      fontFamily: emailfont != null
                                          ? emailfont['font']
                                          : null,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  const Expanded(flex: 3, child: SizedBox()),
                ],
              ),
            ),
          ),
        ]));
  }
  if (frameno == 10) {
    var height = MediaQuery.of(context).size.width / 4.37;
    var width = MediaQuery.of(context).size.width * 0.93;
    return SizedBox(
        width: width,
        height: height,
        child: Stack(children: <Widget>[
          Positioned(
              top: 0,
              left: 0,
              child: Container(
                  width: width,
                  height: height,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/8.Design Only.png'),
                        fit: BoxFit.fitWidth),
                  ))),
          Positioned(
              top: height / 5.2,
              left: width / 17.86,
              child: Container(
                  width: width / 6.85,
                  height: width / 6.85,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: profileuploadedimage != null
                            ? FileImage(profileuploadedimage)
                            : Image.network(
                                profilevalue == null
                                    ? url
                                    : "$weburl/${profilevalue["profile_img"]}",
                              ).image,
                        fit: BoxFit.fitWidth),
                  ))),
          Positioned(
              child: SizedBox(
            height: height - height / 10,
            width: width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Expanded(flex: 4, child: SizedBox()),
                Expanded(
                  flex: 8,
                  child: FittedBox(
                    fit: BoxFit.fill,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          profilevalue == null
                              ? 'Mauli computers & multi Service'
                              : profilevalue['name'],
                          softWrap: true,
                          maxLines: 1,
                          style: TextStyle(
                            color: namecolor,
                            fontSize: namesize.toDouble(),
                            fontFamily:
                                namefont != null ? namefont['font'] : null,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.person,
                                  size: 20,
                                  color: namecolor,
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  profilevalue == null
                                      ? 'Mauli computers & multi Service'
                                      : profilevalue['name'],
                                  maxLines: 1,
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
                            Row(
                              children: [
                                Icon(
                                  Icons.call,
                                  size: 20,
                                  color: numbercolor,
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  profilevalue == null
                                      ? '1234567890'
                                      : profilevalue['mobileno'],
                                  style: TextStyle(
                                    color: numbercolor,
                                    fontSize: numbersize.toDouble(),
                                    fontFamily: numberfont != null
                                        ? numberfont['font']
                                        : null,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox()
                          ],
                        ),
                        FittedBox(
                          child: Row(
                            children: [
                              Icon(
                                Icons.email,
                                size: 20,
                                color: whitecolor,
                              ),
                              const SizedBox(width: 5),
                              Text(
                                profilevalue == null
                                    ? 'Clickonadd@gmail.com'
                                    : profilevalue['email'],
                                maxLines: 1,
                                style: TextStyle(
                                  color: emailcolor,
                                  fontSize: emailsize.toDouble(),
                                  fontFamily: emailfont != null
                                      ? emailfont['font']
                                      : null,
                                ),
                              ),
                            ],
                          ),
                        ),
                        FittedBox(
                          child: Row(
                            children: [
                              Icon(
                                Icons.location_on,
                                size: 20,
                                color: addresscolor,
                              ),
                              const SizedBox(width: 5),
                              Text(
                                'Near SBI Bank,Keshav Nagar',
                                maxLines: 1,
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
                        ),
                        FittedBox(
                          child: Row(
                            children: [
                              Icon(
                                Icons.language_sharp,
                                size: 20,
                                color: whitecolor,
                              ),
                              const SizedBox(width: 5),
                              Text(
                                profilevalue == null
                                    ? 'www.clickonadd.com'
                                    : profilevalue['web_url'] ??
                                        'www.clickonadd.com',
                                maxLines: 1,
                                style: TextStyle(
                                  color: emailcolor,
                                  fontSize: emailsize.toDouble(),
                                  fontFamily: emailfont != null
                                      ? emailfont['font']
                                      : null,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                const Expanded(child: SizedBox(width: 10)),
              ],
            ),
          )),
        ]));
  }
  if (frameno == 11) {
    var height = MediaQuery.of(context).size.width / 4.37;
    var width = MediaQuery.of(context).size.width * 0.93;
    return SizedBox(
        width: width,
        height: height,
        child: Stack(children: <Widget>[
          Positioned(
              top: 0,
              left: 0,
              child: Container(
                  width: width,
                  height: height,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/10.Design Only.png'),
                        fit: BoxFit.fitWidth),
                  ))),
          Positioned(
              top: height / 6.4,
              left: width / 41.1,
              child: Container(
                  width: width / 6.85,
                  height: width / 6.85,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: profileuploadedimage != null
                            ? FileImage(profileuploadedimage)
                            : Image.network(
                                profilevalue == null
                                    ? url
                                    : "$weburl/${profilevalue["profile_img"]}",
                              ).image,
                        fit: BoxFit.fitWidth),
                    borderRadius:
                        const BorderRadius.all(Radius.elliptical(60, 60)),
                  ))),
          Positioned(
              top: height / 6.4,
              left: width / 1.20,
              child: Container(
                  width: width / 6.85,
                  height: width / 6.85,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: profileuploadedimage != null
                            ? FileImage(profileuploadedimage)
                            : Image.network(
                                profilevalue == null
                                    ? url
                                    : "$weburl/${profilevalue["profile_img"]}",
                              ).image,
                        fit: BoxFit.fitWidth),
                    borderRadius:
                        const BorderRadius.all(Radius.elliptical(60, 60)),
                  ))),
          Positioned(
            child: SizedBox(
              height: height,
              width: width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Expanded(flex: 3, child: SizedBox()),
                  Expanded(
                    flex: 11,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FittedBox(
                        fit: BoxFit.fill,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              profilevalue == null
                                  ? 'Mauli computers & multi Service'
                                  : profilevalue['name'],
                              softWrap: true,
                              maxLines: 1,
                              style: TextStyle(
                                color: numbercolor,
                                fontSize: numbersize.toDouble(),
                                fontFamily: numberfont != null
                                    ? numberfont['font']
                                    : null,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.person,
                                      size: 20,
                                      color: namecolor,
                                    ),
                                    const SizedBox(width: 5),
                                    Text(
                                      profilevalue == null
                                          ? 'Mauli computers & multi Service'
                                          : profilevalue['name'],
                                      maxLines: 1,
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
                                w(5),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.call,
                                      size: 20,
                                      color: numbercolor,
                                    ),
                                    const SizedBox(width: 5),
                                    Text(
                                      profilevalue == null
                                          ? '1234567890'
                                          : profilevalue['mobileno'],
                                      style: TextStyle(
                                        color: numbercolor,
                                        fontSize: numbersize.toDouble(),
                                        fontFamily: numberfont != null
                                            ? numberfont['font']
                                            : null,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            FittedBox(
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.email,
                                    size: 20,
                                    color: emailcolor,
                                  ),
                                  const SizedBox(width: 5),
                                  Text(
                                    profilevalue == null
                                        ? 'Clickonadd@gmail.com'
                                        : profilevalue['email'],
                                    maxLines: 1,
                                    style: TextStyle(
                                      color: emailcolor,
                                      fontSize: emailsize.toDouble(),
                                      fontFamily: emailfont != null
                                          ? emailfont['font']
                                          : null,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            FittedBox(
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.location_on,
                                    size: 20,
                                    color: addresscolor,
                                  ),
                                  const SizedBox(width: 5),
                                  Text(
                                    'Near SBI Bank,Keshav Nagar',
                                    maxLines: 1,
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
                            ),
                            FittedBox(
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.language_sharp,
                                    size: 20,
                                    color: emailcolor,
                                  ),
                                  const SizedBox(width: 5),
                                  Text(
                                    profilevalue == null
                                        ? 'www.clickonadd.com'
                                        : profilevalue['web_url'] ??
                                            'www.clickonadd.com',
                                    maxLines: 1,
                                    style: TextStyle(
                                      color: emailcolor,
                                      fontSize: emailsize.toDouble(),
                                      fontFamily: emailfont != null
                                          ? emailfont['font']
                                          : null,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  const Expanded(flex: 3, child: SizedBox()),
                ],
              ),
            ),
          ),
        ]));
  }
  if (frameno == 12) {
    var height = MediaQuery.of(context).size.width / 4.37;
    var width = MediaQuery.of(context).size.width * 0.93;

    return SizedBox(
        width: width,
        height: height,
        child: Stack(children: <Widget>[
          Positioned(
              top: 0,
              left: 0,
              child: Container(
                  width: width,
                  height: height,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/11.Design Only.png'),
                        fit: BoxFit.fitWidth),
                  ))),
          Positioned(
              top: height / 7,
              left: width / 58.71,
              child: Container(
                  width: width / 5.87,
                  height: width / 5.87,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: profileuploadedimage != null
                            ? FileImage(profileuploadedimage)
                            : Image.network(
                                profilevalue == null
                                    ? url
                                    : "$weburl/${profilevalue["profile_img"]}",
                              ).image,
                        fit: BoxFit.fitWidth),
                    borderRadius:
                        const BorderRadius.all(Radius.elliptical(70, 70)),
                  ))),
          Positioned(
              top: height / 7,
              left: width / 1.24,
              child: Container(
                  width: width / 5.87,
                  height: width / 5.87,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: profileuploadedimage != null
                            ? FileImage(profileuploadedimage)
                            : Image.network(
                                profilevalue == null
                                    ? url
                                    : "$weburl/${profilevalue["profile_img"]}",
                              ).image,
                        fit: BoxFit.fitWidth),
                    borderRadius:
                        const BorderRadius.all(Radius.elliptical(70, 70)),
                  ))),
          Positioned(
            child: SizedBox(
              height: height,
              width: width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Expanded(flex: 3, child: SizedBox()),
                  Expanded(
                    flex: 11,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FittedBox(
                        fit: BoxFit.fill,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              profilevalue == null
                                  ? 'Mauli computers & multi Service'
                                  : profilevalue['name'],
                              softWrap: true,
                              maxLines: 1,
                              style: TextStyle(
                                color: namecolor,
                                fontSize: namesize.toDouble(),
                                fontFamily:
                                    namefont != null ? namefont['font'] : null,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.person,
                                      size: 20,
                                      color: addresscolor,
                                    ),
                                    const SizedBox(width: 5),
                                    Text(
                                      profilevalue == null
                                          ? 'Mauli computers & multi Service'
                                          : profilevalue['name'],
                                      maxLines: 1,
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
                                w(5),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.call,
                                      size: 20,
                                      color: numbercolor,
                                    ),
                                    const SizedBox(width: 5),
                                    Text(
                                      profilevalue == null
                                          ? '1234567890'
                                          : profilevalue['mobileno'],
                                      style: TextStyle(
                                        color: numbercolor,
                                        fontSize: numbersize.toDouble(),
                                        fontFamily: numberfont != null
                                            ? numberfont['font']
                                            : null,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            FittedBox(
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.email,
                                    size: 20,
                                    color: emailcolor,
                                  ),
                                  const SizedBox(width: 5),
                                  Text(
                                    profilevalue == null
                                        ? 'Clickonadd@gmail.com'
                                        : profilevalue['email'],
                                    maxLines: 1,
                                    style: TextStyle(
                                      color: emailcolor,
                                      fontSize: emailsize.toDouble(),
                                      fontFamily: emailfont != null
                                          ? emailfont['font']
                                          : null,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            FittedBox(
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.location_on,
                                    size: 20,
                                    color: addresscolor,
                                  ),
                                  const SizedBox(width: 5),
                                  Text(
                                    'Near SBI Bank,Keshav Nagar',
                                    maxLines: 1,
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
                            ),
                            FittedBox(
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.language_sharp,
                                    size: 20,
                                    color: emailcolor,
                                  ),
                                  const SizedBox(width: 5),
                                  Text(
                                    profilevalue == null
                                        ? 'www.clickonadd.com'
                                        : profilevalue['web_url'] ??
                                            'www.clickonadd.com',
                                    maxLines: 1,
                                    style: TextStyle(
                                      color: emailcolor,
                                      fontSize: emailsize.toDouble(),
                                      fontFamily: emailfont != null
                                          ? emailfont['font']
                                          : null,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  const Expanded(flex: 3, child: SizedBox()),
                ],
              ),
            ),
          ),
        ]));
  }

  if (frameno == 13) {
    var height = MediaQuery.of(context).size.width / 7;
    var width = MediaQuery.of(context).size.width * 0.93;
    return SizedBox(
        width: width,
        height: height + 5,
        child: Stack(children: <Widget>[
          Positioned(
              top: 0,
              left: 0,
              child: Container(
                  width: width,
                  height: height,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/Footer-1.png'),
                        fit: BoxFit.fitWidth),
                  ))),
          Positioned(
              top: height / 20.66,
              child: SizedBox(
                width: width,
                height: height,
                child: Row(
                  children: [
                    Expanded(
                      flex: 8,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            profilevalue == null
                                ? 'Mauli computers & multi Service'
                                : profilevalue['name'],
                            maxLines: 1,
                            style: TextStyle(
                              color: namecolor,
                              fontSize: namesize.toDouble(),
                              fontFamily:
                                  namefont != null ? namefont['font'] : null,
                            ),
                          ),
                          FittedBox(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                FittedBox(
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.email,
                                          size: 20,
                                          color: emailcolor,
                                        ),
                                        const SizedBox(width: 5),
                                        Text(
                                          profilevalue == null
                                              ? 'Clickonadd@gmail.com'
                                              : profilevalue['email'],
                                          maxLines: 1,
                                          style: TextStyle(
                                            color: emailcolor,
                                            fontSize: emailsize.toDouble(),
                                            fontFamily: emailfont != null
                                                ? emailfont['font']
                                                : null,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 5),
                                FittedBox(
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 10),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.call,
                                          size: 20,
                                          color: numbercolor,
                                        ),
                                        const SizedBox(width: 5),
                                        Text(
                                          profilevalue == null
                                              ? '1234567890'
                                              : profilevalue['mobileno'],
                                          maxLines: 1,
                                          style: TextStyle(
                                            color: numbercolor,
                                            fontSize: numbersize.toDouble(),
                                            fontFamily: numberfont != null
                                                ? numberfont['font']
                                                : null,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.location_on,
                                size: 20,
                                color: addresscolor,
                              ),
                              const SizedBox(width: 5),
                              Text(
                                'Near SBI Bank,Keshav Nagar',
                                maxLines: 1,
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
              )),
        ]));
  }

  if (frameno == 14) {
    var height = MediaQuery.of(context).size.width / 4.37;
    var width = MediaQuery.of(context).size.width * 0.93;
    return Container(
        alignment: Alignment.center,
        width: width,
        height: height,
        child: Stack(children: <Widget>[
          Positioned(
              top: 0,
              left: 0,
              child: Container(
                  width: width,
                  height: height,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/2.png'),
                        fit: BoxFit.fitWidth),
                  ))),
          Positioned(
              top: height / 7,
              left: width / 6.9,
              child: Container(
                  width: width / 8.4,
                  height: width / 8.4,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: profileuploadedimage != null
                            ? FileImage(profileuploadedimage)
                            : Image.network(
                                profilevalue == null
                                    ? url
                                    : "$weburl/${profilevalue["profile_img"]}",
                              ).image,
                        fit: BoxFit.fitWidth),
                    borderRadius: BorderRadius.all(
                        Radius.elliptical(width / 8.7, width / 8.7)),
                  ))),
          Positioned(
              top: height / 7,
              left: width / 1.36,
              child: Container(
                  width: width / 8.4,
                  height: width / 8.4,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: profileuploadedimage != null
                            ? FileImage(profileuploadedimage)
                            : Image.network(
                                profilevalue == null
                                    ? url
                                    : "$weburl/${profilevalue["profile_img"]}",
                              ).image,
                        fit: BoxFit.fitWidth),
                    borderRadius: BorderRadius.all(
                        Radius.elliptical(width / 8.7, width / 8.7)),
                  ))),
          Positioned(
              top: height / 4.5,
              left: width / 3.3,
              right: width / 3.3,
              child: SizedBox(
                width: width / 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FittedBox(
                      child: Text(
                        profilevalue == null
                            ? 'Mauli computers & multi Service'
                            : profilevalue['name'],
                        maxLines: 1,
                        style: TextStyle(
                          color: namecolor,
                          fontSize: namesize.toDouble(),
                          fontFamily:
                              namefont != null ? namefont['font'] : null,
                        ),
                      ),
                    ),
                    h(2),
                    FittedBox(
                      child: Text(
                        profilevalue == null
                            ? 'Mauli computers & multi Service Mauli computers & multi Service'
                            : profilevalue['name'],
                        softWrap: true,
                        maxLines: 2,
                        style: TextStyle(
                          color: namecolor,
                          fontSize: namesize.toDouble(),
                          fontFamily:
                              namefont != null ? namefont['font'] : null,
                        ),
                      ),
                    ),
                  ],
                ),
              )),
          Positioned(
              top: height / 1.4,
              left: width / 29,
              right: width / 29,
              child: SizedBox(
                  width: width,
                  height: height / 6,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      FittedBox(
                        child: Row(
                          children: [
                            Icon(
                              Icons.call,
                              size: 20,
                              color: numbercolor,
                            ),
                            const SizedBox(width: 5),
                            Text(
                              profilevalue == null
                                  ? '1234567890'
                                  : profilevalue['mobileno'],
                              maxLines: 1,
                              style: TextStyle(
                                color: numbercolor,
                                fontSize: numbersize.toDouble(),
                                fontFamily: numberfont != null
                                    ? numberfont['font']
                                    : null,
                              ),
                            ),
                          ],
                        ),
                      ),
                      FittedBox(
                        child: Row(
                          children: [
                            Icon(
                              Icons.email,
                              size: 20,
                              color: emailcolor,
                            ),
                            const SizedBox(width: 5),
                            Text(
                              profilevalue == null
                                  ? 'Clickonadd@gmail.com'
                                  : profilevalue['email'],
                              maxLines: 1,
                              style: TextStyle(
                                color: emailcolor,
                                fontSize: emailsize.toDouble(),
                                fontFamily: emailfont != null
                                    ? emailfont['font']
                                    : null,
                              ),
                            ),
                          ],
                        ),
                      ),
                      FittedBox(
                          child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.location_on,
                            size: 20,
                            color: addresscolor,
                          ),
                          const SizedBox(width: 5),
                          Text(
                            'Near SBI Bank,Keshav Nagar',
                            maxLines: 1,
                            style: TextStyle(
                              color: addresscolor,
                              fontSize: addresssize.toDouble(),
                              fontFamily: addressfont != null
                                  ? addressfont['font']
                                  : null,
                            ),
                          ),
                        ],
                      ))
                    ],
                  ))),
        ]));
  }
  if (frameno == 15) {
    return Container(
      decoration: const BoxDecoration(),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(top: 5, bottom: 5),
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    colors: [Color(0xffd20b82), Color(0xff300c4a)])),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Center(
                    child: CircleAvatar(
                      radius: MediaQuery.of(context).size.width / 14,
                      backgroundColor: whitecolor,
                      foregroundColor: whitecolor,
                      child: CircleAvatar(
                        radius: MediaQuery.of(context).size.width / 15,
                        backgroundColor: blackcolor,
                        backgroundImage: profileuploadedimage != null
                            ? FileImage(profileuploadedimage)
                            : Image.network(
                                profilevalue == null
                                    ? url
                                    : "$weburl/${profilevalue["profile_img"]}",
                              ).image,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 8,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          FittedBox(
                            child: Text(
                              profilevalue == null
                                  ? 'Mauli computers & multi Service'
                                  : profilevalue['name'],
                              maxLines: 1,
                              style: TextStyle(
                                color: namecolor,
                                fontSize: namesize.toDouble(),
                                fontFamily:
                                    namefont != null ? namefont['font'] : null,
                              ),
                            ),
                          ),
                          FittedBox(
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Colors.yellow,
                                border: Border.all(color: whitecolor, width: 2),
                                borderRadius: const BorderRadius.only(
                                    bottomLeft: Radius.circular(25),
                                    topLeft: Radius.circular(25)),
                              ),
                              child: Text(
                                "केंद्र एक सेवा अनेक",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    foreground: Paint()
                                      ..shader = const LinearGradient(colors: [
                                        Color(0xff870f2e),
                                        Color(0xff300c4a)
                                      ]).createShader(
                                          const Rect.fromLTRB(2, 3, 2, 2))),
                              ),
                            ),
                          )
                        ],
                      ),
                      FittedBox(
                        child: Text(
                          profilevalue == null
                              ? 'Mauli computers & multi Service'
                              : profilevalue['name'],
                          softWrap: true,
                          maxLines: 1,
                          style: TextStyle(
                            color: namecolor,
                            fontSize: namesize.toDouble(),
                            fontFamily:
                                namefont != null ? namefont['font'] : null,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          FittedBox(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                FittedBox(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Icon(
                          Icons.call,
                          size: 20,
                          color: numbercolor,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          profilevalue == null
                              ? '1234567890'
                              : profilevalue['mobileno'],
                          maxLines: 1,
                          style: TextStyle(
                            color: numbercolor,
                            fontSize: numbersize.toDouble(),
                            fontFamily:
                                numberfont != null ? numberfont['font'] : null,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                FittedBox(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Icon(
                          Icons.email,
                          size: 20,
                          color: emailcolor,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          profilevalue == null
                              ? 'Clickonadd@gmail.com'
                              : profilevalue['email'],
                          maxLines: 1,
                          style: TextStyle(
                            color: emailcolor,
                            fontSize: emailsize.toDouble(),
                            fontFamily:
                                emailfont != null ? emailfont['font'] : null,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                FittedBox(
                    child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.location_on,
                        size: 20,
                        color: whitecolor,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        'Near SBI Bank,Keshav Nagar',
                        maxLines: 1,
                        style: TextStyle(
                          color: addresscolor,
                          fontSize: addresssize.toDouble(),
                          fontFamily:
                              addressfont != null ? addressfont['font'] : null,
                        ),
                      ),
                    ],
                  ),
                ))
              ],
            ),
          ),
        ],
      ),
    );
  }
  if (frameno == 16) {
    var height = MediaQuery.of(context).size.width / 4.37;
    var width = MediaQuery.of(context).size.width * 0.94;
    return SizedBox(
        width: width,
        height: height,
        child: Stack(children: <Widget>[
          Positioned(
              top: 0,
              left: 0,
              child: Container(
                  width: width,
                  height: height,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/3.png'),
                        fit: BoxFit.fitWidth),
                  ))),
          Positioned(
              top: height / 8.4,
              left: width / 3.76,
              child: Container(
                  width: width / 5.48,
                  height: height / 1.35,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: profileuploadedimage != null
                            ? FileImage(profileuploadedimage)
                            : Image.network(
                                profilevalue == null
                                    ? url
                                    : "$weburl/${profilevalue["profile_img"]}",
                              ).image,
                        fit: BoxFit.fitWidth),
                    borderRadius:
                        const BorderRadius.all(Radius.elliptical(75, 74)),
                  ))),
          Positioned(
            top: height / 9,
            left: width / 31,
            child: SizedBox(
              width: width,
              height: height / 2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 4,
                    child: Text(
                      profilevalue == null
                          ? 'Mauli computers & multi Service'
                          : profilevalue['name'],
                      maxLines: 2,
                      softWrap: true,
                      style: TextStyle(
                        color: namecolor,
                        fontSize: namesize.toDouble(),
                        fontFamily: namefont != null ? namefont['font'] : null,
                      ),
                    ),
                  ),
                  Expanded(flex: 2, child: Container()),
                  Expanded(
                    flex: 7,
                    child: SizedBox(
                      child: Text(
                        profilevalue == null
                            ? 'Mauli computers & multi Service'
                            : profilevalue['name'],
                        softWrap: true,
                        style: TextStyle(
                          color: namecolor,
                          fontSize: namesize.toDouble(),
                          fontFamily:
                              namefont != null ? namefont['font'] : null,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
              top: height / 1.6,
              left: width / 41,
              child: SizedBox(
                width: width * .96,
                height: height / 3.125,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 3,
                      child: FittedBox(
                        fit: BoxFit.fill,
                        child: Row(
                          children: [
                            Icon(
                              Icons.call,
                              size: 20,
                              color: numbercolor,
                            ),
                            const SizedBox(width: 5),
                            Text(
                              profilevalue == null
                                  ? '1234567890'
                                  : profilevalue['mobileno'],
                              maxLines: 1,
                              style: TextStyle(
                                color: numbercolor,
                                fontSize: numbersize.toDouble(),
                                fontFamily: numberfont != null
                                    ? numberfont['font']
                                    : null,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(flex: 3, child: Container()),
                    Expanded(
                        flex: 7,
                        child: FittedBox(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.location_on,
                                size: 20,
                                color: addresscolor,
                              ),
                              const SizedBox(width: 5),
                              Text(
                                'Near SBI Bank,Keshav Nagar',
                                maxLines: 1,
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
                        )),
                  ],
                ),
              )),
        ]));
  }
  if (frameno == 17) {
    var height = MediaQuery.of(context).size.width / 4.37;
    var width = MediaQuery.of(context).size.width * 0.94;
    return SizedBox(
        width: width,
        height: height,
        child: Stack(children: <Widget>[
          Positioned(
              top: 0,
              left: 0,
              child: Container(
                  width: width,
                  height: height,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/4.png'),
                        fit: BoxFit.fitWidth),
                  ))),
          Positioned(
              top: height / 7.8,
              left: width / 15.22,
              child: Container(
                  width: width / 5.48,
                  height: height / 1.35,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: profileuploadedimage != null
                            ? FileImage(profileuploadedimage)
                            : Image.network(
                                profilevalue == null
                                    ? url
                                    : "$weburl/${profilevalue["profile_img"]}",
                              ).image,
                        fit: BoxFit.fitWidth),
                    borderRadius:
                        const BorderRadius.all(Radius.elliptical(75, 74)),
                  ))),
          Positioned(
            top: height / 1.44,
            left: width / 2.81,
            child: Text(
              'Near SBI Bank,Keshav Nagar',
              maxLines: 1,
              style: TextStyle(
                color: addresscolor,
                fontSize: addresssize.toDouble(),
                fontFamily: addressfont != null ? addressfont['font'] : null,
              ),
            ),
          ),
          Positioned(
              // top: height / 9.09,
              left: width / 3.18,
              child: SizedBox(
                width: width / 1.5,
                height: height / 1.5,
                child: FittedBox(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FittedBox(
                        child: Text(
                          profilevalue == null
                              ? 'Mauli computers & multi Service'
                              : profilevalue['name'],
                          softWrap: true,
                          maxLines: 2,
                          style: TextStyle(
                            color: namecolor,
                            fontSize: namesize.toDouble(),
                            fontFamily:
                                namefont != null ? namefont['font'] : null,
                          ),
                        ),
                      ),
                      FittedBox(
                        child: Row(
                          children: [
                            Icon(
                              Icons.email,
                              size: 10,
                              color: emailcolor,
                            ),
                            const SizedBox(width: 5),
                            Text(
                              profilevalue == null
                                  ? 'Clickonadd@gmail.com'
                                  : profilevalue['email'],
                              maxLines: 1,
                              style: TextStyle(
                                color: emailcolor,
                                fontSize: emailsize.toDouble(),
                                fontFamily: emailfont != null
                                    ? emailfont['font']
                                    : null,
                              ),
                            ),
                          ],
                        ),
                      ),
                      FittedBox(
                        fit: BoxFit.fill,
                        child: Row(
                          children: [
                            Icon(
                              Icons.call,
                              size: 10,
                              color: numbercolor,
                            ),
                            const SizedBox(width: 5),
                            Text(
                              profilevalue == null
                                  ? '1234567890'
                                  : profilevalue['mobileno'],
                              maxLines: 1,
                              style: TextStyle(
                                color: numbercolor,
                                fontSize: numbersize.toDouble(),
                                fontFamily: numberfont != null
                                    ? numberfont['font']
                                    : null,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )),
        ]));
  }
  if (frameno == 18) {
    var height = MediaQuery.of(context).size.width / 4.37;
    var width = MediaQuery.of(context).size.width * 0.94;
    return SizedBox(
        width: width,
        height: height,
        child: Stack(children: <Widget>[
          Positioned(
              top: 0,
              left: 0,
              child: Container(
                  width: width,
                  height: height,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/5.png'),
                        fit: BoxFit.fitWidth),
                  ))),
          Positioned(
              top: height / 7,
              left: width / 2.41,
              child: Container(
                  width: width / 5.87,
                  height: width / 5.87,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: profileuploadedimage != null
                            ? FileImage(profileuploadedimage)
                            : Image.network(
                                profilevalue == null
                                    ? url
                                    : "$weburl/${profilevalue["profile_img"]}",
                              ).image,
                        fit: BoxFit.fitWidth),
                    borderRadius:
                        const BorderRadius.all(Radius.elliptical(70, 70)),
                  ))),
          Positioned(
            top: height / 9.8,
            left: width / 100,
            child: SizedBox(
              width: width,
              height: height / 2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 5,
                    child: Text(
                      profilevalue == null
                          ? 'Mauli computers & multi Service'
                          : profilevalue['name'],
                      softWrap: true,
                      maxLines: 2,
                      style: TextStyle(
                        color: namecolor,
                        fontSize: namesize.toDouble(),
                        fontFamily: namefont != null ? namefont['font'] : null,
                      ),
                    ),
                  ),
                  const Expanded(flex: 2, child: SizedBox()),
                  const Expanded(flex: 5, child: SizedBox())
                ],
              ),
            ),
          ),
          Positioned(
              top: height / 1.85,
              // left: 17,
              child: SizedBox(
                width: width,
                height: height / 2.3,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 5,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: FittedBox(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              FittedBox(
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.call,
                                      size: 10,
                                      color: numbercolor,
                                    ),
                                    const SizedBox(width: 5),
                                    Text(
                                      profilevalue == null
                                          ? '1234567890'
                                          : profilevalue['mobileno'],
                                      maxLines: 1,
                                      style: TextStyle(
                                        color: numbercolor,
                                        fontSize: numbersize.toDouble(),
                                        fontFamily: numberfont != null
                                            ? numberfont['font']
                                            : null,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              FittedBox(
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.email,
                                      size: 10,
                                      color: emailcolor,
                                    ),
                                    const SizedBox(width: 5),
                                    Text(
                                      profilevalue == null
                                          ? 'Clickonadd@gmail.com'
                                          : profilevalue['email'],
                                      maxLines: 1,
                                      style: TextStyle(
                                        color: emailcolor,
                                        fontSize: emailsize.toDouble(),
                                        fontFamily: emailfont != null
                                            ? emailfont['font']
                                            : null,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const Expanded(flex: 2, child: SizedBox()),
                    Expanded(
                        flex: 5,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.location_on,
                                  size: 20,
                                  color: addresscolor,
                                ),
                                const SizedBox(width: 5),
                                Flexible(
                                  child: Text(
                                    'Near SBI Bank,Keshav Nagar',
                                    maxLines: 2,
                                    softWrap: true,
                                    style: TextStyle(
                                      color: addresscolor,
                                      fontSize: addresssize.toDouble(),
                                      fontFamily: addressfont != null
                                          ? addressfont['font']
                                          : null,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox()
                          ],
                        ))
                  ],
                ),
              )),
        ]));
  }
  if (frameno == 19) {
    var height = MediaQuery.of(context).size.width / 4.37;
    var width = MediaQuery.of(context).size.width * 0.94;
    return SizedBox(
        width: width,
        height: height,
        child: Stack(children: <Widget>[
          Positioned(
              top: 0,
              left: 0,
              child: Container(
                  width: width,
                  height: height,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/6.png'),
                        fit: BoxFit.fitWidth),
                  ))),
          Positioned(
              top: height / 6.8,
              left: width / 12.8,
              child: Container(
                  width: width / 5.87,
                  height: width / 5.87,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: profileuploadedimage != null
                            ? FileImage(profileuploadedimage)
                            : Image.network(
                                profilevalue == null
                                    ? url
                                    : "$weburl/${profilevalue["profile_img"]}",
                              ).image,
                        fit: BoxFit.fitWidth),
                    borderRadius:
                        const BorderRadius.all(Radius.elliptical(70, 70)),
                  ))),
          Positioned(
              left: width / 3.9,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: height / 1.1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FittedBox(
                        child: Row(
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.person,
                                  size: 20,
                                  color: namecolor,
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  profilevalue == null
                                      ? 'Mauli computers & multi Service'
                                      : profilevalue['name'],
                                  maxLines: 1,
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
                          ],
                        ),
                      ),
                      SizedBox(
                        width: width / 4.5,
                        child: FittedBox(
                          child: Row(
                            children: [
                              Icon(
                                Icons.call,
                                size: 20,
                                color: numbercolor,
                              ),
                              const SizedBox(width: 5),
                              Text(
                                profilevalue == null
                                    ? '1234567890'
                                    : profilevalue['mobileno'],
                                style: TextStyle(
                                  color: numbercolor,
                                  fontSize: numbersize.toDouble(),
                                  fontFamily: numberfont != null
                                      ? numberfont['font']
                                      : null,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      // FittedBox(
                      //   child: Row(
                      //     children: [
                      //       CircleAvatar(
                      //           radius: 8,
                      //           backgroundColor: othercolorvalue,
                      //           child: Icon(
                      //             Icons.email,
                      //             size: 20,
                      //             color: whitecolor,
                      //           )),
                      //       const SizedBox(width: 5),
                      //       Text(
                      //         profilevalue == null
                      //             ? 'Clickonadd@gmail.com'
                      //             : profilevalue['email'],
                      //         maxLines: 1,
                      //         style: TextStyle(
                      //           color: othercolorvalue,
                      //           fontSize: othersizevalue.toDouble(),
                      //           fontFamily: otherfontvalue != null
                      //               ? otherfontvalue['font']
                      //               : null,
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      FittedBox(
                        child: Row(
                          children: [
                            Icon(
                              Icons.language_sharp,
                              size: 20,
                              color: emailcolor,
                            ),
                            const SizedBox(width: 5),
                            Text(
                              profilevalue == null
                                  ? 'www.clickonadd.com'
                                  : profilevalue['web_url'] ??
                                      'www.clickonadd.com',
                              maxLines: 1,
                              style: TextStyle(
                                color: emailcolor,
                                fontSize: emailsize.toDouble(),
                                fontFamily: emailfont != null
                                    ? emailfont['font']
                                    : null,
                              ),
                            ),
                          ],
                        ),
                      ),
                      FittedBox(
                        child: Row(
                          children: [
                            Icon(
                              Icons.location_on,
                              size: 20,
                              color: addresscolor,
                            ),
                            const SizedBox(width: 5),
                            Text(
                              'Near SBI Bank,Keshav Nagar',
                              maxLines: 1,
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
                      )
                    ],
                  ),
                ),
              )),
          Positioned(
            top: height / 2.7,
            left: width / 1.84,
            child: FittedBox(
              child: Text(
                profilevalue == null
                    ? 'Mauli computers & multi Service'
                    : profilevalue['name'],
                softWrap: true,
                maxLines: 1,
                style: TextStyle(
                  color: namecolor,
                  fontSize: namesize.toDouble(),
                  fontFamily: namefont != null ? namefont['font'] : null,
                ),
              ),
            ),
          ),
        ]));
  }
}
