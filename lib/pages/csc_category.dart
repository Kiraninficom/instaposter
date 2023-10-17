// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:convert';
import 'package:click/pages/bottom_navigation/quotes_category.dart';
import 'package:click/pages/bottom_navigation/showall_option.dart';
import 'package:click/pages/getapi.dart';
import 'package:click/pages/poster_image.dart';
import 'package:click/pages/todaysposter.dart';
import 'package:click/pages/authcredential.dart';
import 'package:click/pages/bottom_navigation/showall_category.dart';
import 'package:click/pages/bottom_navigation/subcategory_page.dart';
import 'package:click/utils/constants.dart';
import 'package:click/utils/navigation.dart';
import 'package:click/utils/styles.dart';
import 'package:click/widgets/category.dart';
import 'package:flutter/material.dart';

class Csccategory extends StatefulWidget {
  var onlineposter;
  Csccategory({
    Key? key,
    this.onlineposter,
  }) : super(key: key);

  @override
  State<Csccategory> createState() => _CsccategoryState();
}

class _CsccategoryState extends State<Csccategory> {
  var todayposterlist = ["Job", "Festival", "Scheme"];

  getcscdata() async {
    var cscbasic = await Authcredential().getfromlocal("cscbasic");
    SentApi().getcscbasic().then((value) {
      setState(() {});
    });
    setState(() {
      onlineserviceposter = jsonDecode(cscbasic);
    });
  }

  getcscsubdata() async {
    var cscsubservice = await Authcredential().getfromlocal("cscsub");
    SentApi().getcscsubservices().then((value) {
      setState(() {});
    });
    setState(() {
      onlinesubservice = jsonDecode(cscsubservice);
    });
  }

  getcscimage() async {
    var cscimage = await Authcredential().getfromlocal("cscimage");
    SentApi().getcscimage().then((value) {
      setState(() {});
    });
    setState(() {
      onlineimage = jsonDecode(cscimage);
    });
  }

  @override
  void didUpdateWidget(Csccategory oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget == widget.onlineposter) {
      setState(() {});
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    setState(() {});
  }
  // getbuisnessdata() async {
  //   var buisness = await Authcredential().getfromlocal("buisnessbasic");
  //   SentApi().getbuisnessbasic();
  //   setState(() {
  //     buisnesscategory = jsonDecode(buisness);
  //   });
  // }

  // getbuisnesssubdata() async {
  //   var buisnessub = await Authcredential().getfromlocal("buisnesssub");
  //   SentApi().getbuisnesssubservices();
  //   setState(() {
  //     buisnesssubservice = jsonDecode(buisnessub);
  //   });
  // }

  // getbuisnessimage() async {
  //   var buisnessimag = await Authcredential().getfromlocal("buisnessimage");
  //   SentApi().getbuisnessimage();
  //   setState(() {
  //     buisnessimage = jsonDecode(buisnessimag);
  //   });
  // }

  getlogodata() async {
    var logo = await Authcredential().getfromlocal("logo");
    SentApi().getlogoservices().then((value) {
      setState(() {});
    });
    setState(() {
      designlogo = jsonDecode(logo);
    });
  }

  getfacebookdata() async {
    var facebook = await Authcredential().getfromlocal("facebook");
    SentApi().getfacebookservices().then((value) {
      setState(() {});
    });
    setState(() {
      facebookcover = jsonDecode(facebook);
    });
  }

  getjobbasicdata() async {
    var jobsbasicca = await Authcredential().getfromlocal("jobbasic");
    SentApi().getjobbasic().then((value) {
      setState(() {});
    });
    setState(() {
      jobcategory = jsonDecode(jobsbasicca);
    });
  }

  getjobsubdata() async {
    var jobsubca = await Authcredential().getfromlocal("jobsub");
    SentApi().getjobsubservices().then((value) {
      setState(() {});
    });
    setState(() {
      jobsubservicelist = jsonDecode(jobsubca);
    });
  }

  getjobdata() async {
    var jobimag = await Authcredential().getfromlocal("jobimage");
    SentApi().getjobimage().then((value) {
      setState(() {});
    });
    setState(() {
      jobimage = jsonDecode(jobimag);
    });
  }

  getfestival() async {
    var festival = await Authcredential().getfromlocal("festival");
    SentApi().getfestivalposter().then((value) {
      setState(() {});
    });
    setState(() {
      festivalposter = jsonDecode(festival);
    });
  }

