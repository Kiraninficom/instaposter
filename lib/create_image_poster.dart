import 'dart:io';
import 'package:click/poster_page/poster_page.dart';
import 'package:click/utils/constants.dart';
import 'package:click/utils/navigation.dart';
import 'package:click/utils/styles.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
import 'package:video_player/video_player.dart';

class Createimageposter extends StatefulWidget {
  const Createimageposter({Key? key}) : super(key: key);

  @override
  State<Createimageposter> createState() => _CreateimageposterState();
}

class _CreateimageposterState extends State<Createimageposter> {
  var watermarktext = [];
  void num(index, str) {
    for (int i = 0; i <= index; i++) {
      var space;
      space = "  " * i * str.length;
      space = space + "Addon\n";
      setState(() {
        watermarktext.add(space);
      });
    }
  }

  int _frameno = 1;
  var data;
  bool framesetting = false;
  var titlefontvalue;
  var otherfontvalue;
  var titlesizevalue;
  var othersizevalue;
  Color titlecolorvalue = redcolor;
  Color othercolorvalue = bluecolor;
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController mobilenumber = TextEditingController();
  TextEditingController companyname = TextEditingController();
  TextEditingController weblink = TextEditingController();
  Color pickedcolor = redcolor;
  final GlobalKey _globalKey = GlobalKey();
  final ScreenshotController controller = ScreenshotController();
  VideoPlayerController? videocontroller;

  Offset offset = Offset.zero;
  Offset offset1 = Offset.zero;
  TextEditingController nameController = TextEditingController();
  String fullName = '';
  Uint8List? pngBytes;

  Future<dynamic> saveImage(Uint8List bytes) async {
    Directory? directory = await getExternalStorageDirectory();
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
      directory.create();
    }

