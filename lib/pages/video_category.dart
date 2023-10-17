import 'dart:convert';

import 'package:click/Pages/authcredential.dart';
import 'package:click/pages/bottom_navigation/showall_category.dart';
import 'package:click/pages/getapi.dart';
import 'package:click/pages/poster_video.dart';
import 'package:click/utils/constants.dart';
import 'package:click/utils/navigation.dart';
import 'package:click/utils/styles.dart';
import 'package:click/widgets/category.dart';
import 'package:flutter/material.dart';

class VideoCategory extends StatefulWidget {
  const VideoCategory({super.key});

  @override
  State<VideoCategory> createState() => _VideoCategoryState();
}

class _VideoCategoryState extends State<VideoCategory> {
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
                      style: TextStyle(color: whitecolor),
                    ))
                : const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }

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

  getcscvideodata() async {
    var videolist = await Authcredential().getfromlocal("cscvideo");
    SentApi().getcscvideo().then((value) {
      setState(() {});
    });
    setState(() {
      cscvideo = jsonDecode(videolist);
    });
  }

  getschemedata() async {
    var cscbasic = await Authcredential().getfromlocal("schemebasic");
    SentApi().getschemebasic().then((value) {
      setState(() {});
    });
    setState(() {
      schemecategory = jsonDecode(cscbasic);
    });
  }

  getschemesubdata() async {
    var cscsubservice = await Authcredential().getfromlocal("schemesub");
    SentApi().getschemesubservices().then((value) {
      setState(() {});
    });
    setState(() {
      schemesubservicelist = jsonDecode(cscsubservice);
    });
  }

  getschemevideodata() async {
    var videolist = await Authcredential().getfromlocal("schemevideo");
    SentApi().getschemevideos().then((value) {
      setState(() {});
    });
    setState(() {
      schemevideo = jsonDecode(videolist);
    });
  }

  // getfestivalvideodata() async {
  //   var videolist = await Authcredential().getfromlocal("festivalvideo");
  //   SentApi().getfestivalvideos().then((value) {
  //     setState(() {});
  //   });
  //   setState(() {
  //     festivalvideo = jsonDecode(videolist);
  //   });
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getcscdata();
    getcscsubdata();
    getcscvideodata();
    getschemedata();
    getschemesubdata();
    getschemevideodata();
    // getfestivalvideodata();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.width / 1.5;
    var height2 = MediaQuery.of(context).size.width / 3;
    return RefreshIndicator(
      color: appBarColor,
      onRefresh: () async {
        getcscdata();
        getcscsubdata();
        getcscvideodata();
        getschemedata();
        getschemesubdata();
        getschemevideodata();
        // getfestivalvideodata();
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: primaryColor,
          title: Text("Videos"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: [
              header('CSC Video', onpress: () {
                // toScreen(
                //     context,
                //     Showallcategory(
                //       popupvalue: "csc",
                //       value: onlineserviceposter,
                //       subimage: onlineimage,
                //       subvalue: onlinesubservice,
                //       cat: 'Online Services Poster',
                //     ));
              }, catlength: 1),
              onlineserviceposter.isEmpty
                  ? alldataget
                      ? Center(child: Text("No Videos"))
                      : Center(
                          child: Image.asset(
                          "assets/loading.gif",
                          height: 100,
                        ))
                  : SizedBox(
                      height: onlineserviceposter.length > 4 ? height : height2,
                      child: GridView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        physics: const ScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount:
                                onlineserviceposter.length > 4 ? 2 : 1,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10),
                        itemCount: onlineserviceposter.length,
                        itemBuilder: (BuildContext context, int index) {
                          if (onlineserviceposter[index]['category_image'] ==
                              "") {
                            return Category(title: 'now value', imagePath: url);
                          } else {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: InkWell(
                                onTap: () {
                                  toScreen(
                                      context,
                                      PosterVideos(
                                        id: onlineserviceposter[index]['id'],
                                        subvideo: cscvideo,
                                        subcat: onlinesubservice,
                                      ));
                                },
                                child: CategoryGrid(
                                  imagePath:
                                      '$weburl/${onlineserviceposter[index]['category_image']}',
                                ),
                              ),
                            );
                          }
                        },
                      ),
                    ),
              header('Scheme Video', onpress: () {}, catlength: 1),
              schemecategory.isEmpty
                  ? alldataget
                      ? Center(child: Text("No Videos"))
                      : Center(
                          child: Image.asset(
                          "assets/loading.gif",
                          height: 100,
                        ))
                  : SizedBox(
                      height: schemecategory.length > 4 ? height : height2,
                      child: GridView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        physics: const ScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: schemecategory.length > 4 ? 2 : 1,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10),
                        itemCount: schemecategory.length,
                        itemBuilder: (BuildContext context, int index) {
                          if (schemecategory[index]['category_image'] == "") {
                            return Category(title: 'now value', imagePath: url);
                          } else {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: InkWell(
                                onTap: () {
                                  toScreen(
                                      context,
                                      PosterVideos(
                                        id: schemecategory[index]['id'],
                                        subvideo: schemevideo,
                                        subcat: schemesubservicelist,
                                      ));
                                },
                                child: CategoryGrid(
                                  imagePath:
                                      '$weburl/${onlineserviceposter[0]['category_image']}',
                                ),
                              ),
                            );
                          }
                        },
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
