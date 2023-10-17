// ignore_for_file: prefer_typing_uninitialized_variables, use_build_context_synchronously
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:click/pages/getapi.dart';
import 'package:click/poster_page/defaultframe.dart';
import 'package:click/poster_page/headercscframe.dart';
// import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_ffmpeg/flutter_ffmpeg.dart';
import 'package:flutter_launcher_icons/utils.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:click/Pages/authcredential.dart';
import 'package:click/poster_page/festivalframes.dart';
import 'package:click/poster_page/cscframe.dart';
import 'package:click/utils/navigation.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:click/utils/constants.dart';
import 'package:click/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:screenshot/screenshot.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';

class Videopage extends StatefulWidget {
  var getvideo;
  var profilevalue;
  var selected;
  bool activecsc;
  bool? activewatermark;
  bool? normalprofile;
  bool? itsgreeting;
  Videopage(
      {Key? key,
      this.getvideo,
      this.normalprofile,
      this.itsgreeting,
      this.profilevalue,
      this.selected,
      this.activewatermark,
      required this.activecsc})
      : super(key: key);

  @override
  State<Videopage> createState() => _VideopageState();
}

class _VideopageState extends State<Videopage> {
  var profilesize = 55.0;
  var logosize = 50.0;
  var namesize = 12.0;
  var addresssize = 10.0;
  var numbersize = 10.0;
  var emailsize = 10.0;
  var weblinksize = 10.0;
  var buisnessnamesize = 15.0;
  var watermarksize = 60.0;
  var whatsappnumbersize = 10.0;
  var facebooksize = 10.0;
  var facebookcolor;
  var facebookfont;
  bool facebookenable = true;
  var instagramsize = 10.0;
  var instagramcolor;
  var instagramfont;
  bool instagramenable = true;
  var designationsize = 10.0;
  var designationcolor;
  var designationfont;
  bool designationenable = true;
  var watermarkopacity = 1.0;
  bool profileenable = true;
  bool logoenable = true;
  bool nameenable = true;
  bool buisnessnameenable = true;
  bool weblinkenable = true;
  bool addressenable = true;
  bool numberenable = true;
  bool whatsappnumberenable = true;
  bool emailenable = true;
  var namecolor;
  Color framebackgound = whitecolor;
  var addresscolor;
  var weblinkcolor;
  var buisnessnamecolor;
  var numbercolor;
  var whatsappnumbercolor;
  var emailcolor;
  var watermarkcolor;
  var namefont;
  var addressfont;
  var whatsnumberfont;
  var buisnessnamefont;
  var weblinkfont;
  var numberfont;
  var emailfont;
  var watermarkfont;
  List uploadprofileimg = [];
  List greetingimage = [];
  var selected;
  Color pickedcolor = blackcolor;
  var scrollcontroller = ScrollController();
  int frameno = 1;
  int activeframe = 1;
  int? premiumframeno;
  final ScreenshotController controller = ScreenshotController();
  final CarouselController _carouselController = CarouselController();
  bool premiumprogress = false;
  var requestedpremium = [];
  var selectedpremium;
  int? yourpremiumfrmaeno;
  late VideoPlayerController? videocontroller;
  GlobalKey _imageKey = GlobalKey();
  GlobalKey _imageKey1 = GlobalKey();
  var headerHeight;
  var footerHeight;
  late Razorpay _razorpay;
  bool itsfordownload = false;

  void launchRazorpay(var description, var fee) {
    var doublevalue = fee;
    var totalval = doublevalue.toInt() * 100;

    var options = {
      'key': "$razorpaykeyvalue",
      'amount': totalval,
      'currency': 'INR',
      'name': 'ADDON',
      'description': description,
    };
    try {
      _razorpay.open(options);
    } catch (e) {
      if (kDebugMode) {}
    }
  }

  void initializeRazorpay() {
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) async {
    if (itsfordownload == true) {
      downloadposter();
    } else {
      setState(() {
        premiumprogress = true;
      });
      requestpremiumtemplate(premiumtemplatelist[premiumframeno!]['id'])
          .then((value) {
        setState(() {
          premiumprogress = false;
        });

        dialog(context,
            "Your template has book successfully, plz wait admin will contact you very shortly");
      });
    }
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    if (kDebugMode) {
      Fluttertoast.showToast(msg: 'Payment error');
    }
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    if (kDebugMode) {
      Fluttertoast.showToast(msg: 'Payment Failed');
    }
  }

  getrequestedpremium() async {
    var requestedpremium = await SentApi().getrequestedpremiumlist();
    setState(() {
      requestedpremiumtemplatelist = requestedpremium;
    });
  }

  requestpremiumtemplate(var id) async {
    var gettoken = await Authcredential().getToken();
    http.Response response = await http.post(
        Uri.parse('${baseurl}premium_request'),
        headers: {'token': '$gettoken'},
        body: {'template_id': id});
    if (response.statusCode == 200) {
      //print(response.body);
      getrequestedpremium();
      getdata();
      setState(() {});
    }
  }

  @override
  void dispose() {
    _razorpay.clear();
    scrollcontroller.dispose();
    super.dispose();
    videocontroller!.dispose();
  }

  @override
  void initState() {
    super.initState();
    initializeRazorpay();
    selected = 0;
    selectedpremium = 0;
    yourpremiumfrmaeno = 0;
    getdata();
    intialise();
    getheight();
    predifiendtextvalue();
    if (widget.normalprofile == true) {
      setState(() {
        namesize = 12;
        namecolor = redcolor;
      });
    }
  }

  void predifiendtextvalue() {
    setState(() {
      if (window.physicalSize.width <= 900.0) {
        profilesize = 70;
        logosize = 70;
      } else if (window.physicalSize.width <= 1100.0) {
        profilesize = 90;
        logosize = 90;
      } else if (window.physicalSize.width <= 1350.0) {
        profilesize = 100;
        logosize = 100;
      } else if (window.physicalSize.width > 1350) {
        profilesize = 110;
        logosize = 110;
      }
    });
  }

