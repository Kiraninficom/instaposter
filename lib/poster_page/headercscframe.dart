import 'package:click/utils/constants.dart';
import 'package:click/utils/styles.dart';
import 'package:flutter/material.dart';

getcscheader(
  BuildContext context, {
  var profilevalue,
  var frameno,
  var buisnessnameenable,
  var buisnessnamesize,
  var buisnessnamefont,
  var buisnessnamecolor,
  var logoenable,
  var logosize,
}) {
  var logo = profilevalue['users_logo'] == null ? 'csc_logo' : 'users_logo';
  var bname = profilevalue['business_name'] ?? profilevalue['name'];
  if (frameno == 7) {
    return Row(
      children: [
        (profilevalue["$logo"] == null || logoenable == false)
            ? logoenable == false
                ? SizedBox.shrink()
                : Padding(
                    padding: const EdgeInsets.only(
                        left: 5.0, top: 5, right: 2, bottom: 2),
                    child: Container(
                        width: logosize - 25,
                        height: logosize - 25,
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
                    left: 5.0, top: 5, right: 2, bottom: 2),
                child: Container(
                    width: logosize - 25,
                    height: logosize - 25,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: Image.network(
                            profilevalue == null
                                ? url
                                : "$weburl/${profilevalue["$logo"]}",
                          ).image,
                          fit: BoxFit.fill),
                    )),
              ),
        Expanded(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            bname == null || buisnessnameenable == false
                ? SizedBox.shrink()
                : Padding(
                    padding: const EdgeInsets.only(
                        left: 2.0, top: 10, right: 4, bottom: 2),
                    child: RichText(
                        text: TextSpan(
                      text: bname,
                      style: TextStyle(
                        color: buisnessnamecolor ?? blackcolor,
                        fontSize: buisnessnamesize.toDouble() + 2,
                        fontWeight: FontWeight.bold,
                        fontFamily: buisnessnamefont != null
                            ? buisnessnamefont['font']
                            : "TiroDevanagariMarathi-Regular",
                      ),
                    )),
                  ),
            FittedBox(
              child: Row(
                children: const [
                  Padding(
                    padding: const EdgeInsets.only(top: 3.0, left: 3, right: 3),
                    child: Text("आपले सरकार सेवा केंद्र",
                        style: TextStyle(
                            color: Color(0xfff60000),
                            fontFamily: "balbharati")),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 3.0, left: 3, right: 3),
                    child:
                        Text("|", style: TextStyle(color: Color(0xff050048))),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 3.0, left: 3, right: 3),
                    child: Text("कॉमन सर्विस सेंटर",
                        style: TextStyle(
                            color: Color(0xff050048),
                            fontFamily: "balbharati")),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 3.0, left: 3, right: 3),
                    child:
                        Text("|", style: TextStyle(color: Color(0xffae00bd))),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 3.0, left: 3, right: 3),
                    child: Text("बँकिंग सर्विसेस",
                        style: TextStyle(
                            color: Color(0xffae00bd),
                            fontFamily: "balbharati")),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 3.0, left: 3, right: 3),
                    child:
                        Text("|", style: TextStyle(color: Color(0xff9a1800))),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 3.0, left: 3, right: 10),
                    child: Text("डी बी टी सर्विसेस",
                        style: TextStyle(
                            color: Color(0xff9a1800),
                            fontFamily: "balbharati")),
                  ),
                ],
              ),
            ),
          ],
        ))
      ],
    );
  }
  if (frameno == 8) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        bname == null || buisnessnameenable == false
            ? SizedBox.shrink()
            : Padding(
                padding: const EdgeInsets.only(
                    left: 2.0, top: 10, right: 2, bottom: 2),
                child: RichText(
                    text: TextSpan(
                  text: bname,
                  style: TextStyle(
                    color: buisnessnamecolor ?? whitecolor,
                    fontSize: buisnessnamesize.toDouble() + 2,
                    fontWeight: FontWeight.bold,
                    fontFamily: buisnessnamefont != null
                        ? buisnessnamefont['font']
                        : "TiroDevanagariMarathi-Regular",
                  ),
                )),
              ),
        FittedBox(
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 3.0, left: 3, right: 3),
                child: Text("आपले सरकार सेवा केंद्र",
                    style:
                        TextStyle(color: whitecolor, fontFamily: "balbharati")),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 3.0, left: 3, right: 3),
                child: Text("|", style: TextStyle(color: whitecolor)),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 3.0, left: 3, right: 3),
                child: Text("कॉमन सर्विस सेंटर",
                    style:
                        TextStyle(color: whitecolor, fontFamily: "balbharati")),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 3.0, left: 3, right: 3),
                child: Text("|", style: TextStyle(color: whitecolor)),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 3.0, left: 3, right: 3),
                child: Text("बँकिंग सर्विसेस",
                    style:
                        TextStyle(color: whitecolor, fontFamily: "balbharati")),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 3.0, left: 3, right: 3),
                child: Text("|", style: TextStyle(color: whitecolor)),
              ),
              Padding(
                padding: EdgeInsets.only(top: 3.0, left: 3, right: 10),
                child: Text("डी बी टी सर्विसेस",
                    style:
                        TextStyle(color: whitecolor, fontFamily: "balbharati")),
              ),
            ],
          ),
        ),
      ],
    );
  } else {
    return SizedBox.shrink();
  }
}
