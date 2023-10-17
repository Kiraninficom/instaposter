import 'package:click/pages/bottom_navigation/video_editpage.dart';
import 'package:click/pages/getapi.dart';
import 'package:click/utils/constants.dart';
import 'package:click/utils/navigation.dart';
import 'package:click/utils/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class Video extends StatefulWidget {
  const Video({Key? key}) : super(key: key);

  @override
  State<Video> createState() => _VideoState();
}

class _VideoState extends State<Video> {
  late VideoPlayerController? controller;
  bool isVideoEnded = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getdata();
    if (cscvideo.isNotEmpty) {
      intialise();
    }
  }

  getdata() async {
    var videolist = await SentApi().getcscvideo();
    setState(() {
      cscvideo = videolist;
    });
    intialise();
  }

  intialise() async {
    controller = VideoPlayerController.network(
      "$weburl/${cscvideo[0]['video']}",
      // "https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4",
    )
      ..addListener(() {
        final bool isPlaying = controller!.value.isPlaying;
        final bool isEndOfVideo =
            controller!.value.position == controller!.value.duration;
        // Check if the video has ended
        //print(isPlaying);
        //print(isEndOfVideo);
        if (isPlaying == false && isEndOfVideo == true) {
          setState(() {
            controller!.pause(); // Update the flag variable
          });
        }
      })
      ..initialize().then((_) {
        controller!.play();
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
  }

  @override
  void dispose() {
    super.dispose();
    controller!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //print(cscvideo);
    return cscvideo.isEmpty
        ? alldataget
            ? Center(child: Text("No Values"))
            : Center(
                child: Image.asset(
                "assets/loading.gif",
                height: 100,
              ))
        : Scaffold(
            appBar: AppBar(
              backgroundColor: primaryColor,
              title: const Text("Videos Poster"),
            ),
            body: ListView.builder(
              shrinkWrap: true,
              physics: ScrollPhysics(),
              itemCount: cscvideo.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Videoeditpage(
                              networkvideo:
                                  // "https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4",
                                  "$weburl/${cscvideo[index]['video']}",
                              title: "${cscvideo[index]['title']}",
                            ),
                          )).then((value) {
                        getdata();
                        if (cscvideo.isNotEmpty) {
                          intialise();
                        }
                      });
                    },
                    child: Container(
                      decoration:
                          BoxDecoration(border: Border.all(color: blackcolor)),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 250,
                            child: AspectRatio(
                                aspectRatio: controller!.value.aspectRatio,
                                child: VideoPlayer(controller!)),
                          ),
                          Row(
                            children: [
                              MaterialButton(
                                onPressed: () {
                                  setState(() {
                                    controller!.value.isPlaying
                                        ? controller!.pause()
                                        : controller!.play();
                                  });
                                },
                                child: Icon(
                                  controller!.value.isPlaying
                                      ? Icons.pause
                                      : Icons.play_arrow,
                                ),
                              ),
                              Text(cscvideo[index]['title']),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          );
  }
}

// SizedBox(
//       height: MediaQuery.of(context).size.height,
//       child: Column(
//         children: [
//           Image.asset("assets/coming soon.gif"),
//           Image.asset(
//             "assets/giphy.gif",
//             height: 150,
//           ),
//         ],
//       ),
//     );