  getdata() {
    var value = widget.activecsc == true ? 1 : 2;
    requestedpremium.clear();
    for (var id in premiumtemplatelist) {
      if (int.parse(id['poster_type']) == value) {
        var index = premiumtemplatelist.indexOf(id);
        for (var requestid in requestedpremiumtemplatelist) {
          if (requestid['template_id'] == id['id']) {
            setState(() {
              requestedpremium.add(requestid);
            });
          }
        }
        if (premiumframeno == null) {
          setState(() {
            premiumframeno = index;
          });
        }
      }
    }
  }

  List csctypesofpage = [
    "Frame",
    "Paid Frame",
    "Poster Detail",
    "Profile Photo",
    "Logo",
    "Name",
    "Buisness Name",
    "Address",
    "Mobile No.",
    "WhatsApp No.",
    "Website",
    "Email",
    "",
    "Backgound Color"
  ];
  List festivaltypesofpage = [
    "Frame",
    "Paid Frame",
    "Poster Detail",
    "Profile Photo",
    "Logo",
    "Name",
    "Designation",
    "Address",
    "Mobile No.",
    "WhatsApp No.",
    "Website",
    "Email",
    "",
    "Backgound Color"
  ];
  List defaulttypeofpage = [
    "Frame",
    "Paid Frame",
    "Poster Detail",
    "Profile Photo",
    "Logo",
    "Name",
    "",
    "Address",
    "Mobile No.",
    "",
    "",
    "Email",
    "",
    "Backgound Color"
  ];
  bool progress = false;

  List typeofpremium = ["My Frame", "Book Frame"];
  getheight() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final imageBox =
          _imageKey.currentContext!.findRenderObject() as RenderBox;
      final imageBox1 =
          _imageKey1.currentContext!.findRenderObject() as RenderBox;
      headerHeight = imageBox.size.height;
      footerHeight = imageBox1.size.height;

