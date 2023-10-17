// ignore_for_file: prefer_typing_uninitialized_variables, use_build_context_synchronously
import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:click/pages/getapi.dart';
import 'package:click/pages/sentapi.dart';
import 'package:click/poster_page/defaultframe.dart';
import 'package:click/poster_page/headercscframe.dart';
import 'package:flutter/services.dart';
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
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vector_math/vector_math_64.dart' as vec;
import 'package:flutter/rendering.dart';
import 'dart:ui' as ui;
import 'package:image/image.dart' as img;

class PosterPage extends StatefulWidget {
  var getimage;
  var profilevalue;
  var data;
  var selected;
  bool? normalprofile;
  bool activecsc;
  bool? activewatermark;
  bool? itsgreeting;
  bool? itsjobposter;
  PosterPage(
      {Key? key,
      this.normalprofile,
      this.itsjobposter,
      this.getimage,
      this.itsgreeting,
      this.profilevalue,
      this.selected,
      this.data,
      this.activewatermark,
      required this.activecsc})
      : super(key: key);

  @override
  State<PosterPage> createState() => _PosterPageState();
}

class _PosterPageState extends State<PosterPage> {
  var imageindex;
  var profilesize = 70.0;
  var logosize = 70.0;
  var namesize = 12.0;
  var addresssize = 10.0;
  var numbersize = 10.0;
  var emailsize = 10.0;
  var weblinksize = 8.0;
  var buisnessnamesize = 15.0;
  var watermarksize = 85.0;
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
  var watermarkopacity = 0.5;
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
  var addresscolor;
  var weblinkcolor;
  var buisnessnamecolor;
  var numbercolor;
  var whatsappnumbercolor;
  var emailcolor;
  var watermarkcolor;
  Color framebackgound = whitecolor;
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
  bool premiumprogress = false;
  var requestedpremium = [];
  var selectedpremium;
  int? yourpremiumfrmaeno;
  var posterimage;
  GlobalKey _imageKey = GlobalKey();
  GlobalKey headerkey = GlobalKey();
  GlobalKey footerkey = GlobalKey();
  var imageHeight;
  var imageWeight;
  var footerHeight;
  var headerHeight;
  Offset offset = Offset.zero;
  bool defaultvalue = true;
  double _scale = 1.0;
  double premiumposition = 100;
  late Razorpay _razorpay;

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
      if (widget.activecsc != true) {
        profilesize = 90;
      }
      if (widget.normalprofile == true) {
        profilesize = 60;
      }
    });
  }

  getheight(bool? first) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final imageBox =
          _imageKey.currentContext!.findRenderObject() as RenderBox;
      final headerbox =
          headerkey.currentContext!.findRenderObject() as RenderBox;
      final footerbox =
          footerkey.currentContext!.findRenderObject() as RenderBox;
      headerHeight = headerbox.size.height;
      footerHeight = footerbox.size.height;
      imageHeight = imageBox.size.height;
      imageWeight = imageBox.size.width;
      if (first == true) {
        setoffesetposition();
      }
      setState(() {});
    });
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
  }

  setpostervalue() {
    setState(() {
      posterimage =
          "$weburl/${widget.getimage[imageindex]['subcategory_image']}";
    });
    getheight(false);
  }

  @override
  void initState() {
    super.initState();
    initializeRazorpay();
    getheight(true);
    imageindex = widget.selected;
    selected = 0;
    selectedpremium = 0;
    yourpremiumfrmaeno = 0;
    setpostervalue();
    getdata();
    predifiendtextvalue();
    if (widget.normalprofile == true) {
      setState(() {
        namesize = 12;
        namecolor = redcolor;
      });
    }
  }

  setoffesetposition() {
    var height = MediaQuery.of(context).size.width / 3.8;
    var remaingheight = imageHeight - height;
    if (widget.itsgreeting == true) {
      setState(() {
        offset = Offset(
            0.0 +
                ((int.parse("${widget.getimage[imageindex]['left_position']}") /
                            100) *
                        imageWeight)
                    .toDouble(),
            0.0 +
                ((int.parse("${widget.getimage[imageindex]['top_position']}") /
                            100) *
                        remaingheight)
                    .toDouble());
      });
    }
    if (widget.activewatermark != false) {
      setState(() {
        offset = Offset(
          0.0 + (remaingheight / 2).toDouble(),
          0.0 + (remaingheight / 1.8).toDouble(),
        );
      });
    }
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
    "Watermark",
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
    "Watermark",
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
    "Watermark",
    "Backgound Color"
  ];

  bool progress = false;

  List typeofpremium = ["My Frame", "Book Frame"];
  List<Widget> images() {
    final List<Widget> posterslider = List.generate(widget.getimage.length,
            (index) => '$weburl/${widget.getimage[index]['subcategory_image']}')
        .map(
          (item) => item.isEmpty
              ? Container(
                  decoration:
                      BoxDecoration(border: Border.all(color: blackcolor)),
                )
              : InkWell(
                  onTap: () {},
                  child: buildImage(item, false),
                ),
        )
        .toList();
    return posterslider;
  }

  downloadposter() async {
    final Uint8List image = await downloadwidget();
    // await controller.captureFromWidget(buildImage(posterimage, true),
    //     pixelRatio: 10.0, context: context);
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
    Directory customdirectory = Directory(newPath);
    var status = await Permission.storage.status;
    print(directory);
    print(customdirectory);
    if (!status.isGranted) {
      await Permission.storage.request();
    }

    if (!await customdirectory.exists()) {
      customdirectory.create(recursive: true);
    }

    final File file = File(
        "${customdirectory.path}/poster${DateTime.now().toString().replaceAll(':', '').replaceAll(' ', '').replaceAll('-', '')}.jpg");
    Fluttertoast.showToast(msg: "Saving Image");

    file.writeAsBytesSync(image);
    Fluttertoast.showToast(msg: file.path);

    sendcount('1');
    setState(() {
      progress = false;
    });
  }

  final GlobalKey key = GlobalKey();
  downloadwidget() async {
    RenderRepaintBoundary boundary =
        key.currentContext!.findRenderObject() as RenderRepaintBoundary;
    final image = await boundary.toImage(pixelRatio: 5);
    final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    final pngBytes = byteData!.buffer.asUint8List();
    print(pngBytes);
    // final image1 = img.decodeImage(Uint8List.fromList(pngBytes));

    // final compressedImage =

    //     img.encodeJpg(image1!, quality: (0.2 * 100).toInt());

    // return compressedImage;
    return pngBytes;
  }

  sharefile() async {
    final Uint8List image = await downloadwidget();
    // await controller.captureFromWidget(buildImage(posterimage, true),
    //     pixelRatio: 10.0, context: context);
    var link = "${widget.getimage[imageindex]['weblink']}";
    Share.shareXFiles([
      XFile.fromData(
        image,
        mimeType: "jpg",
      ),
    ],
            subject:
                "Shared ${widget.getimage[imageindex]['poster_name']} From Addon app",
            text: link.isEmpty || link == 'null' || link == ''
                ? null
                : link.contains('https://')
                    ? link
                    : widget.itsjobposter == true
                        ? "${widget.profilevalue['web_url2'] ?? (widget.activecsc == true ? cscvalue[0]['web_url2'] : festivalprofilevalue[0]['web_url2'])}$link"
                        : "${widget.profilevalue['web_url'] ?? (widget.activecsc == true ? cscvalue[0]['web_url'] : festivalprofilevalue[0]['web_url'])}$link")
        .then((value) async {
      if (value.status == ShareResultStatus.success) {
        sendcount('2');
        if (subscriptiondetail != null) {
          if (int.parse(subscriptiondetail['days_left']) >= 0) {
            if (int.parse(balancedata['available_balance']) >=
                double.parse(widget.getimage[imageindex]['rate'])) {
              amountdetuction(
                amount: widget.getimage[imageindex]['rate'],
                title: widget.getimage[imageindex]['poster_name'] == null
                    ? "${widget.getimage[imageindex]['poster_name']} Share"
                    : "Poster Share",
                type: subscriptiondetail['plan_type'],
              );
            }
          }
        }
        await SentApi().getbalancedata();
        await SentApi().getdownloadandsharedata();
        setState(() {
          progress = false;
        });
        return true;
      } else {
        Fluttertoast.showToast(msg: 'Image Not shared');
      }
      setState(() {
        progress = false;
      });
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
              onTap: () async {
                await Clipboard.setData(ClipboardData(text: "$link"));
                Fluttertoast.showToast(msg: "Link Copy Sucesfully");
                launchUrl(Uri.parse(link),
                    mode: LaunchMode.externalApplication);
              },
              child: Text(
                "$name",
                textAlign: TextAlign.center,
                style: TextStyle(color: whitecolor, fontSize: 20),
              ),
            ),
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    print(widget.normalprofile);
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
                    ? SizedBox.shrink()
                    : InkWell(
                        onTap: () {
                          print(widget.getimage[imageindex]['rate']);
                          if (subscriptiondetail != null) {
                            if (int.parse(subscriptiondetail['days_left']) >=
                                0) {
                              if (int.parse(balancedata['available_balance']) >=
                                  double.parse(
                                      widget.getimage[imageindex]['rate'])) {
                                setState(() {
                                  progress = true;
                                });
                                sharefile();
                              } else {
                                noamountbottomsheet(context, "share");
                              }
                            } else {
                              if (double.parse(
                                      widget.getimage[imageindex]['rate']) ==
                                  0) {
                                setState(() {
                                  progress = true;
                                });
                                sharefile();
                              } else {
                                // toScreen(context, Subscriptionpage());
                                nosubscriptiondialog(context);
                              }
                            }
                          } else {
                            if (double.parse(
                                    widget.getimage[imageindex]['rate']) ==
                                0) {
                              setState(() {
                                progress = true;
                              });
                              sharefile();
                            } else {
                              // toScreen(context, Subscriptionpage());
                              nosubscriptiondialog(context);
                            }
                          }
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width / 2.2,
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              color: appBarColor,
                              borderRadius: BorderRadius.circular(5)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                'Share',
                                style:
                                    TextStyle(color: whitecolor, fontSize: 20),
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
                progress == true
                    ? SizedBox.shrink()
                    : InkWell(
                        onTap: () {
                          if (subscriptiondetail != null) {
                            if (int.parse(subscriptiondetail['days_left']) >=
                                0) {
                              if (int.parse(balancedata['available_balance']) >=
                                  double.parse(
                                      widget.getimage[imageindex]['rate'])) {
                                setState(() {
                                  progress = true;
                                });
                                downloadposter().then((value) {
                                  amountdetuction(
                                    amount: widget.getimage[imageindex]['rate'],
                                    title: widget.getimage[imageindex]
                                            ['poster_name'] ??
                                        "Poster",
                                    type: subscriptiondetail['plan_type'],
                                  );
                                  setState(() {
                                    progress = false;
                                  });
                                });
                              } else {
                                noamountbottomsheet(context, "download");
                              }
                            } else {
                              if (double.parse(
                                      widget.getimage[imageindex]['rate']) ==
                                  0) {
                                setState(() {
                                  progress = true;
                                });
                                downloadposter().then((value) {
                                  setState(() {
                                    progress = false;
                                  });
                                });
                              } else {
                                // toScreen(context, Subscriptionpage());
                                nosubscriptiondialog(context);
                              }
                            }
                          } else {
                            if (double.parse(
                                    widget.getimage[imageindex]['rate']) ==
                                0) {
                              setState(() {
                                progress = true;
                              });
                              downloadposter().then((value) {
                                setState(() {
                                  progress = false;
                                });
                              });
                            } else {
                              // toScreen(context, Subscriptionpage());
                              nosubscriptiondialog(context);
                            }
                          }
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width / 2.2,
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              color: appBarColor,
                              borderRadius: BorderRadius.circular(5)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                'Download',
                                style:
                                    TextStyle(color: whitecolor, fontSize: 20),
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
                      children: [
                        Opacity(
                          opacity: 0.1,
                          child: RepaintBoundary(
                              key: footerkey, child: premiumfooterbox()),
                        ),
                        Opacity(
                          opacity: 0.1,
                          child: RepaintBoundary(
                              key: headerkey, child: premiumheaderbox()),
                        ),
                        RepaintBoundary(
                            key: _imageKey,
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Opacity(
                                  opacity: progress == true ? 0.5 : 1.0,
                                  child: buildImage(posterimage, false),
                                ),
                                progress == true
                                    ? CircularProgressIndicator()
                                    : SizedBox.shrink()
                              ],
                            )),
                      ],
                    ),
                    h(10),
                    widget.itsgreeting == null || widget.itsgreeting == false
                        ? SizedBox.shrink()
                        : Slider(
                            value: _scale,
                            activeColor: primaryColor,
                            inactiveColor: primaryColor,
                            onChanged: (double s) {
                              setState(() {
                                _scale = s;
                              });
                            },
                            divisions: 10,
                            min: 1.0,
                            max: 5.0,
                          ),
                    selected == 1
                        ? widget.activecsc == true
                            ? SizedBox.shrink()
                            : Column(
                                children: [
                                  Text("Adjust Your Frame Position"),
                                  Slider(
                                    value: premiumposition,
                                    activeColor: primaryColor,
                                    inactiveColor: primaryColor,
                                    onChanged: (double s) {
                                      getheight(false);
                                      setState(() {
                                        premiumposition = s;
                                      });
                                    },
                                    divisions: 1000,
                                    min: 1.0,
                                    max: 1000.0,
                                  ),
                                ],
                              )
                        : SizedBox.shrink(),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(
                            widget.getimage.length,
                            (index) => Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        imageindex = index;
                                      });
                                      setpostervalue();
                                      getheight(false);
                                    },
                                    child: Container(
                                      height:
                                          MediaQuery.of(context).size.width / 9,
                                      width:
                                          MediaQuery.of(context).size.width / 9,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: imageindex == index
                                                ? primaryColor
                                                : blackcolor),
                                      ),
                                      child: CachedNetworkImage(
                                        imageUrl:
                                            "$weburl/${widget.getimage[index]['subcategory_image']}",
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                )),
                      ),
                    )
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
                        : festivaltypesofpage.length, (index) {
                  if ("${defaulttypeofpage[index]}" == "" &&
                      widget.normalprofile == true) {
                    return SizedBox.shrink();
                  }
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {
                        getheight(false);
                        setState(() {
                          selected = index;
                        });
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
                          padding: const EdgeInsets.all(5.0),
                          child: Text(
                            widget.activecsc == true
                                ? widget.normalprofile == true
                                    ? "${defaulttypeofpage[index]}"
                                    : "${csctypesofpage[index]}"
                                : "${festivaltypesofpage[index]}",
                            textScaleFactor: 1.2,
                            style: TextStyle(
                                color: selected == index
                                    ? whitecolor
                                    : blackcolor),
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
            selected == 0
                ? framepage(
                    posterimage,
                  )
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
                                            getheight(false);
                                            setState(() {
                                              selectedpremium = index;
                                            });
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
                                                textScaleFactor: 1.2,
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
                                  ? Text(
                                      "Please Book Your Frame",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: primaryColor,
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
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
                                          posterimage,
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
                                        bookframpage(
                                          posterimage,
                                        ),
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
                                          notificationdialog(context,
                                              text:
                                                  "${currentposterimages[0]['premium_msg']}",
                                              onpress: () {
                                            if (double.parse(
                                                    premiumtemplatelist[
                                                            premiumframeno!]
                                                        ['rate']) ==
                                                0.0) {
                                              setState(() {
                                                premiumprogress = true;
                                              });
                                              requestpremiumtemplate(
                                                      premiumtemplatelist[
                                                              premiumframeno!]
                                                          ['id'])
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
                                          });
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
                        ? SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                widget.getimage[imageindex]['weblink'] ==
                                            null ||
                                        widget.getimage[imageindex]
                                                ['weblink'] ==
                                            ""
                                    ? SizedBox.shrink()
                                    : posterdetails(
                                        "${widget.getimage[imageindex]['weblink']}",
                                        "See Details"),
                                widget.getimage[imageindex]['videolink'] ==
                                            null ||
                                        widget.getimage[imageindex]
                                                ['videolink'] ==
                                            ""
                                    ? SizedBox.shrink()
                                    : posterdetails(
                                        "${widget.getimage[imageindex]['videolink']}",
                                        "See Video"),
                                widget.getimage[imageindex]['pdflink'] ==
                                            null ||
                                        widget.getimage[imageindex]
                                                ['pdflink'] ==
                                            ""
                                    ? SizedBox.shrink()
                                    : posterdetails(
                                        "${widget.getimage[imageindex]['pdflink']}",
                                        "Login Link"),
                                widget.getimage[imageindex]['joblink'] ==
                                            null ||
                                        widget.getimage[imageindex]
                                                ['joblink'] ==
                                            ""
                                    ? SizedBox.shrink()
                                    : posterdetails(
                                        "${widget.getimage[imageindex]['joblink']}",
                                        "Job Link"),
                              ],
                            ),
                          )
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
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
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
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 15),
                ),
                MaterialButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
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
              child: ListView(
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
                                                : addresscolor = color
                                            // facebookcolor = color
                                            : selected == 8
                                                ? widget.activecsc == true
                                                    ? numbercolor = color
                                                    : numbercolor = color
                                                // instagramcolor = color
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
                    : addressfont
                // facebookfont
                : selected == 8
                    ? widget.activecsc == true
                        ? numberfont
                        : numberfont
                    //  instagramfont
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
                                                : addressfont = fontlist[index]
                                            // facebookfont = fontlist[index]
                                            : selected == 8
                                                ? widget.activecsc == true
                                                    ? numberfont =
                                                        fontlist[index]
                                                    : numberfont =
                                                        fontlist[index]

                                                // instagramfont =
                                                //     fontlist[index]
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
                                                    // facebookenable
                                                    ) ==
                                                    true
                                            ? primaryColor
                                            : selected == 8 &&
                                                    (widget.activecsc == true
                                                            ? numberenable
                                                            : numberenable
                                                        // instagramenable
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
                                              // facebookenable = false
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
                            List files = res.paths.map((path) => path).toList();
                            CroppedFile? croppedFile =
                                await ImageCropper().cropImage(
                              sourcePath: files[0],
                              compressFormat:
                                  "${files[0]}".split(".").last == "png"
                                      ? ImageCompressFormat.png
                                      : ImageCompressFormat.jpg,
                              aspectRatioPresets: [
                                CropAspectRatioPreset.square,
                                CropAspectRatioPreset.ratio3x2,
                                CropAspectRatioPreset.original,
                                CropAspectRatioPreset.ratio4x3,
                                CropAspectRatioPreset.ratio16x9
                              ],
                              uiSettings: [
                                AndroidUiSettings(
                                    toolbarTitle: 'Cropper',
                                    toolbarColor: Colors.deepOrange,
                                    toolbarWidgetColor: Colors.white,
                                    initAspectRatio:
                                        CropAspectRatioPreset.original,
                                    lockAspectRatio: false),
                              ],
                            );
                            if (croppedFile != null) {
                              setState(() {
                                uploadprofileimg = res.paths
                                    .map((path) => File("${croppedFile.path}"))
                                    .toList();
                              });
                            }
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
              selected == 3 || selected == 4 || selected == 12
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
                      getheight(false);
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
                                                : addresssize = s
                                            // facebooksize = s
                                            : selected == 8
                                                ? widget.activecsc == true
                                                    ? numbersize = s
                                                    : numbersize = s
                                                // instagramsize = s
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
                    divisions: 1000,
                    min: selected == 12 ? 35.0 : 2.0,
                    max: selected == 12
                        ? 400.0
                        : selected == 3
                            ? 180.0
                            : 200.0,
                  ),
                ],
              ),
            ),
          ),
          selected == 12
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
                        divisions: 100,
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

  framepage(var image) {
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
                      getheight(false);
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
                          height: 80,
                          width: 90,
                          child: CachedNetworkImage(
                            imageUrl: image,
                            fit: BoxFit.fill,
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

  requestedframpage(BuildContext context, var image) {
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
            return Padding(
              padding:
                  const EdgeInsets.only(top: 8.0, bottom: 8, right: 4, left: 2),
              child: InkWell(
                onTap: () {
                  getheight(false);
                  setState(() {
                    getdata();
                    yourpremiumfrmaeno = index;
                  });
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
                            Container(
                              height: 80,
                              width: 110,
                              child: CachedNetworkImage(
                                imageUrl: image,
                                fit: BoxFit.fill,
                              ),
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

  bookframpage(var image) {
    //print(premiumtemplatelist);
    var comparevalue = widget.activecsc == true ? 1 : 2;
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
          children: List.generate(premiumtemplatelist.length, (index) {
        if (int.parse(premiumtemplatelist[index]['poster_type']) ==
            comparevalue) {
          return Padding(
            padding:
                const EdgeInsets.only(top: 8.0, bottom: 8, right: 4, left: 2),
            child: InkWell(
              onTap: () {
                setState(() {
                  premiumframeno = index;
                });
                getheight(false);
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
                        Container(
                          height: 80,
                          width: 110,
                          child: CachedNetworkImage(
                            imageUrl: image,
                            fit: BoxFit.fill,
                          ),
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

  Widget buildImage(var image, bool? downloadandshare) {
    print(image);
    var remaingheight = imageHeight == null
        ? 400
        : (imageHeight -
            ((widget.activecsc == true
                    ? footerHeight
                    : selected == 1
                        ? premiumposition
                        : footerHeight) +
                headerHeight -
                (downloadandshare == true ? 20.0 : 0.0)));
    print(MediaQuery.of(context).size.width / 3272);
    Color watermarkcolor = widget.getimage[imageindex]['color_code'] == null
        ? blackcolor
        : Color(int.parse(
                "${widget.getimage[imageindex]['color_code']}".split("#").last,
                radix: 16) +
            0xFF000000);
    return StatefulBuilder(
      builder: (BuildContext context, setState) {
        return RepaintBoundary(
          key: key,
          child: Wrap(
            children: [
              Container(
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
                  child: Stack(
                    clipBehavior: Clip.hardEdge,
                    children: [
                      Column(
                        children: [
                          premiumheaderbox(),
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              Positioned(
                                top: offset.dy,
                                left: offset.dx,
                                child: Transform(
                                    transform: Matrix4.diagonal3(
                                        vec.Vector3(_scale, _scale, _scale)),
                                    alignment: FractionalOffset.center,
                                    child: greetingimage.isEmpty
                                        ? Container(
                                            height: 140,
                                            width: 140,
                                            child: const Text(
                                              'Double Tap To Upload Image',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(fontSize: 15),
                                            ))
                                        : Container(
                                            height: 140,
                                            width: 140,
                                            child: Image.file(
                                              greetingimage[0],
                                              scale: _scale,
                                            ),
                                          )),
                              ),
                              CachedNetworkImage(
                                imageUrl: image,
                                fit: BoxFit.fill,
                              ),
                              Positioned(
                                top: offset.dy,
                                left: offset.dx,
                                child: GestureDetector(
                                    onDoubleTap: () async {
                                      if (greetingimage.isEmpty) {
                                        var res = await FilePicker.platform
                                            .pickFiles(
                                                allowMultiple: true,
                                                type: FileType.custom,
                                                allowedExtensions: [
                                              'jpg',
                                              'png',
                                            ]);
                                        if (res != null) {
                                          List files = res.paths
                                              .map((path) => path)
                                              .toList();
                                          CroppedFile? croppedFile =
                                              await ImageCropper().cropImage(
                                            sourcePath: files[0],
                                            compressFormat:
                                                "${files[0]}".split(".").last ==
                                                        "png"
                                                    ? ImageCompressFormat.png
                                                    : ImageCompressFormat.jpg,
                                            aspectRatioPresets: [
                                              CropAspectRatioPreset.square,
                                              CropAspectRatioPreset.ratio3x2,
                                              CropAspectRatioPreset.original,
                                              CropAspectRatioPreset.ratio4x3,
                                              CropAspectRatioPreset.ratio16x9
                                            ],
                                            uiSettings: [
                                              AndroidUiSettings(
                                                  toolbarTitle: 'Cropper',
                                                  toolbarColor:
                                                      Colors.deepOrange,
                                                  toolbarWidgetColor:
                                                      Colors.white,
                                                  initAspectRatio:
                                                      CropAspectRatioPreset
                                                          .original,
                                                  lockAspectRatio: false),
                                            ],
                                          );
                                          if (croppedFile != null) {
                                            setState(() {
                                              greetingimage.add(
                                                  File("${croppedFile.path}"));
                                            });
                                          }
                                        }
                                      } else {
                                        setState(() {
                                          greetingimage.clear();
                                        });
                                      }
                                    },
                                    onPanUpdate: (details) {
                                      setState(() {
                                        defaultvalue = false;
                                        offset = Offset(
                                            offset.dx + details.delta.dx,
                                            offset.dy + details.delta.dy);
                                      });
                                      print(details.delta.dx);
                                      print(details.delta.dy);
                                    },
                                    child: Transform(
                                      transform: Matrix4.diagonal3(
                                          vec.Vector3(_scale, _scale, _scale)),
                                      alignment: FractionalOffset.center,
                                      child: Container(
                                        width: 250,
                                        height: 250,
                                        color: Colors.transparent,
                                      ),
                                    )),
                              ),
                            ],
                          ),
                          widget.activecsc == true
                              ? premiumfooterbox()
                              : selected == 1
                                  ? Stack(
                                      clipBehavior: Clip.none,
                                      children: [
                                        Container(
                                          height: premiumposition,
                                        ),
                                        selected == 1
                                            ? Positioned(
                                                bottom: 0,
                                                right: 0,
                                                left: 0,
                                                child: premiumfooterbox())
                                            : SizedBox.shrink()
                                      ],
                                    )
                                  : premiumfooterbox()
                        ],
                      ),
                      cscvalue.isEmpty ||
                              cscvalue[0]['csc_logo'] == null ||
                              widget.activewatermark == false
                          ? const SizedBox.shrink()
                          : Positioned(
                              left: offset.dx,
                              top: offset.dy,
                              child: GestureDetector(
                                onPanUpdate: (details) {
                                  setState(() {
                                    defaultvalue = false;
                                    offset = Offset(
                                        offset.dx + details.delta.dx,
                                        offset.dy + details.delta.dy);
                                  });
                                },
                                child: Opacity(
                                  opacity: watermarkopacity,
                                  child: Image.network(
                                    "$weburl/${cscvalue[0]['csc_logo']}",
                                    height: watermarksize,
                                    width: watermarksize,
                                  ),
                                ),
                              ),
                            ),
                      widget.getimage[imageindex]['top_position'] == null ||
                              widget.activewatermark == false
                          ? const SizedBox.shrink()
                          : Positioned(
                              top: imageHeight != null
                                  ? widget.getimage[imageindex]
                                              ['top_position'] ==
                                          null
                                      ? double.parse("${remaingheight / 2}") +
                                          (headerHeight ?? 0.0)
                                      : ((int.parse("${widget.getimage[imageindex]['top_position']}") /
                                                      100) *
                                                  remaingheight)
                                              .toDouble() +
                                          (headerHeight ?? 0.0)
                                  : 40,
                              child: Opacity(
                                opacity: widget.getimage[imageindex]
                                            ['opacity'] ==
                                        null
                                    ? 1.0
                                    : double.parse(
                                        "${widget.getimage[imageindex]['opacity']}"),
                                child: Transform(
                                  alignment: FractionalOffset(
                                      MediaQuery.of(context).size.width /
                                          ((14 +
                                                  (cscvalue.isNotEmpty
                                                      ? " ${widget.profilevalue['business_name'] ?? cscvalue[0]['business_name']} "
                                                          .length
                                                      : "".length)) *
                                              double.parse(
                                                  widget.getimage[imageindex]
                                                          ['font_size'] ??
                                                      "9") *
                                              15),
                                      0),
                                  transform: Matrix4.identity()
                                    ..rotateZ(double.parse(
                                            "${widget.getimage[imageindex]['degree'] ?? 0}") *
                                        3.1415927 /
                                        180),
                                  child: Wrap(
                                    // mainAxisAlignment: MainAxisAlignment.start,
                                    children: List.generate(
                                        15,
                                        (index) => Wrap(
                                              children: [
                                                Text(
                                                  cscvalue.isNotEmpty
                                                      ? " ${widget.profilevalue['business_name'] ?? cscvalue[0]['business_name']} "
                                                      : "",
                                                  overflow: TextOverflow.clip,
                                                  style: TextStyle(
                                                      fontSize: double.parse(
                                                          widget.getimage[
                                                                      imageindex]
                                                                  [
                                                                  'font_size'] ??
                                                              "9"),
                                                      fontFamily:
                                                          watermarkfont != null
                                                              ? watermarkfont[
                                                                  'font']
                                                              : "EkMukta-Bold",
                                                      color: watermarkcolor),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 3.0),
                                                  child: Icon(
                                                    Icons.phone_in_talk,
                                                    size: double.parse(
                                                        widget.getimage[
                                                                    imageindex]
                                                                ['font_size'] ??
                                                            "9"),
                                                    color: watermarkcolor,
                                                  ),
                                                ),
                                                Text(
                                                  " ${userdata['mobileno']} |",
                                                  style: TextStyle(
                                                      fontSize: double.parse(
                                                          widget.getimage[
                                                                      imageindex]
                                                                  [
                                                                  'font_size'] ??
                                                              "9"),
                                                      fontFamily:
                                                          watermarkfont != null
                                                              ? watermarkfont[
                                                                  'font']
                                                              : "EkMukta-Bold",
                                                      color: watermarkcolor),
                                                )
                                              ],
                                            )),
                                  ),
                                ),
                              ),
                            ),
                    ],
                  )),
            ],
          ),
        );
      },
    );
  }

  premiumheaderbox() {
    return selected == 1
        ? selectedpremium != 1
            ? selectedpremium != 0
                ? const SizedBox.shrink()
                : requestedpremium.isEmpty
                    ? const SizedBox.shrink()
                    : requestedpremium[yourpremiumfrmaeno!]['header'] == null ||
                            requestedpremium.isEmpty
                        ? const SizedBox.shrink()
                        : CachedNetworkImage(
                            imageUrl:
                                "$weburl/${requestedpremium[yourpremiumfrmaeno!]['header']}")
            : premiumtemplatelist.isEmpty
                ? const SizedBox.shrink()
                : premiumtemplatelist[premiumframeno!]['header'] == null
                    ? const SizedBox.shrink()
                    : CachedNetworkImage(
                        imageUrl:
                            "$weburl/${premiumtemplatelist[premiumframeno!]['header']}")
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

  premiumfooterbox() {
    return selected == 1
        ? selectedpremium != 1
            ? selectedpremium != 0
                ? SizedBox.shrink()
                : requestedpremium.isEmpty
                    ? SizedBox.shrink()
                    : requestedpremium[yourpremiumfrmaeno!]['footer'] == null ||
                            requestedpremium.isEmpty
                        ? SizedBox.shrink()
                        : CachedNetworkImage(
                            imageUrl:
                                "$weburl/${requestedpremium[yourpremiumfrmaeno!]['footer']}",
                            fit: BoxFit.fill,
                          )
            : premiumtemplatelist.isEmpty
                ? SizedBox.shrink()
                : premiumtemplatelist[premiumframeno!]['footer'] == null ||
                        premiumtemplatelist.isEmpty
                    ? SizedBox.shrink()
                    : CachedNetworkImage(
                        imageUrl:
                            "$weburl/${premiumtemplatelist[premiumframeno!]['footer']}",
                        fit: BoxFit.fill,
                      )
        : widget.normalprofile == true
            ? getdefaultframe(
                context,
                frameno: frameno,
                profilevalue: widget.profilevalue,
                profileenable: profileenable,
                profilesize: profilesize,
                profileuploadedimage:
                    uploadprofileimg.isNotEmpty ? uploadprofileimg[0] : null,
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
                whatsappnumberfont: whatsnumberfont,
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
                    whatsappnumberfont: whatsnumberfont,
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
                    whatsappnumberfont: whatsnumberfont,
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
