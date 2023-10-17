import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:click/pages/bottom_navigation/popup_dialog.dart';
import 'package:click/pages/drawer/profile/add_profile.dart';
import 'package:click/pages/drawer/profile/my_profile.dart';
import 'package:click/poster_page/poster_page.dart';
import 'package:click/poster_page/video_page.dart';
import 'package:click/utils/constants.dart';
import 'package:click/utils/navigation.dart';
import 'package:click/utils/styles.dart';
import 'package:click/widgets/popupconstant.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:math' as math;

import 'package:video_player/video_player.dart';

class PosterVideos extends StatefulWidget {
  var subvideo;
  var id;
  var subcat;
  PosterVideos({Key? key, this.id, this.subvideo, this.subcat})
      : super(key: key);

  @override
  State<PosterVideos> createState() => _PosterVideosState();
}

class _PosterVideosState extends State<PosterVideos> {
  List<VideoPlayerController> videoControllers = [];
  int selected = 0;
  var subcategory = [];
  var subvideovalue = [];
  var selectedlanguage = 0;

  Future getdata() async {
    final prefs = await SharedPreferences.getInstance()
        .then((value) => json.decode("${value.getString("userdata")}"));

    setState(() {
      userdata = prefs;
    });
  }

  getsubcategory() {
    subcategory.clear();
    setState(() {
      subcategory.add("See all");
    });
    if (widget.subcat != null) {
      for (int i = 0; i < widget.subcat.length; i++) {
        if (widget.subcat[i]['service'] == widget.id) {
          setState(() {
            subcategory.add(widget.subcat[i]);
          });
        }
      }
    }
    getposter();
  }

  d(var newlist) {
    showDialog(
      context: context,
      builder: (context) {
        return PopupPage(value: newlist);
      },
    );
  }

  void initializeVideoControllers() {
    for (var id in subvideovalue) {
      print(id['video']);
      final controller =
          VideoPlayerController.network("$weburl/${id['video']}");
      videoControllers.add(controller);
      controller.initialize().then((_) {
        setState(() {}); // Trigger a rebuild when the video is initialized
      });
    }
  }

  // intialise() async {
  //   controller = VideoPlayerController.network(
  //     "$weburl/${subvideovalue[0]['video']}",
  //     // "https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4",
  //   )
  //     ..addListener(() {
  //       final bool isPlaying = controller!.value.isPlaying;
  //       final bool isEndOfVideo =
  //           controller!.value.position == controller!.value.duration;
  //       // Check if the video has ended
  //       //print(isPlaying);
  //       //print(isEndOfVideo);
  //       if (isPlaying == false && isEndOfVideo == true) {
  //         setState(() {
  //           controller!.pause(); // Update the flag variable
  //         });
  //       }
  //     })
  //     ..initialize().then((_) {
  //       controller!.play();
  //       // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
  //       setState(() {});
  //     });
  // }

  @override
  void dispose() {
    super.dispose();
    // controller!.dispose();
  }

  getposter() {
    subvideovalue.clear();
    //print("video${widget.subvideo}");
    for (int i = 0; i < widget.subvideo.length; i++) {
      if ("${widget.subvideo[i]['service']}" == "${widget.id}") {
        if (selected != 0 &&
            widget.subvideo[i]['subcategory_id'] ==
                subcategory[selected]['id']) {
          setState(() {
            subvideovalue.add(widget.subvideo[i]);
          });
        }
        if (selected == 0) {
          setState(() {
            subvideovalue.add(widget.subvideo[i]);
          });
        }
      }
    }
    //print("video$subvideovalue");
    if (subvideovalue.isNotEmpty) {
      initializeVideoControllers();
    }
  }

  getvalue() async {
    await getsubcategory();
    await getdata();
  }