      setState(() {});
      //print('Image height: $imageHeight');
    });
  }

  downloadposter() async {
    setState(() {
      progress = true;
    });
    final FlutterFFmpeg flutterFFmpeg = FlutterFFmpeg();
    String assets = "$weburl/${widget.getvideo['video']}";
    var documentDirectory = await getExternalStorageDirectory();
    var firstPath = "${documentDirectory!.path}/video";
    await Directory(firstPath).create(recursive: true); // <-- 1
    final ScreenshotController controller = ScreenshotController();
    final Uint8List image = await controller.captureFromWidget(
      buildvideofooter(),
      context: context,
    );
    Uint8List? image1;
    buildvideoheader() is SizedBox
        ? null
        : image1 = await controller.captureFromWidget(
            buildvideoheader(),
            context: context,
          );

    var fotter = '${documentDirectory.path}/video/footer.jpg';
    var fotternew = '${documentDirectory.path}/video/footernew.jpg';

    var header = '${documentDirectory.path}/video/header.jpg';
    var headernew = '${documentDirectory.path}/video/headernew.jpg';

    File file3 = File(fotter);
    File file4 = File(header);
    File file5 = File(fotternew);
    File file6 = File(headernew);
    print(videocontroller!.value.size.width);
    file3.writeAsBytesSync(image);
    buildvideoheader() is SizedBox ? null : file4.writeAsBytesSync(image1!);
    final footercommand =
        '-i $fotter -vf "scale=${videocontroller!.value.size.width}:-1" $fotternew';
    final headercommand = buildvideoheader() is SizedBox
        ? '-i $fotter -vf "scale=${videocontroller!.value.size.width}:-1" $fotternew'
        : '-i $header -vf "scale=${videocontroller!.value.size.width}:-1" $headernew';
    var newrc = await flutterFFmpeg.execute(footercommand);
    var newrc1 = buildvideoheader() is SizedBox
        ? null
        : await flutterFFmpeg.execute(headercommand);
    print(newrc);
    print(newrc1);
    var fotterheight = decodeImageFile(file5.path);
    var headerheight = buildvideoheader() is SizedBox
        ? decodeImageFile(file5.path)
        : decodeImageFile(file6.path);
    print(fotterheight!.height);
    print(headerheight!.height);
    Directory? directory = await getExternalStorageDirectory();
    print(fotterheight.width);
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
      directory.create(recursive: true);
    }

    var filePathAndName2 =
        "${directory.path}/video${DateTime.now().toString().replaceAll(':', '').replaceAll(' ', '').replaceAll('-', '')}.mp4";
    final arguments1 =
        '-i $assets -i  $fotternew  -filter_complex "[0:v]pad=iw:ih+${headerheight.height}[v];[v][1:v]overlay=W-W:H-h[outv]" -map "[outv]" -map 0:a? -c:a copy $filePathAndName2 ';

    final arguments =
        '-i $assets -i  $fotternew -i $headernew -filter_complex "[0:v]pad=iw:ih+${headerheight.height + fotterheight.height}:0:${headerheight.height}:black[v];[v][1:v]overlay=W-W:H-h[ovr1];[ovr1][2:v]overlay=W-W:0[outv]" -map "[outv]" -map 0:a? -c:a copy $filePathAndName2 ';

    int rc = await flutterFFmpeg
        .execute(buildvideoheader() is SizedBox ? arguments1 : arguments);
    print("its rc1 $rc");

    if (rc == 0) {
      final file1 = File(fotternew);
      final file2 = File(headernew);
      file1.deleteSync();
      buildvideoheader() is SizedBox ? null : file2.deleteSync();

      Fluttertoast.showToast(
          msg:
              "${directory.path}/video${DateTime.now().toString().replaceAll(':', '').replaceAll(' ', '').replaceAll('-', '')}.mp4");
    }
    setState(() {
      progress = false;
    });
  }

  posterdetails(var link, var name) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          elevation: 2,
          color: appBarColor,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {
                launchUrl(Uri.parse(link));
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "$name",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: whitecolor, fontSize: 20),
                ),
              ),
            ),
          ),
        ));
  }

  intialise() async {
    videocontroller = VideoPlayerController.network(
      "$weburl/${widget.getvideo['video']}",
    )
      ..addListener(() {
        final bool isPlaying = videocontroller!.value.isPlaying;
        final bool isEndOfVideo =
            videocontroller!.value.position == videocontroller!.value.duration;
        if (isPlaying == false && isEndOfVideo == true) {
          setState(() {
            videocontroller!.pause();
          });
        }
      })
      ..initialize().then((_) {
        videocontroller!.play();
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    final bool isPlaying = videocontroller!.value.isPlaying;
    final bool isEndOfVideo =
        videocontroller!.value.position == videocontroller!.value.duration;
    return SafeArea(
        child: RefreshIndicator(
      onRefresh: () async {
        getdata();
      },
      child: Scaffold(
        bottomNavigationBar: Container(
          color: Colors.grey.shade300,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                progress == true
                    ? Text("Video is in Downloading Process")
                    : isPlaying == false && isEndOfVideo == true
                        ? InkWell(
                            onTap: () {
                              if (double.parse(widget.getvideo['rate']) ==
                                  0.0) {
                                downloadposter();
                              } else {
                                paymentdialog(context,
                                    amount: widget.getvideo['rate'],
                                    text: "Download video", onpress: () {
                                  backscreen(context);
                                  setState(() {
                                    itsfordownload = true;
                                  });
                                  launchRazorpay("Download Video",
                                      double.parse(widget.getvideo['rate']));
                                });
                              }
                            },
                            child: Container(
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  color: primaryColor,
                                  borderRadius: BorderRadius.circular(5)),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text(
                                    'Download Video',
                                    style: TextStyle(
                                        color: whitecolor, fontSize: 20),
                                  ),
                                  Icon(
                                    Icons.download,
                                    color: whitecolor,
                                    size: 25,
                                  )
                                ],
                              ),
                            ),
                          )
                        : Text("Wait Download Button Will Be Appear soon"),
              ],
            ),
          ),
        ),
        body: ListView(
          children: [
            Container(
              color: Colors.grey.shade300,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Opacity(
                          opacity: progress == true ? 0.3 : 1.0,
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(color: blackcolor)),
                            child: Column(
                              children: [
                                RepaintBoundary(
                                    key: _imageKey1, child: buildvideoheader()),
                                SizedBox(
                                  height: 280,
                                  width: double.infinity,
                                  child: AspectRatio(
                                      aspectRatio:
                                          videocontroller!.value.aspectRatio,
                                      child: VideoPlayer(videocontroller!)),
                                ),
                                RepaintBoundary(
                                    key: _imageKey, child: buildvideofooter()),
                              ],
                            ),
                          ),
                        ),
                        progress == true
                            ? Center(
                                child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    "assets/loading.gif",
                                    height: 100,
                                  ),
                                  Text(
                                    "Wait Video is Downloading...",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: blackcolor,
                                        fontSize: 25,
                                        fontWeight: FontWeight.w600),
                                  )
                                ],
                              ))
                            : SizedBox.shrink()
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MaterialButton(
                          onPressed: () {
                            setState(() {
                              videocontroller!.value.isPlaying
                                  ? videocontroller!.pause()
                                  : videocontroller!.play();
                            });
                          },
                          child: Icon(
                            videocontroller!.value.isPlaying
                                ? Icons.pause
                                : Icons.play_arrow,
                          ),
                        ),
                        Expanded(child: Text(widget.getvideo['title'])),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(
                    widget.activecsc == true
                        ? widget.normalprofile == true
                            ? defaulttypeofpage.length
                            : csctypesofpage.length
                        : festivaltypesofpage.length,
                    (index) => index == 2 ||
                            ("${defaulttypeofpage[index]}" == "" &&
                                widget.normalprofile == true)
                        ? SizedBox.shrink()
                        : Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  selected = index;
                                });
                                getheight();
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: selected == index
                                      ? primaryColor
                                      : Color(0xfff5f5f5),
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(color: Color(0xffeaeaea)),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    widget.activecsc == true
                                        ? "${csctypesofpage[index]}"
                                        : "${festivaltypesofpage[index]}",
                                    textScaleFactor: 1.2,
                                  ),
                                ),
                              ),
                            ),
                          )),
              ),
            ),
            selected == 0
                ? framepage()
                : selected == 1
                    ? Column(
                        children: [
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: List.generate(
                                  typeofpremium.length,
                                  (index) => Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: InkWell(
                                          onTap: () {
                                            setState(() {
                                              selectedpremium = index;
                                            });
                                            getheight();
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: selectedpremium == index
                                                  ? appBarColor
                                                  : Color(0xfff5f5f5),
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              border: Border.all(
                                                  color: Color(0xffeaeaea)),
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(5.0),
                                              child: Text(
                                                "${typeofpremium[index]}",
                                                textScaleFactor: 1.6,
                                                style: TextStyle(
                                                    color:
                                                        selectedpremium == index
                                                            ? whitecolor
                                                            : blackcolor),
                                              ),
                                            ),
                                          ),
                                        ),
                                      )),
                            ),
                          ),
                          selectedpremium != 0
                              ? SizedBox.shrink()
                              : requestedpremium.isEmpty
                                  ? Center(
                                      child: Text(
                                        "You have not booked any Template",
                                        style: TextStyle(
                                            color: primaryColor,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    )
                                  : Column(
                                      children: [
                                        MaterialButton(
                                          color: appBarColor,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15)),
                                          onPressed: () {
                                            colorsheet(true);
                                          },
                                          child: Text(
                                            "Pick Frame Background Color",
                                            style: TextStyle(color: whitecolor),
                                          ),
                                        ),
                                        requestedframpage(
                                          context,
                                        ),
                                      ],
                                    ),
                          selectedpremium != 1
                              ? const SizedBox.shrink()
                              : premiumtemplatelist.isEmpty
                                  ? Center(
                                      child: Text(
                                        "No Premium Template",
                                        style: TextStyle(
                                            color: primaryColor,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    )
                                  : Column(
                                      children: [
                                        MaterialButton(
                                          color: appBarColor,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15)),
                                          onPressed: () {
                                            colorsheet(true);
                                          },
                                          child: Text(
                                            "Pick Frame Background Color",
                                            style: TextStyle(color: whitecolor),
                                          ),
                                        ),
                                        bookframpage(),
                                      ],
                                    ),
                          selectedpremium != 1
                              ? SizedBox.shrink()
                              : premiumprogress == true
                                  ? Center(child: CircularProgressIndicator())
                                  : Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: InkWell(
                                        onTap: () {
                                          if (double.parse(premiumtemplatelist[
                                                  premiumframeno!]['rate']) ==
                                              0.0) {
                                            setState(() {
                                              premiumprogress = true;
                                            });
                                            requestpremiumtemplate(
                                                    premiumtemplatelist[
                                                        premiumframeno!]['id'])
                                                .then((value) {
                                              setState(() {
                                                premiumprogress = false;
                                              });

                                              dialog(context,
                                                  "Your template has book successfully, plz wait admin will contact you very shortly");
                                            });
                                          } else {
                                            paymentdialog(context,
                                                amount: premiumtemplatelist[
                                                    premiumframeno!]['rate'],
                                                text: "Book Template",
                                                onpress: () {
                                              backscreen(context);
                                              launchRazorpay(
                                                  "Premium Request ${userdata['name']}",
                                                  double.parse(
                                                      premiumtemplatelist[
                                                              premiumframeno!]
                                                          ['rate']));
                                            });
                                          }
                                        },
                                        child: Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              .6,
                                          decoration: BoxDecoration(
                                              color: primaryColor,
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              border: Border.all(
                                                  color: primaryColor)),
                                          child: Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: Text(
                                              "BOOK PAID FRAME",
                                              softWrap: true,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: whitecolor,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                        ],
                      )
                    : selected == 2
                        ? SizedBox.shrink()
                        : selected == 13
                            ? Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: MaterialButton(
                                  color: appBarColor,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15)),
                                  onPressed: () {
                                    colorsheet(true);
                                  },
                                  child: Text(
                                    "Pick Frame Background Color",
                                    style: TextStyle(color: whitecolor),
                                  ),
                                ),
                              )
                            : editable(context),
          ],
        ),
      ),
    ));
  }

  paymentdialog(BuildContext context, {var amount, var text, var onpress}) {
    return showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Wrap(
              alignment: WrapAlignment.center,
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: InkWell(
                      onTap: () {
                        backscreen(context);
                      },
                      child: Icon(Icons.close)),
                ),
                Text(
                  "You have to pay ₹$amount for $text",
                  style: TextStyle(fontSize: 20),
                ),
                MaterialButton(
                  color: primaryColor,
                  onPressed: onpress,
                  child: Text(
                    "Submit",
                    style: TextStyle(color: whitecolor),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  colorsheet(bool? itsbackground) {
    return showModalBottomSheet(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        context: context,
        barrierColor: Colors.transparent,
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: MediaQuery.of(context).size.height / 2.5,
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: IconButton(
                        onPressed: () {
                          backscreen(context);
                        },
                        icon: Icon(Icons.close)),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height / 3,
                    child: Scrollbar(
                      thumbVisibility: true,
                      thickness: 10,
                      interactive: true,
                      child: SingleChildScrollView(
                        child: ColorPicker(
                          pickerAreaBorderRadius: BorderRadius.circular(10),
                          colorPickerWidth: 200,
                          pickerColor: pickedcolor,
                          onColorChanged: (color) {
                            if (itsbackground == true) {
                              setState(() {
                                framebackgound = color;
                              });
                            } else {
                              setState(() {
                                selected == 5
                                    ? namecolor = color
                                    : selected == 6
                                        ? widget.activecsc == true
                                            ? buisnessnamecolor = color
                                            : designationcolor = color
                                        : selected == 7
                                            ? widget.activecsc == true
                                                ? addresscolor = color
                                                : facebookcolor = color
                                            : selected == 8
                                                ? widget.activecsc == true
                                                    ? numbercolor = color
                                                    : instagramcolor = color
                                                : selected == 9
                                                    ? whatsappnumbercolor =
                                                        color
                                                    : selected == 10
                                                        ? weblinkcolor = color
                                                        : selected == 11
                                                            ? emailcolor = color
                                                            : selected == 12
                                                                ? watermarkcolor =
                                                                    color
                                                                : null;
                              });
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
          //  AlertDialog(
          //   title:
          //   content:
          // );
        });
  }

  fontsheet(BuildContext context) {
    var font = selected == 5
        ? namefont
        : selected == 6
            ? widget.activecsc == true
                ? buisnessnamefont
                : designationfont
            : selected == 7
                ? widget.activecsc == true
                    ? addressfont
                    : facebookfont
                : selected == 8
                    ? widget.activecsc == true
                        ? numberfont
                        : instagramfont
                    : selected == 9
                        ? whatsnumberfont
                        : selected == 10
                            ? weblinkfont
                            : selected == 11
                                ? emailfont
                                : selected == 12
                                    ? watermarkfont
                                    : null;
    return showModalBottomSheet(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      context: context,
      builder: (context) {
        return SingleChildScrollView(
          child: Column(
            children: [
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                    onPressed: () {
                      backscreen(context);
                    },
                    icon: Icon(Icons.close)),
              ),
              SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: List.generate(
                        fontlist.length,
                        (index) => PopupMenuItem(
                            onTap: () {
                              setState(() {
                                selected == 5
                                    ? namefont = fontlist[index]
                                    : selected == 6
                                        ? widget.activecsc == true
                                            ? buisnessnamefont = fontlist[index]
                                            : designationfont = fontlist[index]
                                        : selected == 7
                                            ? widget.activecsc == true
                                                ? addressfont = fontlist[index]
                                                : facebookfont = fontlist[index]
                                            : selected == 8
                                                ? widget.activecsc == true
                                                    ? numberfont =
                                                        fontlist[index]
                                                    : instagramfont =
                                                        fontlist[index]
                                                : selected == 9
                                                    ? whatsnumberfont =
                                                        fontlist[index]
                                                    : selected == 10
                                                        ? weblinkfont =
                                                            fontlist[index]
                                                        : selected == 11
                                                            ? emailfont =
                                                                fontlist[index]
                                                            : selected == 12
                                                                ? watermarkfont =
                                                                    fontlist[
                                                                        index]
                                                                : null;
                              });
                            },
                            value: font,
                            child: Text(fontlist[index]["fontname"]!,
                                style: TextStyle(
                                    fontFamily: fontlist[index]['font'])))),
                  )),
            ],
          ),
        );
      },
    );
  }

  editable(BuildContext context) {
    var size = selected == 3
        ? profilesize
        : selected == 4
            ? logosize
            : selected == 5
                ? namesize
                : selected == 6
                    ? widget.activecsc == true
                        ? buisnessnamesize
                        : designationsize
                    : selected == 7
                        ? widget.activecsc == true
                            ? addresssize
                            : addresssize
                        //  facebooksize
                        : selected == 8
                            ? widget.activecsc == true
                                ? numbersize
                                : numbersize
                            // instagramsize
                            : selected == 9
                                ? whatsappnumbersize
                                : selected == 10
                                    ? weblinksize
                                    : selected == 11
                                        ? emailsize
                                        : selected == 12
                                            ? watermarksize
                                            : null;

    return SingleChildScrollView(
      child: Column(
        children: [
          Row(
            children: [
              selected == 12
                  ? SizedBox.shrink()
                  : iconbox(
                      name: "Show",
                      icon: Icon(
                        Icons.visibility_outlined,
                        size: 40,
                        color: selected == 3 && profileenable == true
                            ? primaryColor
                            : selected == 4 && logoenable == true
                                ? primaryColor
                                : selected == 5 && nameenable == true
                                    ? primaryColor
                                    : selected == 6 &&
                                            (widget.activecsc == true
                                                    ? buisnessnameenable
                                                    : designationenable) ==
                                                true
                                        ? primaryColor
                                        : selected == 7 &&
                                                (widget.activecsc == true
                                                        ? addressenable
                                                        : addressenable
                                                    // instagramsize
                                                    ) ==
                                                    true
                                            ? primaryColor
                                            : selected == 8 &&
                                                    (widget.activecsc == true
                                                            ? numberenable
                                                            : numbersize
                                                        // instagramsize
                                                        ) ==
                                                        true
                                                ? primaryColor
                                                : selected == 9 &&
                                                        whatsappnumberenable ==
                                                            true
                                                    ? primaryColor
                                                    : selected == 10 &&
                                                            weblinkenable ==
                                                                true
                                                        ? primaryColor
                                                        : selected == 11 &&
                                                                emailenable ==
                                                                    true
                                                            ? primaryColor
                                                            : blackcolor,
                      ),
                      onpress: () {
                        setState(() {
                          selected == 3
                              ? profileenable = true
                              : selected == 4
                                  ? logoenable = true
                                  : selected == 5
                                      ? nameenable = true
                                      : selected == 6
                                          ? widget.activecsc == true
                                              ? buisnessnameenable = true
                                              : designationenable = true
                                          : selected == 7
                                              ? widget.activecsc == true
                                                  ? addressenable = true
                                                  : addressenable = true
                                              // facebookenable = true
                                              : selected == 8
                                                  ? widget.activecsc == true
                                                      ? numberenable = true
                                                      : numberenable = true
                                                  // instagramenable = true
                                                  : selected == 9
                                                      ? whatsappnumberenable =
                                                          true
                                                      : selected == 10
                                                          ? weblinkenable = true
                                                          : selected == 11
                                                              ? emailenable =
                                                                  true
                                                              : null;
                        });
                      },
                      color: blackcolor),
              selected == 12
                  ? SizedBox.shrink()
                  : iconbox(
                      name: "Hide",
                      icon: Icon(
                        Icons.visibility_off_outlined,
                        size: 40,
                        color: selected == 3 && profileenable == false
                            ? primaryColor
                            : selected == 4 && logoenable == false
                                ? primaryColor
                                : selected == 5 && nameenable == false
                                    ? primaryColor
                                    : selected == 6 &&
                                            (widget.activecsc == true
                                                    ? buisnessnameenable
                                                    : designationenable) ==
                                                false
                                        ? primaryColor
                                        : selected == 7 &&
                                                (widget.activecsc == true
                                                        ? addressenable
                                                        : addressenable
                                                    // facebookenable
                                                    ) ==
                                                    false
                                            ? primaryColor
                                            : selected == 8 &&
                                                    (widget.activecsc == true
                                                            ? numberenable
                                                            : numberenable
                                                        // instagramenable
                                                        ) ==
                                                        false
                                                ? primaryColor
                                                : selected == 9 &&
                                                        whatsappnumberenable ==
                                                            false
                                                    ? primaryColor
                                                    : selected == 10 &&
                                                            weblinkenable ==
                                                                false
                                                        ? primaryColor
                                                        : selected == 11 &&
                                                                emailenable ==
                                                                    false
                                                            ? primaryColor
                                                            : blackcolor,
                      ),
                      onpress: () {
                        setState(() {
                          selected == 3
                              ? profileenable = false
                              : selected == 4
                                  ? logoenable = false
                                  : selected == 5
                                      ? nameenable = false
                                      : selected == 6
                                          ? widget.activecsc == true
                                              ? buisnessnameenable = false
                                              : designationenable = false
                                          : selected == 7
                                              ? widget.activecsc == true
                                                  ? addressenable = false
                                                  : addressenable = false
                                              //  facebookenable = false
                                              : selected == 8
                                                  ? widget.activecsc == true
                                                      ? numberenable = false
                                                      : numberenable = false
                                                  // instagramenable = false
                                                  : selected == 9
                                                      ? whatsappnumberenable =
                                                          false
                                                      : selected == 10
                                                          ? weblinkenable =
                                                              false
                                                          : selected == 11
                                                              ? emailenable =
                                                                  false
                                                              : null;
                        });
                      },
                      color: blackcolor),
              selected == 3
                  ? iconbox(
                      name: "Upload",
                      icon: Icon(
                        uploadprofileimg.isEmpty
                            ? Icons.camera_alt_outlined
                            : Icons.delete,
                        size: 40,
                        color: primaryColor,
                      ),
                      onpress: () async {
                        if (uploadprofileimg.isEmpty) {
                          var res = await FilePicker.platform.pickFiles(
                              allowMultiple: true,
                              type: FileType.custom,
                              allowedExtensions: [
                                'jpg',
                                'png',
                              ]);

                          if (res != null) {
                            setState(() {
                              uploadprofileimg = res.paths
                                  .map((path) => File("$path"))
                                  .toList();
                            });
                          }
                        } else {
                          setState(() {
                            uploadprofileimg.clear();
                          });
                        }
                      },
                      color: blackcolor)
                  : SizedBox.shrink(),
              selected == 3 || selected == 4
                  ? SizedBox.shrink()
                  : iconbox(
                      name: "Font",
                      icon: Icon(
                        Icons.font_download,
                        size: 40,
                        color: primaryColor,
                      ),
                      onpress: () {
                        fontsheet(context);
                      },
                      color: blackcolor),
              selected == 3 || selected == 4
                  ? SizedBox.shrink()
                  : iconbox(
                      name: "Color",
                      icon: Icon(
                        Icons.color_lens,
                        size: 40,
                        color: primaryColor,
                      ),
                      onpress: () {
                        colorsheet(false);
                      },
                      color: blackcolor)
            ],
          ),
          SizedBox(
              height: selected ==
                      (widget.activecsc == true
                              ? csctypesofpage.length
                              : festivaltypesofpage.length) -
                          1
                  ? 0
                  : 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      "${widget.activecsc == true ? csctypesofpage[selected] : festivaltypesofpage[selected]} Size"),
                  Slider(
                    value: size!.toDouble(),
                    activeColor: primaryColor,
                    inactiveColor: primaryColor,
                    onChanged: (double s) {
                      setState(() {
                        selected == 3
                            ? profilesize = s
                            : selected == 4
                                ? logosize = s
                                : selected == 5
                                    ? namesize = s
                                    : selected == 6
                                        ? widget.activecsc == true
                                            ? buisnessnamesize = s
                                            : designationsize = s
                                        : selected == 7
                                            ? widget.activecsc == true
                                                ? addresssize = s
                                                : facebooksize = s
                                            : selected == 8
                                                ? widget.activecsc == true
                                                    ? numbersize = s
                                                    : instagramsize = s
                                                : selected == 9
                                                    ? whatsappnumbersize = s
                                                    : selected == 10
                                                        ? weblinksize = s
                                                        : selected == 11
                                                            ? emailsize = s
                                                            : selected == 12
                                                                ? watermarksize =
                                                                    s
                                                                : null;
                      });
                    },
                    divisions: 10,
                    min: selected == 12 ? 35.0 : 2.0,
                    max: selected == 12
                        ? 400.0
                        : selected == 3
                            ? 180.0
                            : 50.0,
                  ),
                ],
              ),
            ),
          ),
          selected == csctypesofpage.length - 1
              ? Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("${csctypesofpage[selected]} Opacaity"),
                      Slider(
                        value: watermarkopacity,
                        activeColor: primaryColor,
                        inactiveColor: primaryColor,
                        onChanged: (double s) {
                          setState(() {
                            watermarkopacity = s;
                          });
                        },
                        divisions: 10,
                        min: 0.0,
                        max: 1.0,
                      ),
                    ],
                  ),
                )
              : SizedBox.shrink(),
        ],
      ),
    );
  }

  iconbox({var icon, var color, var name, var onpress}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        children: [
          Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(border: Border.all(color: color)),
              child: IconButton(onPressed: onpress, icon: icon)),
          Text(name)
        ],
      ),
    );
  }

  framepage() {
    var csclist = 8;
    var festivallist = 8;
    var activeprofile =
        widget.activecsc == true ? "cscprofile" : "festivalprofile";
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(
            widget.normalprofile == true
                ? 5
                : widget.activecsc == true
                    ? 8
                    : 7,
            (index) => Padding(
                  padding: const EdgeInsets.only(
                      top: 8.0, bottom: 8, right: 4, left: 2),
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        frameno = index + 1;
                      });
                    },
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: blackcolor),
                            color: whitecolor,
                          ),
                          height: 50,
                          child: SizedBox(
                            height: 50,
                            child: AspectRatio(
                                aspectRatio: videocontroller!.value.aspectRatio,
                                child: VideoPlayer(videocontroller!)),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: CircleAvatar(
                            radius: 15,
                            backgroundColor: (frameno - 1) == index
                                ? appBarColor
                                : primaryColor,
                            child: Text(
                              "${index + 1}",
                              style: TextStyle(fontSize: 20, color: whitecolor),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )),
      ),
    );
  }

  requestedframpage(
    BuildContext context,
  ) {
    return StatefulBuilder(
      builder: (BuildContext context, setState) {
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
              children: List.generate(requestedpremium.length, (index) {
            var value;
            for (int i = 0; i < premiumtemplatelist.length; i++) {
              if (int.parse(requestedpremium[index]['status']) == 0) {
                if (int.parse(premiumtemplatelist[i]['id']) ==
                    int.parse(requestedpremium[index]['template_id'])) {
                  setState(() {
                    value = premiumtemplatelist[i];
                    requestedpremium[index]['header'] =
                        premiumtemplatelist[i]['header'];
                    requestedpremium[index]['footer'] =
                        premiumtemplatelist[i]['footer'];
                  });
                }
              }
            }
            var datedifference = DateTime.now()
                .difference(
                    DateTime.parse(requestedpremium[index]['created_at']))
                .inDays;

            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {
                  setState(() {
                    getdata();
                    yourpremiumfrmaeno = index;
                  });
                  getheight();
                },
                child: Column(
                  children: [
                    Opacity(
                      opacity: yourpremiumfrmaeno == index ? 1.0 : 0.4,
                      child: Container(
                        width: 110,
                        decoration: BoxDecoration(
                          color: whitecolor,
                          boxShadow: yourpremiumfrmaeno == index
                              ? [BoxShadow(blurRadius: 2, color: primaryColor)]
                              : null,
                          border: Border.all(
                              color: yourpremiumfrmaeno == index
                                  ? primaryColor
                                  : blackcolor),
                        ),
                        child: Column(
                          children: [
                            requestedpremium[index]['header'] == null
                                ? SizedBox.shrink()
                                : CachedNetworkImage(
                                    imageUrl:
                                        "$weburl/${requestedpremium[index]['header']}",
                                  ),
                            SizedBox(
                              height: 50,
                              child: AspectRatio(
                                  aspectRatio:
                                      videocontroller!.value.aspectRatio,
                                  child: VideoPlayer(videocontroller!)),
                            ),
                            requestedpremium[index]['footer'] == null
                                ? SizedBox.shrink()
                                : CachedNetworkImage(
                                    imageUrl:
                                        "$weburl/${requestedpremium[index]['footer']}",
                                  ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          })),
        );
      },
    );
  }

  bookframpage() {
    //print(premiumtemplatelist);
    var comparevalue = widget.activecsc == true ? 1 : 2;
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
          children: List.generate(premiumtemplatelist.length, (index) {
        if (int.parse(premiumtemplatelist[index]['poster_type']) ==
            comparevalue) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {
                setState(() {
                  premiumframeno = index;
                });
                getheight();
              },
              child: Column(
                children: [
                  Container(
                    width: 110,
                    decoration: BoxDecoration(
                      color: whitecolor,
                      boxShadow: premiumframeno == index
                          ? [BoxShadow(blurRadius: 2, color: primaryColor)]
                          : null,
                      border: Border.all(
                          color: premiumframeno == index
                              ? primaryColor
                              : blackcolor),
                    ),
                    child: Column(
                      children: [
                        premiumtemplatelist[index]['header'] == null
                            ? SizedBox.shrink()
                            : CachedNetworkImage(
                                imageUrl:
                                    "$weburl/${premiumtemplatelist[index]['header']}"),
                        SizedBox(
                          height: 80,
                          width: 110,
                          child: AspectRatio(
                              aspectRatio: videocontroller!.value.aspectRatio,
                              child: VideoPlayer(videocontroller!)),
                        ),
                        premiumtemplatelist[index]['footer'] == null
                            ? SizedBox.shrink()
                            : CachedNetworkImage(
                                imageUrl:
                                    "$weburl/${premiumtemplatelist[index]['footer']}"),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }
        return SizedBox.shrink();
      })),
    );
  }

  Widget buildvideoheader() {
    var width = MediaQuery.of(context).size.width * 0.93;
    return selected == 1
        ? selectedpremium != 1
            ? selectedpremium != 0
                ? SizedBox.shrink()
                : requestedpremium.isEmpty
                    ? SizedBox.shrink()
                    : requestedpremium[yourpremiumfrmaeno!]['header'] == null ||
                            requestedpremium.isEmpty
                        ? SizedBox.shrink()
                        : CachedNetworkImage(
                            imageUrl:
                                "$weburl/${requestedpremium[yourpremiumfrmaeno!]['header']}",
                            width: width,
                          )
            : premiumtemplatelist.isEmpty
                ? SizedBox.shrink()
                : premiumtemplatelist[premiumframeno!]['header'] == null
                    ? SizedBox.shrink()
                    : CachedNetworkImage(
                        imageUrl:
                            "$weburl/${premiumtemplatelist[premiumframeno!]['header']}",
                        width: width,
                      )
        : widget.activecsc == true && widget.normalprofile == null
            ? getcscheader(
                context,
                frameno: frameno,
                profilevalue: widget.profilevalue,
                buisnessnameenable: buisnessnameenable,
                buisnessnamesize: buisnessnamesize,
                buisnessnamefont: buisnessnamefont,
                buisnessnamecolor: buisnessnamecolor,
                logoenable: logoenable,
                logosize: logosize,
              )
            : SizedBox.shrink();
  }

  Widget buildvideofooter() {
    var width = MediaQuery.of(context).size.width * 0.93;
    return StatefulBuilder(
      builder: (BuildContext context, setState) {
        return Container(
            color: widget.activecsc == true
                ? widget.normalprofile == true
                    ? frameno == 5
                        ? framebackgound == whitecolor
                            ? Color(0xfff60000)
                            : framebackgound
                        : framebackgound
                    : frameno == 4
                        ? framebackgound == whitecolor
                            ? Color(0xff182363)
                            : framebackgound
                        : frameno == 6
                            ? framebackgound == whitecolor
                                ? Color(0xfff60000)
                                : framebackgound
                            : frameno == 8
                                ? framebackgound == whitecolor
                                    ? Color(0xfff60000)
                                    : framebackgound
                                : framebackgound
                : frameno == 3
                    ? framebackgound == whitecolor
                        ? Color(0xfff60000)
                        : framebackgound
                    : frameno == 4
                        ? framebackgound == whitecolor
                            ? Color(0xff21004a)
                            : framebackgound
                        : framebackgound,
            child: selected == 1
                ? selectedpremium != 1
                    ? selectedpremium != 0
                        ? SizedBox.shrink()
                        : requestedpremium.isEmpty
                            ? SizedBox.shrink()
                            : requestedpremium[yourpremiumfrmaeno!]['footer'] ==
                                        null ||
                                    requestedpremium.isEmpty
                                ? SizedBox.shrink()
                                : CachedNetworkImage(
                                    imageUrl:
                                        "$weburl/${requestedpremium[yourpremiumfrmaeno!]['footer']}",
                                    fit: BoxFit.fill,
                                    width: width,
                                  )
                    : premiumtemplatelist.isEmpty
                        ? SizedBox.shrink()
                        : premiumtemplatelist[premiumframeno!]['footer'] ==
                                    null ||
                                premiumtemplatelist.isEmpty
                            ? SizedBox.shrink()
                            : CachedNetworkImage(
                                imageUrl:
                                    "$weburl/${premiumtemplatelist[premiumframeno!]['footer']}",
                                fit: BoxFit.fill,
                                width: width,
                              )
                : widget.normalprofile == true
                    ? getdefaultframe(
                        context,
                        frameno: frameno,
                        profilevalue: widget.profilevalue,
                        profileenable: profileenable,
                        profilesize: profilesize,
                        profileuploadedimage: uploadprofileimg.isNotEmpty
                            ? uploadprofileimg[0]
                            : null,
                        logoenable: logoenable,
                        logosize: logosize,
                        namefont: namefont,
                        namecolor: namecolor,
                        namesize: namesize,
                        nameenable: nameenable,
                        numbercolor: numbercolor,
                        numberenable: numberenable,
                        numberfont: numberfont,
                        numbersize: numbersize,
                        whatsappnumberenable: whatsappnumberenable,
                        whatsappnumbercolor: whatsappnumbercolor,
                        whatsappnumberfont: watermarkfont,
                        whatsappnumbersize: whatsappnumbersize,
                        addressenable: addressenable,
                        addresssize: addresssize,
                        addresscolor: addresscolor,
                        addressfont: addressfont,
                        emailenable: emailenable,
                        emailcolor: emailcolor,
                        emailfont: emailfont,
                        emailsize: emailsize,
                      )
                    : widget.activecsc == true
                        ? getcscframe(
                            context,
                            frameno: frameno,
                            profilevalue: widget.profilevalue,
                            profileenable: profileenable,
                            profilesize: profilesize,
                            profileuploadedimage: uploadprofileimg.isNotEmpty
                                ? uploadprofileimg[0]
                                : null,
                            logoenable: logoenable,
                            logosize: logosize,
                            namefont: namefont,
                            namecolor: namecolor,
                            namesize: namesize,
                            nameenable: nameenable,
                            numbercolor: numbercolor,
                            numberenable: numberenable,
                            numberfont: numberfont,
                            numbersize: numbersize,
                            whatsappnumberenable: whatsappnumberenable,
                            whatsappnumbercolor: whatsappnumbercolor,
                            whatsappnumberfont: watermarkfont,
                            whatsappnumbersize: whatsappnumbersize,
                            addressenable: addressenable,
                            addresssize: addresssize,
                            addresscolor: addresscolor,
                            addressfont: addressfont,
                            emailenable: emailenable,
                            emailcolor: emailcolor,
                            emailfont: emailfont,
                            emailsize: emailsize,
                            weblinkenable: weblinkenable,
                            weblinksize: weblinksize,
                            weblinkfont: weblinkfont,
                            weblinkcolor: weblinkcolor,
                            buisnessnameenable: buisnessnameenable,
                            buisnessnamesize: buisnessnamesize,
                            buisnessnamefont: buisnessnamefont,
                            buisnessnamecolor: buisnessnamecolor,
                          )
                        : getfestivalframe(
                            context,
                            frameno: frameno,
                            profilevalue: widget.profilevalue,
                            profileenable: profileenable,
                            profilesize: profilesize,
                            profileuploadedimage: uploadprofileimg.isNotEmpty
                                ? uploadprofileimg[0]
                                : null,
                            logoenable: logoenable,
                            logosize: logosize,
                            namefont: namefont,
                            namecolor: namecolor,
                            namesize: namesize,
                            nameenable: nameenable,
                            addressenable: addressenable,
                            addresssize: addresssize,
                            addresscolor: addresscolor,
                            addressfont: addressfont,
                            designationenable: designationenable,
                            designationsize: designationsize,
                            designationfont: designationfont,
                            designationcolor: designationcolor,
                            instagramenable: instagramenable,
                            instagramsize: instagramsize,
                            instagramfont: instagramfont,
                            instagramcolor: instagramcolor,
                            facebookenable: facebookenable,
                            facebooksize: facebooksize,
                            facebookfont: facebookfont,
                            facebookcolor: facebookcolor,
                            whatsappnumberenable: whatsappnumberenable,
                            whatsappnumbercolor: whatsappnumbercolor,
                            whatsappnumberfont: watermarkfont,
                            whatsappnumbersize: whatsappnumbersize,
                            emailenable: emailenable,
                            emailcolor: emailcolor,
                            emailfont: emailfont,
                            emailsize: emailsize,
                            weblinkenable: weblinkenable,
                            weblinksize: weblinksize,
                            weblinkfont: weblinkfont,
                            weblinkcolor: weblinkcolor,
                            numbercolor: numbercolor,
                            numberenable: numberenable,
                            numberfont: numberfont,
                            numbersize: numbersize,
                          ));
      },
    );
  }
}

class MyWaveClipper5 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, 30);
    path.lineTo(0, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 30);
    path.quadraticBezierTo(
        size.width * 0.16 * 5, 60, size.width * 0.16 * 4, 30);
    path.quadraticBezierTo(size.width * 0.16 * 3, 0, size.width * 0.16 * 2, 30);
    path.quadraticBezierTo(size.width * 0.16 * 1, 60, 0, 30);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}

class MyWaveClipper6 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, 30);
    path.lineTo(0, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 30);
    path.quadraticBezierTo(
        size.width * 0.16 * 5, 60, size.width * 0.16 * 4, 30);
    path.quadraticBezierTo(size.width * 0.16 * 3, 0, size.width * 0.16 * 2, 30);
    path.quadraticBezierTo(size.width * 0.16 * 1, 60, 0, 30);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}

class MyWaveClipper7 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, 0);
    path.lineTo(0, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);
    path.quadraticBezierTo(
        size.width * 0.15 * 6, 90, size.width * 0.15 * 3, 30);
    path.quadraticBezierTo(size.width * 0.15, 0, 0, 30);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
