import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:click/utils/constants.dart';
import 'package:click/widgets/textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter/material.dart';
import 'package:click/utils/styles.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:screenshot/screenshot.dart';
import 'package:video_player/video_player.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_ffmpeg/flutter_ffmpeg.dart';

class Videoeditpage extends StatefulWidget {
  var networkvideo;
  var title;
  Videoeditpage({super.key, this.networkvideo, this.title});

  @override
  State<Videoeditpage> createState() => _VideoeditpageState();
}

class _VideoeditpageState extends State<Videoeditpage> {
  TextEditingController text = TextEditingController();
  late VideoPlayerController? controller;
  bool editingvalue = false;
  bool otherinfovalue = false;
  bool watermark = true;
  bool framesetting = false;
  Color pickedcolor = Colors.transparent;
  var scrollcontroller = ScrollController();
  var titlefontvalue;
  var otherfontvalue;
  var titlesizevalue = 20;
  var othersizevalue = 20;
  int _frameno = 1;
  Color titlecolorvalue = Colors.transparent;
  Color othercolorvalue = bluecolor;
  @override
  void initState() {
    super.initState();
    controller = VideoPlayerController.network(
      "${widget.networkvideo}",
    )
      ..addListener(() {
        final bool isPlaying = controller!.value.isPlaying;
        final bool isEndOfVideo =
            controller!.value.position == controller!.value.duration;
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
    // TODO: implement dispose
    super.dispose();
    controller!.dispose();
  }

  banner() {
    //print(titlesizevalue);
    //print(othersizevalue);
    return Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              color: titlecolorvalue,
              border: Border(bottom: BorderSide(color: blackcolor))),
          padding: EdgeInsets.all(8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    text.text.isNotEmpty ? text.text : userdata['name'],
                    style: TextStyle(
                        color: othercolorvalue,
                        fontSize: double.parse("$othersizevalue"),
                        fontFamily: otherfontvalue != null
                            ? otherfontvalue['font']
                            : null),
                  ),
                  Text(
                    text.text.isNotEmpty ? text.text : userdata['mobileno'],
                    style: TextStyle(
                        color: othercolorvalue,
                        fontSize: double.parse("$othersizevalue"),
                        fontFamily: otherfontvalue != null
                            ? otherfontvalue['font']
                            : null),
                  ),
                ],
              ),
              userdata['profile_img'] != null
                  ? CachedNetworkImage(
                      imageUrl: "$weburl/${userdata["profile_img"]}",
                      width: 50,
                      height: 50,
                    )
                  : SizedBox.shrink()
            ],
          ),
        )
      ],
    );
  }

  box() {
    return SizedBox(
      height: 500,
      width: MediaQuery.of(context).size.width,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text("Edit Video"),
      ),
      body: ListView(
        children: [
          Column(
            children: [
              SizedBox(
                height: 250,
                child: VideoPlayer(controller!),
              ),
              banner(),
            ],
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
                  controller!.value.isPlaying ? Icons.pause : Icons.play_arrow,
                ),
              ),
              Text(
                widget.title,
                textScaleFactor: 1.5,
              ),
            ],
          ),
          Column(
            children: [
              // SingleChildScrollView(
              //   scrollDirection: Axis.horizontal,
              //   child: Container(
              //     color: Colors.grey.shade300,
              //     child: Row(
              //       children: List.generate(
              //           12,
              //           (index) => Padding(
              //                 padding: const EdgeInsets.all(8.0),
              //                 child: InkWell(
              //                   onTap: () {
              //                     setState(() {
              //                       // _frameno = index + 1;
              //                     });
              //                   },
              //                   child: Container(
              //                     height: 30,
              //                     width: 30,
              //                     decoration: BoxDecoration(
              //                       borderRadius: BorderRadius.circular(5),
              //                       color: index + 1 == _frameno
              //                           ? Colors.blue
              //                           : whitecolor,
              //                     ),
              //                     child: Center(
              //                       child: Text(
              //                         '${index + 1}',
              //                         style: TextStyle(
              //                             color: index + 1 == _frameno
              //                                 ? whitecolor
              //                                 : blackcolor,
              //                             fontSize: 15),
              //                       ),
              //                     ),
              //                   ),
              //                 ),
              //               )),
              //     ),
              //   ),
              // ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: BlockPicker(
                  pickerColor: pickedcolor, //default color
                  onColorChanged: (Color color) {
                    setState(() {
                      framesetting == false
                          ? titlecolorvalue = color
                          : othercolorvalue = color;
                    });
                  },
                  layoutBuilder: (context, colors, child) {
                    return GridView.count(
                      crossAxisCount: 6,
                      physics: ScrollPhysics(),
                      shrinkWrap: true,
                      children: [
                        for (Color color in colors)
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                                decoration: BoxDecoration(
                                    border: Border.all(color: blackcolor),
                                    borderRadius: BorderRadius.circular(20)),
                                child: child(color)),
                          )
                      ],
                    );
                  },
                ),
              ),
              // CustomTextField(
              //   controller: text,
              //   labelText: 'Enter Text',
              // ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: [
                    //     Row(
                    //       children: [
                    //         Container(
                    //           width: MediaQuery.of(context).size.width / 2.5,
                    //           child: Row(
                    //             mainAxisAlignment:
                    //                 MainAxisAlignment.spaceAround,
                    //             children: [
                    //               Column(
                    //                 children: [
                    //                   Transform.scale(
                    //                     scale: 0.8,
                    //                     child: CupertinoSwitch(
                    //                       trackColor: blackcolor,
                    //                       value: watermark,
                    //                       onChanged: (value) {
                    //                         setState(() {
                    //                           watermark = value;
                    //                         });
                    //                       },
                    //                     ),
                    //                   ),
                    //                   const Text('watermark')
                    //                 ],
                    //               ),
                    //               Column(
                    //                 children: [
                    //                   Transform.scale(
                    //                     scale: 0.8,
                    //                     child: CupertinoSwitch(
                    //                       trackColor: blackcolor,
                    //                       value: editingvalue,
                    //                       onChanged: (value) {
                    //                         setState(() {
                    //                           editingvalue = value;
                    //                           if (value == false) {
                    //                             pickedcolor = blackcolor;
                    //                           }
                    //                         });
                    //                       },
                    //                     ),
                    //                   ),
                    //                   const Text('Frame')
                    //                 ],
                    //               ),
                    //             ],
                    //           ),
                    //         ),
                    //       ],
                    //     ),
                    //     Container(
                    //       width: MediaQuery.of(context).size.width / 2,
                    //       decoration: BoxDecoration(
                    //           border: Border.all(color: primaryColor),
                    //           borderRadius: BorderRadius.circular(10)),
                    //       child: Padding(
                    //         padding: const EdgeInsets.all(8.0),
                    //         child: Row(
                    //           mainAxisAlignment: MainAxisAlignment.spaceAround,
                    //           children: [
                    //             Text(
                    //               "Premium Template",
                    //               style: TextStyle(color: primaryColor),
                    //             ),
                    //             Icon(
                    //               Icons.arrow_forward_ios,
                    //               color: primaryColor,
                    //             )
                    //           ],
                    //         ),
                    //       ),
                    //     )
                    //   ],
                    // ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Container(
                        //   width: MediaQuery.of(context).size.width / 2.5,
                        //   child: Row(
                        //     mainAxisAlignment: MainAxisAlignment.spaceAround,
                        //     children: [
                        Column(
                          children: [
                            Transform.scale(
                              scale: 0.8,
                              child: CupertinoSwitch(
                                trackColor: redcolor,
                                activeColor: bluecolor,
                                value: framesetting,
                                onChanged: (value) {
                                  setState(() {
                                    framesetting = value;
                                  });
                                },
                              ),
                            ),
                            Text(framesetting == false
                                ? 'Background Setting'
                                : 'other setting')
                          ],
                        ),
                        //       Column(
                        //         children: [
                        //           Transform.scale(
                        //             scale: 0.8,
                        //             child: CupertinoSwitch(
                        //               trackColor: blackcolor,
                        //               value: otherinfovalue,
                        //               onChanged: (value) {
                        //                 setState(() {
                        //                   otherinfovalue = value;
                        //                 });
                        //               },
                        //             ),
                        //           ),
                        //           const Text('Other info')
                        //         ],
                        //       ),
                        //     ],
                        //   ),
                        // ),
                        framesetting == true
                            ? PopupMenuButton(
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Container(
                                    width:
                                        MediaQuery.of(context).size.width / 4.5,
                                    padding: const EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        border: Border.all(
                                            color: blackcolor, width: 1)),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        framesetting == false
                                            ? titlefontvalue != null
                                                ? Text(
                                                    titlefontvalue['fontname'],
                                                    style: TextStyle(
                                                        fontFamily:
                                                            titlefontvalue[
                                                                'font']))
                                                : const Text("Font")
                                            : otherfontvalue != null
                                                ? Text(
                                                    otherfontvalue['fontname'],
                                                    style: TextStyle(
                                                        fontFamily:
                                                            otherfontvalue[
                                                                'font']))
                                                : const Text("Font"),
                                        const Icon(Icons.arrow_drop_down)
                                      ],
                                    ),
                                  ),
                                ),
                                itemBuilder: (context) {
                                  return List.generate(
                                      fontlist.length,
                                      (index) => PopupMenuItem(
                                          onTap: () {
                                            setState(() {
                                              framesetting == false
                                                  ? titlefontvalue =
                                                      fontlist[index]
                                                  : otherfontvalue =
                                                      fontlist[index];
                                            });
                                          },
                                          value: framesetting == false
                                              ? titlefontvalue
                                              : otherfontvalue,
                                          child: Text(
                                              fontlist[index]["fontname"]!,
                                              style: TextStyle(
                                                  fontFamily: fontlist[index]
                                                      ['font']))));
                                },
                              )
                            : SizedBox.shrink(),
                        framesetting == false
                            ? SizedBox.shrink()
                            : PopupMenuButton(
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Container(
                                    width:
                                        MediaQuery.of(context).size.width / 4.5,
                                    padding: const EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        border: Border.all(
                                            color: blackcolor, width: 1)),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        framesetting == false
                                            ? Text(titlesizevalue != null
                                                ? "$titlesizevalue"
                                                : "size")
                                            : Text(othersizevalue != null
                                                ? "$othersizevalue"
                                                : "size"),
                                        const Icon(Icons.arrow_drop_down)
                                      ],
                                    ),
                                  ),
                                ),
                                itemBuilder: (context) {
                                  return List.generate(
                                      25,
                                      (index) => PopupMenuItem(
                                          onTap: () {
                                            setState(() {
                                              framesetting == false
                                                  ? titlesizevalue = index + 1
                                                  : othersizevalue = index + 1;
                                            });
                                          },
                                          value: framesetting == false
                                              ? titlesizevalue
                                              : othersizevalue,
                                          child: Text("${index + 1}")));
                                },
                              )
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: Container(
        width: MediaQuery.of(context).size.width,
        color: Colors.grey.shade300,
        child: Wrap(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  InkWell(
                    onTap: () async {},
                    child: Container(
                      // width: MediaQuery.of(context).size.width / 4,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(5)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            'Edit',
                            style: TextStyle(color: whitecolor, fontSize: 20),
                          ),
                          Icon(
                            Icons.edit,
                            color: whitecolor,
                            size: 20,
                          )
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () async {},
                    child: Container(
                      // width: MediaQuery.of(context).size.width / 4,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(5)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            'Share',
                            style: TextStyle(color: whitecolor, fontSize: 20),
                          ),
                          Icon(
                            Icons.share,
                            color: whitecolor,
                            size: 20,
                          )
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      String assets = widget.networkvideo;
                      if (kDebugMode) {
                        //print(assets);
                      }
                      var response = await http.get(Uri.parse(assets));
                      var documentDirectory =
                          await getExternalStorageDirectory();
                      var firstPath = "${documentDirectory!.path}/video";
                      var filePathAndName =
                          '${documentDirectory.path}/video/inputvideo.mp4';
                      var filePathAndNamenew =
                          '${documentDirectory.path}/video/inputvideo1.mp4';
                      if (kDebugMode) {
                        //print(filePathAndName);
                      }
                      await Directory(firstPath)
                          .create(recursive: true); // <-- 1
                      File file2 = File(filePathAndName); // <-- 2
                      file2.writeAsBytesSync(response.bodyBytes);

                      FlutterFFmpeg().execute(
                          "-i $filePathAndName -vf scale=1280:720 -c:a copy $filePathAndNamenew");
                      final ScreenshotController controller =
                          ScreenshotController();
                      final Uint8List image =
                          await controller.captureFromWidget(banner(),
                              pixelRatio: 50.0, context: context);
                      final Uint8List image2 =
                          await controller.captureFromWidget(box(),
                              pixelRatio: 50.0, context: context);
                      // var response2 = await http.get(Uri.parse(
                      //     "https://images.unsplash.com/photo-1575936123452-b67c3203c357?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8aW1hZ2V8ZW58MHx8MHx8&w=1000&q=80"));
                      var filePathAndName1 =
                          '${documentDirectory.path}/video/inputvideo.jpg';
                      var plainbox =
                          '${documentDirectory.path}/video/inputvideo.jpg';
                      File file3 = File(filePathAndName1);
                      File file4 = File(plainbox);

                      file3.writeAsBytesSync(image);
                      file4.writeAsBytesSync(image2);

                      Directory? directory =
                          await getExternalStorageDirectory();
                      String newPath = "";
                      final List<String> paths = directory!.path.split("/");
                      for (int x = 1; x < paths.length; x++) {
                        final String folder = paths[x];
                        if (folder != "Android") {
                          newPath += "/$folder";
                        } else {
                          break;
                        }
                      }
                      newPath = "$newPath/clickonadd";
                      directory = Directory(newPath);
                      var status = await Permission.storage.status;

                      if (!status.isGranted) {
                        await Permission.storage.request();
                      }

                      if (!await directory.exists()) {
                        directory.create(recursive: true);
                      }

                      var filePathAndName2 =
                          "${directory.path}/clickonadd${DateTime.now().toString().replaceAll(':', '').replaceAll(' ', '').replaceAll('-', '')}.mp4";
                      // final arguments =
                      //     '-i $filePathAndName -vf "text="Hello World":x=(w-text_w)/2:y=(h-text_h)/2-th:fontcolor=white:fontsize=30" -c:v libx264 -crf 23 -preset veryfast $filePathAndName2';
                      final arguments =
                          '-i $filePathAndNamenew -i  $filePathAndName1 -filter_complex "[1:v]scale=1280:2200[overlay];[0:v][overlay]overlay=W-w:535" -c:v mpeg4 $filePathAndName2';
                      final FlutterFFmpeg flutterFFmpeg = FlutterFFmpeg();
                      int rc = await flutterFFmpeg.execute(arguments);
                      //print("rc:- $rc");
                      if (rc == 0) {
                        //print('Video processing succeeded.');
                        final file = File(filePathAndNamenew);
                        final file1 = File(filePathAndName);
                        final file2 = File(filePathAndName1);
                        file.deleteSync();
                        file1.deleteSync();
                        file2.deleteSync();

                        Fluttertoast.showToast(
                            msg:
                                "${directory.path}/clickonadd${DateTime.now().toString().replaceAll(':', '').replaceAll(' ', '').replaceAll('-', '')}.mp4");
                      } else {
                        //print('Video processing failed with code: $rc');
                      }
                    },
                    child: Container(
                      // width: MediaQuery.of(context).size.width / 2.8,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(5)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            'Download',
                            style: TextStyle(color: whitecolor, fontSize: 20),
                          ),
                          Icon(
                            Icons.download,
                            color: whitecolor,
                            size: 25,
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