    if (await directory.exists()) {
      final File file = File("${directory.path}/clickonadd.png");

      file.writeAsBytesSync(bytes);
      Fluttertoast.showToast(msg: "${directory.path}${"/clickonadd.png"}");

      return file;
    }
  }

  Future<dynamic> saveAndShare(Uint8List bytes) async {
    final Directory directory = await getApplicationDocumentsDirectory();
    final File image = File("${directory.path}/flutter.png");
    const String text =
        "Download the app for more intresting images link:- AppLink";
    image.writeAsBytesSync(bytes);
    await Share.shareXFiles([XFile(image.path)], text: text);
  }

  setvalue() {
    setState(() {
      data = {
        "name": name.text,
        "email": email.text,
        "mobileno": mobilenumber.text,
        'web_url': weblink.text,
        "profile_img": userdata['profile_img']
      };
    });
  }

  loadvideo(var video) {
    // File file = File(video);
    // //print(video);
    videocontroller = VideoPlayerController.file(
      video,
    )
      ..addListener(() {
        final bool isPlaying = videocontroller!.value.isPlaying;
        final bool isEndOfVideo =
            videocontroller!.value.position == videocontroller!.value.duration;
        if (isPlaying == false && isEndOfVideo == true) {
          setState(() {
            videocontroller!.pause(); // Update the flag variable
          });
        }
      })
      ..initialize().then((_) {
        setState(() {});
        videocontroller!.play();
      });
  }

  @override
  void initState() {
    super.initState();
    num(8, "Addon");
    titlesizevalue = 12;
    othersizevalue = 12;
    name.text = userdata['name'] ?? "";
    email.text = userdata['email'] ?? "";
    mobilenumber.text = userdata['mobileno'] ?? "";
    address.text = userdata['address'] ?? "";
    setvalue();
    if (path1.isNotEmpty) {
      loadvideo(path1[0]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: primaryColor,
          title: path1.isNotEmpty
              ? path1[0].path.split(".").last == "mp4"
                  ? Text('Create Video Poster')
                  : Text('Create Image Poster')
              : Text('Create Image Poster'),
        ),
        body: ListView(
          children: [
            Container(
              color: Colors.grey.shade300,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: buildImage(),
              ),
            ),
            path1.isNotEmpty
                ? path1[0].path.split(".").last == "mp4"
                    ? IconButton(
                        onPressed: () {
                          setState(() {
                            videocontroller!.value.isPlaying
                                ? videocontroller!.pause()
                                : videocontroller!.play();
                          });
                        },
                        icon: Icon(
                          videocontroller!.value.isPlaying
                              ? Icons.pause
                              : Icons.play_arrow,
                          size: 40,
                        ),
                      )
                    : SizedBox.shrink()
                : SizedBox.shrink(),
            Container(
              color: primaryColor,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(
                      6,
                      (index) => Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  // svgRoot = newsvg;
                                  _frameno = index + 1;
                                });
                              },
                              child: Container(
                                height: 30,
                                width: 30,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: index + 1 == _frameno
                                      ? Colors.blue
                                      : whitecolor,
                                ),
                                child: Center(
                                  child: Text(
                                    '${index + 1}',
                                    style: TextStyle(
                                        color: index + 1 == _frameno
                                            ? whitecolor
                                            : blackcolor,
                                        fontSize: 15),
                                  ),
                                ),
                              ),
                            ),
                          )),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () async {
                          if (path1.isEmpty) {
                            List<File> img1 = [];
                            var res = await FilePicker.platform.pickFiles(
                                allowMultiple: true,
                                type: FileType.custom,
                                allowedExtensions: ['jpg', 'png', 'mp4']);

                            if (res != null) {
                              setState(() {
                                path1 = res.paths
                                    .map((path) => File("$path"))
                                    .toList();
                              });
                              await loadvideo(path1[0]);
                            }
                          } else {
                            setState(() {
                              path1.clear();
                            });
                          }
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width / 3.5,
                          decoration: BoxDecoration(
                              border: Border.all(color: blackcolor)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(path1.isEmpty ? "PHOTO\n/VIDEO" : "Clear"),
                                Icon(path1.isEmpty ? Icons.add : Icons.close)
                              ],
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () async {
                          if (path2.isEmpty) {
                            var res = await FilePicker.platform.pickFiles(
                                allowMultiple: true,
                                type: FileType.custom,
                                allowedExtensions: ['jpg', 'png']);

                            if (res != null) {
                              setState(() {
                                path2 = res.paths
                                    .map((path) => File("$path"))
                                    .toList();
                              });
                              await loadvideo(path1[0]);
                            }
                          } else {
                            setState(() {
                              path2.clear();
                            });
                          }

                          // try {
                          //   final RenderRepaintBoundary boundary =
                          //       _globalKey.currentContext!.findRenderObject()!
                          //           as RenderRepaintBoundary;
                          //   final ui.Image image1 = await boundary.toImage(
                          //       pixelRatio: ui.window.devicePixelRatio);
                          //   final ByteData? byteData = await image1
                          //       .toByteData(format: ui.ImageByteFormat.png);
                          //   pngBytes = byteData!.buffer.asUint8List();

                          //   // ignore: avoid_catches_without_on_clauses
                          // } catch (e) {
                          //   debug//print("hello");
                          // }
                          // final Uint8List image =
                          //     await controller.captureFromWidget(buildImage(),
                          //         context: context);

                          // await saveImage(image);
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width / 3.5,
                          decoration: BoxDecoration(
                              border: Border.all(color: blackcolor)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(path2.isEmpty ? "Logo" : "clear"),
                                Icon(path2.isEmpty ? Icons.add : Icons.close)
                              ],
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (context) => textdialog());
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width / 4,
                          decoration: BoxDecoration(
                              border: Border.all(color: blackcolor)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [Text("TEXT"), Icon(Icons.add)],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      PopupMenuButton(
                        child: Container(
                          width: MediaQuery.of(context).size.width / 3.5,
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              border: Border.all(color: blackcolor, width: 1)),
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                framesetting == false
                                    ? titlefontvalue != null
                                        ? Text(titlefontvalue['fontname'],
                                            style: TextStyle(
                                                fontFamily:
                                                    titlefontvalue['font']))
                                        : const Text("Font")
                                    : otherfontvalue != null
                                        ? Text(otherfontvalue['fontname'],
                                            style: TextStyle(
                                                fontFamily:
                                                    otherfontvalue['font']))
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
                                          ? titlefontvalue = fontlist[index]
                                          : otherfontvalue = fontlist[index];
                                    });
                                  },
                                  value: framesetting == false
                                      ? titlefontvalue
                                      : otherfontvalue,
                                  child: Text(fontlist[index]["fontname"]!,
                                      style: TextStyle(
                                          fontFamily: fontlist[index]
                                              ['font']))));
                        },
                      ),
                      PopupMenuButton(
                        child: Container(
                          padding: const EdgeInsets.all(5),
                          width: MediaQuery.of(context).size.width / 3.5,
                          decoration: BoxDecoration(
                              border: Border.all(color: blackcolor, width: 1)),
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
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
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width / 4,
                        child: Column(
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
                                ? 'Tile Setting'
                                : 'other setting')
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Color Picker',
                        style: const TextStyle(
                            fontWeight: FontWeight.w400, fontSize: 25),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: BlockPicker(
                      pickerColor: pickedcolor, //default color
                      onColorChanged: (Color color) {
                        setState(() {
                          pickedcolor = color;
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
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: child(color)),
                              )
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Enter text'),
                            content: TextField(
                              controller: nameController,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                              ),
                            ),
                            actions: [
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text('CANCEL'),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    fullName = nameController.text;
                                  });

                                  Navigator.pop(context);
                                },
                                child: const Text('Confirm'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: const Text("Add Text Above Image")),
                fullName.isNotEmpty
                    ? InkWell(
                        onTap: () {
                          setState(() {
                            fullName = "";
                          });
                        },
                        child: Icon(Icons.delete))
                    : SizedBox.shrink()
              ],
            ),
          ],
        ),
        bottomNavigationBar: Container(
          color: Colors.grey.shade300,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {},
              child: Container(
                decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        "PURCHASE & DOWNLOAD",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: whitecolor,
                            fontSize: 20,
                            fontStyle: FontStyle.italic),
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: whitecolor,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  field({var controller, onchange, hinttext, labeltext, icon}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: controller,
        onChanged: onchange,
        decoration: InputDecoration(
            suffixIcon: icon,
            border:
                OutlineInputBorder(borderSide: BorderSide(color: blackcolor)),
            helperText: hinttext,
            labelText: labeltext),
      ),
    );
  }

  textdialog() {
    return Dialog(
      child: Wrap(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Change Text"),
                InkWell(
                    onTap: () {
                      backscreen(context);
                    },
                    child: Icon(Icons.close)),
              ],
            ),
          ),
          field(
              onchange: (value) {
                setvalue();
              },
              controller: name,
              labeltext: "Name",
              icon: Icon(Icons.person)),
          field(
              onchange: (value) {
                setvalue();
              },
              controller: companyname,
              labeltext: "Company Name",
              icon: Icon(Icons.work)),
          field(
              onchange: (value) {
                setvalue();
              },
              controller: email,
              labeltext: "Email",
              icon: Icon(Icons.email)),
          field(
              onchange: (value) {
                setvalue();
              },
              controller: address,
              labeltext: "Address",
              icon: Icon(Icons.location_on)),
          field(
              onchange: (value) {
                setvalue();
              },
              controller: weblink,
              labeltext: "Web Link",
              icon: Icon(Icons.web)),
          field(
              onchange: (value) {
                setvalue();
              },
              controller: mobilenumber,
              labeltext: "Mobile Number",
              icon: Icon(Icons.phone)),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    if (videocontroller != null) {
      videocontroller!.dispose();
    }
  }

  buildImage() {
    return Center(
      child: Container(
        color: whitecolor,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 1),
                ),
                child: Column(
                  children: [
                    _frameno == 5 || _frameno == 6
                        ? Container(
                            color: Colors.yellow,
                            height: 80,
                            width: double.infinity,
                          )
                        : const SizedBox.shrink(),
                    path1.isEmpty
                        ? Container(
                            color: Colors.grey.shade200,
                            height: 250,
                            width: MediaQuery.of(context).size.width,
                            child:
                                Center(child: const Text('Select Image/Video')))
                        : path1[0].path.split(".").last == "mp4"
                            ? Container(
                                height: 250,
                                width: MediaQuery.of(context).size.width,
                                child: VideoPlayer(videocontroller!))
                            : Image.file(
                                path1[0],
                              ),
                    getframe(),
                  ],
                )),
            Positioned(
              left: offset.dx,
              top: offset.dy,
              child: GestureDetector(
                  onPanUpdate: (details) {
                    setState(() {
                      offset = Offset(offset.dx + details.delta.dx,
                          offset.dy + details.delta.dy);
                    });
                  },
                  child: SizedBox(
                    width: 300,
                    height: 300,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Text(fullName,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                decoration: TextDecoration.none,
                                fontWeight: FontWeight.bold,
                                fontSize: 28.0,
                                color: redcolor)),
                      ),
                    ),
                  )),
            ),
          ],
        ),
      ),
    );
  }

  getframe() {
    if (_frameno == 1) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Container(
              height: 70,
              width: 70,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.black, width: 1),
                  image: path2.isNotEmpty
                      ? DecorationImage(
                          image: FileImage(path2[0]), fit: BoxFit.cover)
                      : null),
              child: path2.isEmpty ? const Text('Select profile image') : null,
            ),
            const SizedBox(
              width: 10,
            ),
            SizedBox(
              height: 70,
              child: Column(
                children: [
                  Text(
                    name.text,
                    style: TextStyle(
                        decoration: TextDecoration.none,
                        color: blackcolor,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    address.text,
                    style: TextStyle(
                        decoration: TextDecoration.none,
                        color: blackcolor,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    email.text,
                    style: TextStyle(
                        decoration: TextDecoration.none,
                        color: blackcolor,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }
    if (_frameno == 2) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          height: 70,
          child: Column(
            children: [
              Text(
                name.text,
                style: TextStyle(
                    color: blackcolor,
                    fontSize: 15,
                    decoration: TextDecoration.none,
                    fontWeight: FontWeight.bold),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    email.text,
                    style: TextStyle(
                      color: blackcolor,
                      fontSize: 15,
                      decoration: TextDecoration.none,
                    ),
                  ),
                  Text(
                    mobilenumber.text,
                    style: TextStyle(
                      color: blackcolor,
                      fontSize: 15,
                      decoration: TextDecoration.none,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.location_on),
                  Text(
                    address.text,
                    style: TextStyle(
                      color: blackcolor,
                      fontSize: 15,
                      decoration: TextDecoration.none,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    }
    if (_frameno == 3) {
      return Padding(
        padding: const EdgeInsets.all(5.0),
        child: Row(
          children: [
            CircleAvatar(
                radius: 40,
                backgroundImage: path2.isNotEmpty ? FileImage(path2[0]) : null),
            const SizedBox(
              width: 5,
            ),
            Expanded(
              // width: MediaQuery.of(context).size.width / 1.5,
              flex: 8,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    name.text,
                    style: TextStyle(
                        color: blackcolor,
                        fontSize: 15,
                        decoration: TextDecoration.none,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    email.text,
                    style: TextStyle(
                      color: blackcolor,
                      fontSize: 15,
                      decoration: TextDecoration.none,
                    ),
                  ),
                  Text(
                    mobilenumber.text,
                    style: TextStyle(
                      color: blackcolor,
                      fontSize: 15,
                      decoration: TextDecoration.none,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.location_on),
                      FittedBox(
                        child: Text(
                          address.text,
                          style: TextStyle(
                            color: blackcolor,
                            fontSize: 15,
                            decoration: TextDecoration.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }
    if (_frameno == 4) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Stack(
              children: [
                Container(
                  height: 80,
                  width: 70,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(35.0),
                        bottomRight: Radius.circular(35.0)),
                    color: Color(0Xffdddddd),
                  ),
                ),
                Positioned(
                  top: 15,
                  left: 5,
                  child: CircleAvatar(
                      radius: 30,
                      backgroundImage:
                          path2.isNotEmpty ? FileImage(path2[0]) : null),
                ),
              ],
            ),
            const SizedBox(
              width: 5,
            ),
            SizedBox(
              // width: MediaQuery.of(context).size.width * 0.7,
              child: Column(
                children: [
                  Text(
                    name.text,
                    style: TextStyle(
                        color: blackcolor,
                        fontSize: 15,
                        decoration: TextDecoration.none,
                        fontWeight: FontWeight.bold),
                  ),
                  Column(
                    children: [
                      Text(
                        email.text,
                        style: TextStyle(
                          color: blackcolor,
                          fontSize: 15,
                          decoration: TextDecoration.none,
                        ),
                      ),
                      const SizedBox(width: 5),
                      Text(
                        mobilenumber.text,
                        style: TextStyle(
                          color: blackcolor,
                          fontSize: 15,
                          decoration: TextDecoration.none,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(Icons.location_on),
                      Text(
                        address.text,
                        style: TextStyle(
                          color: blackcolor,
                          fontSize: 15,
                          decoration: TextDecoration.none,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }
    if (_frameno == 5) {
      return Container(
        height: 120,
        alignment: Alignment.bottomCenter,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            ClipPath(
              clipper: MyWaveClipper5(),
              child: Container(
                color: Colors.yellow,
                height: 100,
                width: double.infinity,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 40),
              child: CircleAvatar(
                radius: 50,
                backgroundColor: const Color.fromARGB(255, 27, 17, 91),
                child: CircleAvatar(
                    radius: 35,
                    backgroundImage:
                        path2.isNotEmpty ? FileImage(path2[0]) : null),
              ),
            )
          ],
        ),
      );
    }
    if (_frameno == 6) {
      return Container(
        height: 120,
        alignment: Alignment.bottomCenter,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              color: Colors.orange,
              height: 90,
            ),
            ClipPath(
              clipper: MyWaveClipper6(),
              child: Container(
                color: Colors.yellow,
                height: 100,
                width: double.infinity,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 40),
              child: CircleAvatar(
                radius: 50,
                backgroundColor: const Color.fromARGB(255, 27, 17, 91),
                child: CircleAvatar(
                    radius: 35,
                    backgroundImage:
                        path2.isNotEmpty ? FileImage(path2[0]) : null),
              ),
            )
          ],
        ),
      );
    }
    if (_frameno == 7) {
      return Container(
          alignment: Alignment.bottomCenter,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * .5,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                color: Colors.white,
                height: 80,
                width: double.infinity,
              ),
              Container(
                height: 130,
                alignment: Alignment.bottomCenter,
                child: Stack(
                  alignment: Alignment.bottomLeft,
                  children: [
                    ClipPath(
                      clipper: MyWaveClipper7(),
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 20),
                        color: Colors.orange,
                        height: 100,
                        width: double.infinity,
                      ),
                    ),
                    ClipPath(
                      clipper: MyWaveClipper7(),
                      child: Container(
                        color: Colors.white,
                        height: 100,
                        width: double.infinity,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 15, bottom: 40),
                      child: CircleAvatar(
                        radius: 50,
                        backgroundColor: const Color.fromARGB(255, 27, 17, 91),
                        child: CircleAvatar(
                            radius: 40,
                            backgroundImage:
                                path2.isNotEmpty ? FileImage(path2[0]) : null),
                      ),
                    )
                  ],
                ),
              )
            ],
          ));
    }
  }
}