  @override
  void initState() {
    super.initState();
    getvalue();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: const Text("Videos"),
      ),
      body: ListView(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(
                  subcategory.length,
                  (index) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              selected = index;
                            });
                            getposter();
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: selected == index
                                    ? primaryColor
                                    : greyshade300,
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(blurRadius: 2, color: blackcolor)
                                ]),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 10.0, right: 10.0, top: 5, bottom: 5),
                              child: Text(
                                index == 0
                                    ? subcategory[index]
                                    : subcategory[index]['subcategory_name'],
                                style: TextStyle(
                                    fontSize: 18,
                                    color:
                                        selected == index ? whitecolor : null),
                              ),
                            ),
                          ),
                        ),
                      )),
            ),
          ),
          subvideovalue.isEmpty
              ? const Center(
                  child: Text('No Video Found'),
                )
              : ListView.builder(
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  itemCount: subvideovalue.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () {
                          selectprofile(subvideovalue[index], index);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: blackcolor)),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 180,
                                width: double.infinity,
                                child: AspectRatio(
                                    aspectRatio: videoControllers[index]
                                        .value
                                        .aspectRatio,
                                    child:
                                        VideoPlayer(videoControllers[index])),
                              ),
                              Row(
                                children: [
                                  MaterialButton(
                                    onPressed: () {
                                      setState(() {
                                        videoControllers[index].value.isPlaying
                                            ? videoControllers[index].pause()
                                            : videoControllers[index].play();
                                      });
                                    },
                                    child: Icon(
                                      videoControllers[index].value.isPlaying
                                          ? Icons.pause
                                          : Icons.play_arrow,
                                      size: 30,
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        subvideovalue[index]['title'],
                                        softWrap: true,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
        ],
      ),
    );
  }

  selectprofile(var item, int index) {
    //print("userdata $festivalprofilevalue");
    return showModalBottomSheet(
      backgroundColor: Colors.blueGrey[50],
      context: context,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Select Profile',
                      style: TextStyle(color: blackcolor, fontSize: 20),
                    ),
                    InkWell(
                        onTap: () {
                          backscreen(context);
                        },
                        child: Icon(
                          Icons.close,
                          color: blackcolor,
                        ))
                  ],
                ),
              ),
              userdata['address'] == null
                  ? InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return MyProfile();
                          },
                        )).then((value) {
                          backscreen(context);
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: whitecolor,
                            boxShadow: [BoxShadow(blurRadius: 2)],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListTile(
                              title: Text(
                                'Add Profile Address',
                                style: TextStyle(
                                  color: primaryColor,
                                  fontSize: 18,
                                ),
                              ),
                              leading: Icon(Icons.add),
                            ),
                          ),
                        ),
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () {
                          toScreen(
                              context,
                              Videopage(
                                getvideo: item,
                                activecsc: true,
                                profilevalue: userdata,
                                normalprofile: true,
                                selected: index,
                              ));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: whitecolor,
                            boxShadow: [BoxShadow(blurRadius: 2)],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListTile(
                              leading: CircleAvatar(
                                radius: 30,
                                backgroundImage: userdata["profile_img"] == null
                                    ? CachedNetworkImageProvider(weburl)
                                    : CachedNetworkImageProvider(
                                        "$weburl/${userdata["profile_img"]}"),
                              ),
                              title: Text(
                                '${userdata["name"]}',
                                style: TextStyle(
                                  color: primaryColor,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
              festivalprofilevalue.isNotEmpty
                  ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () {
                          toScreen(
                              context,
                              Videopage(
                                getvideo: item,
                                activecsc: false,
                                profilevalue: festivalprofilevalue[0],
                                selected: index,
                              ));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: whitecolor,
                            boxShadow: [BoxShadow(blurRadius: 2)],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListTile(
                              leading: CircleAvatar(
                                radius: 30,
                                backgroundImage: CachedNetworkImageProvider(
                                    "$weburl/${festivalprofilevalue[0]['profile_img']}"),
                              ),
                              subtitle: Text('Festival Profile'),
                              title: Text(
                                '${festivalprofilevalue[0]['name']}',
                                style: TextStyle(
                                  color: primaryColor,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  : InkWell(
                      onTap: () {
                        toScreen(
                            context,
                            Addprofile(
                                csc: false, buisness: false, festival: true));
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: whitecolor,
                            boxShadow: [BoxShadow(blurRadius: 2)],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListTile(
                              title: Text(
                                'Add Festival Profile',
                                style: TextStyle(
                                  color: primaryColor,
                                  fontSize: 18,
                                ),
                              ),
                              leading: Icon(Icons.add),
                            ),
                          ),
                        ),
                      ),
                    ),
              cscvalue.isNotEmpty
                  ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () {
                          toScreen(
                              context,
                              Videopage(
                                getvideo: item,
                                activecsc: true,
                                selected: index,
                                profilevalue: cscvalue[0],
                              ));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: whitecolor,
                            boxShadow: [BoxShadow(blurRadius: 2)],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListTile(
                              leading: CircleAvatar(
                                radius: 30,
                                backgroundImage: CachedNetworkImageProvider(
                                    "$weburl/${cscvalue[0]['profile_img']}"),
                              ),
                              subtitle: Text('Csc Profile'),
                              title: Text(
                                '${cscvalue[0]['name']}',
                                style: TextStyle(
                                  color: primaryColor,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  : InkWell(
                      onTap: () {
                        toScreen(
                            context,
                            Addprofile(
                                csc: true, buisness: false, festival: false));
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: whitecolor,
                            boxShadow: [BoxShadow(blurRadius: 2)],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListTile(
                              title: Text(
                                'Add Csc Profile',
                                style: TextStyle(
                                  color: primaryColor,
                                  fontSize: 18,
                                ),
                              ),
                              leading: Icon(Icons.add),
                            ),
                          ),
                        ),
                      ),
                    ),
            ],
          ),
        );
      },
    );
  }
}
