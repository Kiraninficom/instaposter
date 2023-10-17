import 'dart:convert';

import 'package:click/pages/bottom_navigation/quotes_category.dart';
import 'package:click/pages/bottom_navigation/showall_category.dart';
import 'package:click/pages/bottom_navigation/showall_option.dart';
import 'package:click/pages/bottom_navigation/subcategory_page.dart';
import 'package:click/pages/getapi.dart';
import 'package:click/pages/poster_image.dart';
import 'package:click/pages/todaysposter.dart';
import 'package:click/utils/constants.dart';
import 'package:click/utils/navigation.dart';
import 'package:click/utils/styles.dart';
import 'package:click/widgets/category.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:click/pages/authcredential.dart';
import 'package:intl/intl.dart';

class Festivalcategory extends StatefulWidget {
  const Festivalcategory({Key? key}) : super(key: key);

  @override
  State<Festivalcategory> createState() => _FestivalcategoryState();
}

class _FestivalcategoryState extends State<Festivalcategory> {
  getlogodata() async {
    var logo = await Authcredential().getfromlocal("logo");
    SentApi().getlogoservices().then((value) {
      setState(() {});
    });
    setState(() {
      designlogo = jsonDecode(logo);
    });
  }

  @override
  void didUpdateWidget(Festivalcategory oldWidget) {
    super.didUpdateWidget(oldWidget);

    setState(() {});
  }

  getfestival() async {
    var festival = await Authcredential().getfromlocal("festival");
    SentApi().getfestivalposter().then((value) {
      setState(() {
        getseprate();
      });
    });
    setState(() {
      festivalposter = jsonDecode(festival);
      alldataget = true;
    });
    getseprate();
  }

  getseprate() {
    todaysfestival.clear();
    tommorowfestival.clear();
    for (int i = 0; i < festivalposter.length; i++) {
      DateFormat dateFormat = DateFormat('yyyy-MM-dd');
      String formattedDate = dateFormat.format(todaydate);
      DateTime date1 = DateTime.parse(formattedDate);
      DateTime date2 = DateTime.parse(festivalposter[i]['date']);
      var difference = date2.difference(date1).inDays;
      if (difference == 0) {
        setState(() {
          todaysfestival.add(festivalposter[i]);
        });
      }
      if (difference == 1) {
        setState(() {
          tommorowfestival.add(festivalposter[i]);
        });
      }
    }
    setState(() {
      alldataget = true;
    });
  }

  getquotescategory() async {
    var quotes = await Authcredential().getfromlocal("quotescategory");
    SentApi().getqutoscategory().then((value) {
      setState(() {});
    });
    setState(() {
      quotescategory = jsonDecode(quotes);
    });
  }

  getquotesposter() async {
    var quotesposter = await Authcredential().getfromlocal("quotesposter");
    SentApi().getqutosposterimiages().then((value) {
      setState(() {});
    });
    setState(() {
      quotesposterimages = jsonDecode(quotesposter);
      alldataget = true;
    });
  }

  getgreetingdata() async {
    var cscbasic = await Authcredential().getfromlocal("greetingbasic");
    SentApi().getgreetingbasic().then((value) {
      setState(() {});
    });
    setState(() {
      greetingcategory = jsonDecode(cscbasic);
    });
  }

  getgreetingsubdata() async {
    var cscsubservice = await Authcredential().getfromlocal("greetingsub");
    SentApi().getgreetingsubservices().then((value) {
      setState(() {});
    });
    setState(() {
      greetingssubservice = jsonDecode(cscsubservice);
    });
  }

  getgreetingimage() async {
    var cscimage = await Authcredential().getfromlocal("greetingimage");
    SentApi().getgreetingimage().then((value) {
      setState(() {});
    });
    setState(() {
      greetingimage = jsonDecode(cscimage);
    });
  }

  @override
  void initState() {
    super.initState();
    getlogodata();
    getfestival();
    getquotescategory();
    getquotesposter();
    getgreetingdata();
    getgreetingsubdata();
    getgreetingimage();
  }

  Widget header(String title, {var onpress, catlength}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        color: primaryColor,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: TextStyle(
                    color: whitecolor, fontSize: 15, fontFamily: "Poppin"),
              ),
              catlength > 3 ? const Spacer() : const SizedBox.shrink(),
              catlength > 3
                  ? InkWell(
                      onTap: onpress,
                      child: Text(
                        "Show All",
                        style: TextStyle(
                            color: whitecolor, fontWeight: FontWeight.bold),
                      ))
                  : const SizedBox.shrink(),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.width / 3;