  getschemedata() async {
    var schemeimag = await Authcredential().getfromlocal("schemeimage");
    SentApi().getschemeimage().then((value) {
      setState(() {});
    });
    setState(() {
      schemeimage = jsonDecode(schemeimag);
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

  @override
  void initState() {
    super.initState();
    // getallvalues();
  }

  getallvalues() {
    getcscdata();
    getcscimage();
    getcscsubdata();
    getlogodata();
    getjobdata();
    getschemedata();
    getfestival();
    getjobsubdata();
    getjobbasicdata();
    getquotescategory();
    getquotesposter();
    // getbuisnessdata();
    // getbuisnessimage();
    // getbuisnesssubdata();
    // getfacebookdata();
  }

  Widget header(String title, {var onpress, catlength}) {
    return Container(
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
    );
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.width / 3;
    var toadayposterimage = currentposterimages == null
        ? [
            "assets/job.png",
            "assets/festival.png",
            "assets/scheme.png",
          ]
        : [
            "$weburl/${currentposterimages[0]['jobs']}",
            "$weburl/${currentposterimages[0]['festival']}",
            "$weburl/${currentposterimages[0]['schemes']}",
          ];
    return onlineserviceposter.isEmpty &&
            designlogo.isEmpty &&
            facebookcover.isEmpty
        ? Center(
            child: Image.asset(
            "assets/loading.gif",
            height: 100,
          ))
        : SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                header('Current Poster', onpress: () {}, catlength: 1),
                schemeimage.isEmpty
                    ? alldataget
                        ? Center(child: Text("No Values"))
                        : Center(
                            child: Image.asset(
                            "assets/loading.gif",
                            height: 100,
                          ))
                    : GridView.builder(
                        shrinkWrap: true,
                        physics: const ScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                        ),
                        itemCount: todayposterlist.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: InkWell(
                              onTap: () {
                                index == 0
                                    ? toScreen(
                                        context,
                                        Subcategory(
                                          popupvalue: "job",
                                          value: jobcategory[0]['id'],
                                          catname: "JOB",
                                          subcategory: jobsubservicelist,
                                          subcategoryimage: jobimage,
                                          frompage: true,
                                        ))
                                    : toScreen(
                                        context,
                                        TodaysPoster(
                                          popupvalue: "scheme",
                                          title: todayposterlist[index],
                                          index: index,
                                          subimages: index == 2
                                              ? schemeimage
                                              : festivalposter,
                                        ));
                              },
                              child: CategoryGrid(
                                  assetsimagetrue: currentposterimages == null
                                      ? true
                                      : false,
                                  imagePath: toadayposterimage[index]),
                            ),
                          );
                        }),
                header('Online Services Poster', onpress: () {
                  toScreen(
                      context,
                      Showallcategory(
                        popupvalue: "csc",
                        value: onlineserviceposter,
                        subimage: onlineimage,
                        subvalue: onlinesubservice,
                        cat: 'Online Services Poster',
                      ));
                },
                    catlength: onlineserviceposter.isEmpty
                        ? 1
                        : onlineserviceposter.length),
                onlineserviceposter.isEmpty
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
                          itemCount: onlineserviceposter.length,
                          itemBuilder: (BuildContext context, int index) {
                            if (onlineserviceposter[index]['category_image'] ==
                                "") {
                              return Category(
                                  title: 'now value', imagePath: url);
                            } else {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: InkWell(
                                  onTap: () {
                                    toScreen(
                                        context,
                                        Posterimages(
                                          popupvalue: "csc",
                                          id: onlineserviceposter[index]['id'],
                                          subimages: onlineimage,
                                          subcat: onlinesubservice,
                                        ));
                                  },
                                  child: CategoryGrid(
                                    // title:
                                    //     "${onlineserviceposter[index]['category_name']}",
                                    imagePath:
                                        '$weburl/${onlineserviceposter[index]['category_image']}',
                                  ),
                                ),
                              );
                            }
                          },
                        ),
                      ),
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
                              return Category(
                                  title: 'now value', imagePath: url);
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
                                    imagePath:
                                        '$weburl/${designlogo[index]['logo']}',
                                  ),
                                ),
                              );
                            }
                          },
                        ),
                      ),
                // header(
                //   'Design Facebook Coverpage',
                //   onpress: () {
                //     toScreen(
                //         context,
                //         Showalloption(
                //           data: facebookcover,
                //           cat: 'Design Facebook Coverpage',
                //         ));
                //   },
                //   catlength: facebookcover.isEmpty ? 1 : facebookcover.length,
                // ),
                // facebookcover.isEmpty
                //     ? alldataget
                //         ? Center(child: Text("No Values"))
                //         : Center(
                //             child: Image.asset(
                //             "assets/loading.gif",
                //             height: 100,
                //           ))
                //     : SizedBox(
                //         height: height,
                //         child: GridView.builder(
                //           shrinkWrap: true,
                //           physics: const ScrollPhysics(),
                //           scrollDirection: Axis.horizontal,
                //           gridDelegate:
                //               const SliverGridDelegateWithFixedCrossAxisCount(
                //             crossAxisCount: 1,
                //           ),
                //           itemCount: facebookcover.length,
                //           itemBuilder: (BuildContext context, int index) {
                //             if (facebookcover[index]['logonu'] == "") {
                //               return Category(
                //                   title: 'now value', imagePath: url);
                //             } else {
                //               return Padding(
                //                 padding: const EdgeInsets.all(8.0),
                //                 child: InkWell(
                //                   onTap: () {
                //                     toScreen(
                //                         context,
                //                         Showalloption(
                //                           data: facebookcover,
                //                           cat: 'Design Facebook Coverpage',
                //                         ));
                //                   },
                //                   child: CategoryGrid(
                //                     imagePath:
                //                         '$weburl/${facebookcover[index]['logo']}',
                //                   ),
                //                 ),
                //               );
                //             }
                //           },
                //         ),
                //       ),
                // header('Other Buisness Category', onpress: () {
                //   toScreen(
                //       context,
                //       Showallcategory(
                //         value: buisnesscategory,
                //         subimage: buisnesssubservice,
                //         subvalue: buisnessimage,
                //         cat: 'Other Buisness Category',
                //       ));
                // },
                //     catlength:
                //         buisnesscategory.isEmpty ? 1 : buisnesscategory.length),
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
                //         gridDelegate:
                //             const SliverGridDelegateWithFixedCrossAxisCount(
                //                 crossAxisCount: 3,
                //                 mainAxisSpacing: 0,
                //                 crossAxisSpacing: 0),
                //         itemCount: buisnesscategory.length > 3
                //             ? 3
                //             : buisnesscategory.length,
                //         itemBuilder: (BuildContext context, int index) {
                //           if (buisnesscategory[index]['category_image'] == "") {
                //             return Category(title: 'now value', imagePath: url);
                //           } else {
                //             return InkWell(
                //               onTap: () {
                //                 toScreen(
                //                     context,
                //                     Subcategory(
                // popupvalue: "buisness",
                //                       value: buisnesscategory[index]['id'],
                //                       catname: buisnesscategory[index]
                //                           ['category_name'],
                //                       subcategory: buisnesssubservice,
                //                       subcategoryimage: buisnessimage,
                //                     ));
                //               },
                //               child: Category(
                //                 title:
                //                     "${buisnesscategory[index]['category_name']}",
                //                 imagePath:
                //                     '$weburl/${buisnesscategory[index]['category_image']}',
                //               ),
                //             );
                //           }
                //         },
                //       ),
                // ListView.builder(
                //   shrinkWrap: true,
                //   physics: ScrollPhysics(),
                //   itemCount: poster['data']['posters'].length,
                //   itemBuilder: (context, index) {
                //     return Padding(
                //       padding: const EdgeInsets.all(8.0),
                //       child: InkWell(
                //         onTap: () {
                // toScreen(
                //     context,
                //     PosterPage(
                //       getimage:
                //           '$weburl/${poster['data']['otherservicescategories'][index]['category_image']}',
                //     ));
                // },
                //         child: Category(
                //           title:
                //               "${poster['data']['posters'][index]['poster_name']}",
                //           imagePath:
                //               '$weburl/${poster['data']['posters'][index]['category_image']}',
                //         ),
                //       ),
                //     );
                //   },
                // ),
                // header('Trending'),
                // CarouselSlider(
                //   items: List.generate(5, (index) {
                //     return const CustomSlider();
                //   }),
                //   options: CarouselOptions(
                //     autoPlay: true,
                //     viewportFraction: 0.6,
                //   ),
                // ),
                // header('Stories'),
                // CarouselSlider(
                //   items: List.generate(5, (index) {
                //     return const CustomSlider();
                //   }),
                //   options: CarouselOptions(
                //     autoPlay: true,
                //     viewportFraction: 0.6,
                //   ),
                // ),
                // header('Quotes'),
                // CarouselSlider(
                //   items: List.generate(5, (index) {
                //     return const CustomSlider();
                //   }),
                //   options: CarouselOptions(
                //     autoPlay: true,
                //     viewportFraction: 0.6,
                //   ),
                // ),
                // header('Tomorrow'),
                // CarouselSlider(
                //   items: List.generate(5, (index) {
                //     return const CustomSlider();
                //   }),
                //   options: CarouselOptions(
                //     autoPlay: true,
                //     viewportFraction: 0.6,
                //   ),
                // )
              ],
            ),
          );
  }
}
