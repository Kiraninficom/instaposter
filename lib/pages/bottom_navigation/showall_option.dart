import 'dart:convert';
import 'dart:io';
import 'package:click/pages/sentapi.dart';
// import 'package:device_info_plus/device_info_plus.dart';
import 'package:http/http.dart' as http;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:click/Pages/authcredential.dart';
import 'package:click/pages/bottom_navigation/logo_poster.dart';
import 'package:click/pages/getapi.dart';
import 'package:click/utils/constants.dart';
import 'package:click/utils/navigation.dart';
import 'package:click/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:math' as math;

import '../../widgets/category.dart';

class Showalloption extends StatefulWidget {
  var data;
  var cat;
  Showalloption({super.key, this.data, this.cat});

  @override
  State<Showalloption> createState() => _ShowalloptionState();
}

class _ShowalloptionState extends State<Showalloption> {
  var selected;
  var typeofdata = ["New Demo logo", "Your Requested logo"];

  getlogodata() async {
    var logo = await Authcredential().getfromlocal("logo");
    SentApi().getlogoservices().then((value) {
      setState(() {});
    });
    setState(() {
      designlogo = jsonDecode(logo);
    });
  }

  getrequestedlogodata() async {
    var logo = await Authcredential().getfromlocal("requestedlogo");
    SentApi().getrequestedlogoservices().then((value) {
      setState(() {});
    });
    setState(() {
      requestedlogo = jsonDecode(logo);
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

  @override
  void initState() {
    super.initState();
    selected = 0;
    getlogodata();
    getrequestedlogodata();
    getfacebookdata();
  }

  var downloadingprogress = false;
  var selecteddownload = null;

  @override
  Widget build(BuildContext context) {
    print(requestedlogo);
    print(widget.data);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text(widget.cat),
      ),
      body: ListView(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(
                  typeofdata.length,
                  (index) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              selected = index;
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: selected == index
                                    ? primaryColor
                                    : Color(0xfff5f5f5),
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(color: Color(0xffe2e2e2))),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                typeofdata[index],
                                style: TextStyle(
                                    color:
                                        selected == index ? whitecolor : null),
                              ),
                            ),
                          ),
                        ),
                      )),
            ),
          ),
          Divider(
            color: blackcolor,
          ),
          selected == 0
              ? GridView.builder(
                  shrinkWrap: true,
                  physics: const ScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 0,
                      crossAxisSpacing: 0),
                  itemCount: widget.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    var imageissvg =
                        ("${widget.data[index]['logo']}".split(".").last ==
                            'svg');
                    if (widget.data[index]['logo'] == "") {
                      return Category(title: 'now value', imagePath: url);
                    } else {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                            onTap: () {
                              pagescondition(
                                widget.cat,
                                widget.data[index],
                              );
                            },
                            child: SizedBox(
                                child: Stack(children: <Widget>[
                              Positioned(
                                  top: 0,
                                  left: 0,
                                  child: Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.455,
                                    height: MediaQuery.of(context).size.width *
                                        0.455,
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(28),
                                        topRight: Radius.circular(28),
                                        bottomLeft: Radius.circular(28),
                                        bottomRight: Radius.circular(28),
                                      ),
                                      image: imageissvg == true
                                          ? null
                                          : DecorationImage(
                                              image: CachedNetworkImageProvider(
                                                  '$weburl/${widget.data[index]['logo']}'),
                                              fit: BoxFit.fill),
                                    ),
                                    child: imageissvg == true
                                        ? SvgPicture.network(
                                            '$weburl/${widget.data[index]['logo']}')
                                        : null,
                                  )),
                              Positioned(
                                  top: 0,
                                  left: 0,
                                  child: Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.2,
                                      height:
                                          MediaQuery.of(context).size.width *
                                              0.2,
                                      decoration: const BoxDecoration(
                                        image: DecorationImage(
                                            image: AssetImage('assets/tag.png'),
                                            fit: BoxFit.fitWidth),
                                      ))),
                              Positioned(
                                  top:
                                      MediaQuery.of(context).size.width * 0.055,
                                  left: MediaQuery.of(context).size.width * 0.0,
                                  child: Transform.rotate(
                                    angle: -45.99999828106503 * (math.pi / 180),
                                    child: Text(
                                      widget.data[index]['price'] != null
                                          ? double.parse(widget.data[index]
                                                          ['price'] ??
                                                      widget.data[index]
                                                          ['rate']) ==
                                                  0.0
                                              ? 'Free'
                                              : '${widget.data[index]['price'] ?? widget.data[index]['rate']}'
                                          : 'Free',
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                          color:
                                              Color.fromRGBO(255, 255, 255, 1),
                                          fontWeight: FontWeight.normal,
                                          height: 1),
                                    ),
                                  )),
                            ]))),
                      );
                    }
                  },
                )
              : requestedlogo.isEmpty
                  ? Center(
                      child: Text("No Request Found"),
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: const ScrollPhysics(),
                      itemCount: requestedlogo.length,
                      itemBuilder: (BuildContext context, int index) {
                        var imageissvg =
                            ("${widget.data[index][(requestedlogo[index]['poster'] != 'null' || requestedlogo[index]['poster'] != 'NA') ? 'poster' : 'rquested_logo']}']}"
                                    .split(".")
                                    .last ==
                                'svg');
                        //print(requestedlogo);
                        return Column(
                          children: [
                            Opacity(
                              opacity: downloadingprogress == false &&
                                      selecteddownload != index
                                  ? 1
                                  : selecteddownload == index
                                      ? 0.5
                                      : 1.0,
                              child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  height:
                                      MediaQuery.of(context).size.width * 0.455,
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      imageissvg == true
                                          ? SvgPicture.network(
                                              '$weburl/${requestedlogo[index][(requestedlogo[index]['poster'] == 'null' || requestedlogo[index]['poster'] == 'NA') ? 'rquested_logo' : 'poster']}')
                                          : CachedNetworkImage(
                                              imageUrl:
                                                  '$weburl/${requestedlogo[index][(requestedlogo[index]['poster'] == 'null' || requestedlogo[index]['poster'] == 'NA') ? 'rquested_logo' : 'poster']}'),
                                      downloadingprogress == false &&
                                              selecteddownload != index
                                          ? Positioned(child: Container())
                                          : selecteddownload == index
                                              ? Positioned(
                                                  child:
                                                      CircularProgressIndicator(),
                                                )
                                              : Positioned(child: Container()),
                                    ],
                                  )),
                            ),
                            int.parse(requestedlogo[index]['status']) == 0
                                ? Text("Request Is in Progress")
                                : const SizedBox.shrink(),
                            requestedlogo[index]['poster'] == null ||
                                    requestedlogo[index]['poster'] == 'NA'
                                ? SizedBox.shrink()
                                : downloadingprogress == false &&
                                        selecteddownload != index
                                    ? MaterialButton(
                                        onPressed: () {
                                          setState(() {
                                            selecteddownload = index;
                                            downloadingprogress = true;
                                          });
                                          downloadlogo(
                                              '$weburl/${requestedlogo[index]['poster']}');
                                        },
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text("Download"),
                                            Icon(Icons.download)
                                          ],
                                        ),
                                      )
                                    : SizedBox.shrink()
                          ],
                        );
                      },
                    ),
        ],
      ),
    );
  }

  downloadlogo(var url) async {
    var imageextenstion = url.split(".").last;
    var response = await http.get(Uri.parse(url));
    var bytes = response.bodyBytes;

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
    // DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    // AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    // int apiLevel = androidInfo.version.sdkInt;
    // print(apiLevel);
    // if (apiLevel < 29) {
    //   newPath = "$newPath/Addon-App";
    // } else {
    newPath = "$newPath/Download";
    // }
    directory = Directory(newPath);
    var status = await Permission.storage.status;

    if (!status.isGranted) {
      await Permission.storage.request();
    }

    if (!await directory.exists()) {
      directory.create();
    }

    final File file = File(
        "${directory.path}/logo${DateTime.now().toString().replaceAll(':', '').replaceAll(' ', '').replaceAll('-', '')}.$imageextenstion");

    file.writeAsBytesSync(bytes);
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(file.path)));

    sendcount('1');
    setState(() {
      selecteddownload = null;
      downloadingprogress = false;
    });
  }

  pagescondition(var cat, var data) {
    //print(cat);
    //print(data);
    if (subscriptiondetail != null) {
      if (int.parse(subscriptiondetail['days_left']) >= 0 ||
          (double.parse(data['price']) == 0.0)) {
        Navigator.push(context, MaterialPageRoute(
          builder: (context) {
            return Logoposter(
              type: cat,
              data: data,
            );
          },
        )).then((value) {
          getrequestedlogodata();
          getlogodata();
          getfacebookdata();
        });
      } else {
        nosubscriptiondialog(context);
      }
    } else if (subscriptiondetail == null) {
      if ((DateTime.now()
                  .difference(DateTime.parse(userdata['created_at']))
                  .inDays) <
              7 ||
          (double.parse(data['price']) == 0.0)) {
        //print("local condition");
        Navigator.push(context, MaterialPageRoute(
          builder: (context) {
            return Logoposter(
              type: cat,
              data: data,
            );
          },
        )).then((value) {
          getrequestedlogodata();
          getlogodata();
          getfacebookdata();
        });
      } else {
        nosubscriptiondialog(context);
      }
    } else {
      nosubscriptiondialog(context);
    }
  }
}