    return RefreshIndicator(
      onRefresh: () async {
        getlogodata();
        getfestival();
        getquotescategory();
        getquotesposter();
        getgreetingdata();
        getgreetingsubdata();
        getgreetingimage();
      },
      child: ListView(
        children: [
          header('Today\'s Festival', onpress: () {
            toScreen(
                context,
                TodaysPoster(
                  popupvalue: 'festival',
                  title: "Today festival",
                  selected: 0,
                  subimages: festivalposter,
                  activewatermark: false,
                  tommorow: false,
                ));
          }, catlength: todaysfestival.isEmpty ? 1 : todaysfestival.length),
          todaysfestival.isEmpty
              ? alldataget
                  ? Center(child: Text("No Values"))
                  : Center(
                      child: Image.asset(
                      "assets/loading.gif",
                      height: 100,
                    ))
              : SizedBox(
                  height: height,
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: const ScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                    ),
                    itemCount:
                        todaysfestival.length > 3 ? 3 : todaysfestival.length,
                    itemBuilder: (BuildContext context, int index) {
                      if (todaysfestival[index]['subcategory_image'] == "") {
                        return Category(title: 'now value', imagePath: url);
                      } else {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: () {
                              toScreen(
                                  context,
                                  TodaysPoster(
                                    activewatermark: false,
                                    popupvalue: 'festival',
                                    title: "Today festival",
                                    selected: 0,
                                    subimages: festivalposter,
                                    tommorow: false,
                                  ));
                            },
                            child: CategoryGrid(
                              imagePath:
                                  '$weburl/${todaysfestival[index]['subcategory_image']}',
                            ),
                          ),
                        );
                      }
                    },
                  ),
                ),
          header('Greeting', onpress: () {
            toScreen(
                context,
                Showallcategory(
                  activewatermark: false,
                  greeting: true,
                  popupvalue: "csc",
                  value: greetingcategory,
                  subimage: greetingimage,
                  subvalue: greetingssubservice,
                  cat: 'Greeting',
                ));
          }, catlength: greetingcategory.isEmpty ? 1 : greetingcategory.length),
          greetingcategory.isEmpty
              ? alldataget
                  ? Center(child: Text("No Values"))
                  : Center(
                      child: Image.asset(
                      "assets/loading.gif",
                      height: 100,
                    ))
              : SizedBox(
                  height: height,
                  child: GridView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    physics: const ScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 1,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10),
                    itemCount: greetingcategory.length,
                    itemBuilder: (BuildContext context, int index) {
                      //print('ca $greetingcategory');
                      //print('sub $greetingssubservice');
                      //print('image $greetingimage');
                      if (greetingcategory[index]['category_image'] == "") {
                        return Category(title: 'now value', imagePath: url);
                      } else {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: () {
                              toScreen(
                                  context,
                                  Posterimages(
                                    enablegreeting: true,
                                    activewatermark: false,
                                    popupvalue: "csc",
                                    id: greetingcategory[index]['id'],
                                    subimages: greetingimage,
                                    subcat: greetingssubservice,
                                  ));
                            },
                            child: CategoryGrid(
                              // title:
                              //     "${onlineserviceposter[index]['category_name']}",
                              imagePath:
                                  '$weburl/${greetingcategory[index]['category_image']}',
                            ),
                          ),
                        );
                      }
                    },
                  ),
                ),
          header('Quotes', onpress: () {
            toScreen(
                context,
                Quotescategory(
                  value: quotescategory,
                  subvalue: quotesposterimages,
                  cat: 'Quotes',
                ));
          }, catlength: quotescategory.isEmpty ? 1 : quotescategory.length),
          quotescategory.isEmpty
              ? alldataget
                  ? Center(child: Text("No Values"))
                  : Center(
                      child: Image.asset(
                      "assets/loading.gif",
                      height: 100,
                    ))
              : SizedBox(
                  height: height,
                  child: GridView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    physics: const ScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 1,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10),
                    itemCount: quotescategory.length,
                    itemBuilder: (BuildContext context, int index) {
                      if (quotescategory[index]['image'] == "") {
                        return Category(title: 'now value', imagePath: url);
                      } else {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: () {
                              List subvalue = [];
                              for (var id in quotesposterimages) {
                                subvalue.add({
                                  "subcategory_image": id['image'],
                                  "service": id['category'],
                                  'language': id['language'] ?? 'marathi',
                                  'rate': id['rate'],
                                });
                              }
                              toScreen(
                                  context,
                                  Posterimages(
                                    activewatermark: false,
                                    popupvalue: 'quotes',
                                    id: quotescategory[index]['id'],
                                    subcat: null,
                                    subimages: subvalue,
                                  ));
                            },
                            child: CategoryGrid(
                              // width: MediaQuery.of(context).size.width / 4.5,
                              // height: MediaQuery.of(context).size.width > 420
                              //     ? MediaQuery.of(context).size.height * .2
                              //     : MediaQuery.of(context).size.height * .1,
                              // title: "${quotescategory[index]['category']}",
                              imagePath:
                                  '$weburl/${quotescategory[index]['image']}',
                            ),
                          ),
                        );
                      }
                    },
                  ),
                ),

          header('Tommorow\'s Festival', onpress: () {
            toScreen(
                context,
                TodaysPoster(
                  activewatermark: false,
                  popupvalue: 'festival',
                  title: "Tommorow festival",
                  selected: 1,
                  subimages: festivalposter,
                  tommorow: true,
                ));
          }, catlength: tommorowfestival.length),
          tommorowfestival.isEmpty
              ? alldataget
                  ? Center(child: Text("No Values"))
                  : Center(
                      child: Image.asset(
                      "assets/loading.gif",
                      height: 100,
                    ))
              : SizedBox(
                  height: height,
                  child: GridView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    physics: const ScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                    ),
                    itemCount: tommorowfestival.length > 3
                        ? 3
                        : tommorowfestival.length,
                    itemBuilder: (BuildContext context, int index) {
                      if (tommorowfestival[index]['subcategory_image'] == "") {
                        return Category(title: 'now value', imagePath: url);
                      } else {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: () {
                              toScreen(
                                  context,
                                  TodaysPoster(
                                    activewatermark: false,
                                    popupvalue: 'festival',
                                    title: "Tommorow festival",
                                    selected: 1,
                                    subimages: festivalposter,
                                    tommorow: true,
                                  ));
                            },
                            child: CategoryGrid(
                              // width: MediaQuery.of(context).size.width / 4,
                              // height: MediaQuery.of(context).size.width > 420
                              //     ? MediaQuery.of(context).size.height * .2
                              //     : MediaQuery.of(context).size.height * .1,
                              // title: "${tommorowfestival[index]['poster_name']}",
                              imagePath:
                                  '$weburl/${tommorowfestival[index]['subcategory_image']}',
                            ),
                          ),
                        );
                      }
                    },
                  ),
                ),
          // header('Buisness Category', onpress: () {
          //   toScreen(
          //       context,
          //       Showallcategory(
          //         value: buisnesscategory,
          //         subimage: buisnesssubservice,
          //         subvalue: buisnessimage,
          //         cat: 'Buisness Category',
          //       ));
          // }, catlength: buisnesscategory.isEmpty ? 1 : buisnesscategory.length),
          // buisnesscategory.isEmpty
          //     ? alldataget
          //         ? Center(child: Text("No Values"))
          //         : Center(
          //             child: Image.asset(
          //             "assets/loading.gif",
          //             height: 100,
          //           ))
          //     : GridView.builder(
          //         shrinkWrap: true,
          //         physics: const ScrollPhysics(),
          //         gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          //             crossAxisCount: 3,
          //             mainAxisSpacing: 0,
          //             crossAxisSpacing: 0),
          //         itemCount:
          //             buisnesscategory.length > 3 ? 3 : buisnesscategory.length,
          //         itemBuilder: (BuildContext context, int index) {
          //           if (buisnesscategory[index]['category_image'] == "") {
          //             return Category(title: 'now value', imagePath: url);
          //           } else {
          //             return InkWell(
          //               onTap: () {
          //                 toScreen(
          //                     context,
          //                     Subcategory(
          //                       value: buisnesscategory[index]['id'],
          //                       catname: buisnesscategory[index]
          //                           ['category_name'],
          //                       subcategory: buisnesssubservice,
          //                       subcategoryimage: buisnessimage,
          //                     ));
          //               },
          //               child: Category(
          //                 title: "${buisnesscategory[index]['category_name']}",
          //                 imagePath:
          //                     '$weburl/${buisnesscategory[index]['category_image']}',
          //               ),
          //             );
          //           }
          //         },
          //       ),
          header('Design Logo', onpress: () {
            toScreen(
                context,
                Showalloption(
                  data: designlogo,
                  cat: 'Design Logo',
                ));
          }, catlength: designlogo.isEmpty ? 1 : designlogo.length),
          designlogo.isEmpty
              ? alldataget
                  ? Center(child: Text("No Values"))
                  : Center(
                      child: Image.asset(
                      "assets/loading.gif",
                      height: 100,
                    ))
              : SizedBox(
                  height: height,
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: const ScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                    ),
                    itemCount: designlogo.length,
                    itemBuilder: (BuildContext context, int index) {
                      if (designlogo[index]['logo'] == "") {
                        return Category(title: 'now value', imagePath: url);
                      } else {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: () {
                              toScreen(
                                  context,
                                  Showalloption(
                                    data: designlogo,
                                    cat: 'Design Logo',
                                  ));
                            },
                            child: CategoryGrid(
                              imagePath: '$weburl/${designlogo[index]['logo']}',
                            ),
                          ),
                        );
                      }
                    },
                  ),
                ),
        ],
      ),
    );
  }
}
