import 'dart:convert';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:click/pages/sentapi.dart';
import 'package:click/subscription_page.dart';
import 'package:click/utils/constants.dart';
import 'package:click/utils/navigation.dart';
import 'package:click/utils/styles.dart';
// import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class Logoposter extends StatefulWidget {
  var data;
  var type;
  Logoposter({super.key, this.data, this.type});

  @override
  State<Logoposter> createState() => _LogoposterState();
}

class _LogoposterState extends State<Logoposter> {
  TextEditingController note = TextEditingController();
  bool progress = false;
  var pickedcolor;
  late Razorpay _razorpay;

  void launchRazorpay() {
    var doublevalue = double.parse(widget.data['price']);
    var totalval = doublevalue.toInt() * 100;

    var options = {
      'key': "$razorpaykeyvalue",
      // "rzp_test_85DOqw8mTlI3CT",
      'amount': totalval,
      'currency': 'INR',
      'name': 'ADDON',
      'description': "Logo Booking",
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
    requestalogo();
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    if (kDebugMode) {
      //print('Payment error');
      Fluttertoast.showToast(msg: 'Payment error');
    }
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    if (kDebugMode) {
      //print('External wallet');
      Fluttertoast.showToast(msg: 'Payment Failed');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pickedcolor = blackcolor;
    initializeRazorpay();
    newstate();
  }

  newstate() {
    for (var i in requestedlogo) {
      if (i['logo_id'] == widget.data['id']) {
        setState(() {
          alreadyrequested = true;
          requestedvalue = i;
        });
      }
    }
  }

  bool alreadyrequested = false;
  var requestedvalue;
  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  requestalogo() async {
    var color = "$pickedcolor".split("(").last.split(")").first;
    var message;
    try {
      setState(() {
        progress = true;
      });
      http.Response response =
          await http.post(Uri.parse("${baseurl}logo_request"), body: {
        "color": color,
        "logo_id": widget.data['id'],
        "notes": note.text,
      }, headers: {
        'token': token
      });
      var mapresponse = jsonDecode(response.body);

      message = mapresponse['response']['response_message'];
      if (response.statusCode == 200) {
        setState(() {
          progress = false;
        });
        Fluttertoast.showToast(msg: message);
        backscreen(context);
        backscreen(context);
        if ("${mapresponse['data']}" != "0") {
          dialog(context,
              "आपला लोगो successfully बुक झालेला आहे. पुढील माहितीसाठी आपल्या WhatsApp नंबर वरती एक मेसेज पाठवला आहे कृपया तो पूर्ण वाचावा. जर WhatsApp वरती मेसेज आला नसेल तर आमच्याशी संपर्क साधावा.  ");
        }
      }
    } catch (e) {
      Fluttertoast.showToast(msg: message);
      setState(() {
        progress = false;
      });
    }
  }

  var downloadingprogress = false;
  var selecteddownload = null;

  @override
  Widget build(BuildContext context) {
    print(alreadyrequested);
    var imageissvg = ("${widget.data['logo']}".split(".").last == 'svg');

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: primaryColor,
          title: Text(widget.type),
        ),
        body: ListView(
          children: [
            Container(
              color: Colors.grey.shade300,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: imageissvg == true
                    ? SvgPicture.network('$weburl/${widget.data['logo']}')
                    : CachedNetworkImage(
                        width: MediaQuery.of(context).size.width * .93,
                        imageUrl: alreadyrequested != true
                            ? '$weburl/${widget.data['logo']}'
                            : requestedvalue['poster'] == null ||
                                    requestedvalue['poster'] == "NA"
                                ? '$weburl/${widget.data['logo']}'
                                : '$weburl/${requestedvalue['poster']}',
                        fit: BoxFit.fitHeight,
                      ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '\u{20B9} ${widget.data['price']}',
                    style: TextStyle(
                        color: blackcolor,
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      widget.data['logonu'] == null
                          ? 'ID: MH-0${widget.data['id']}'
                          : "${widget.data['logonu']}",
                      textAlign: TextAlign.center,
                      textScaleFactor: 1.5,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
                padding: const EdgeInsets.all(10.0),
                child: MaterialButton(
                  color: pickedcolor,
                  onPressed: () {
                    showDialog(
                      builder: (context) => AlertDialog(
                        title: const Text('Pick a color!'),
                        content: SingleChildScrollView(
                          child: ColorPicker(
                            pickerColor: pickedcolor,
                            onColorChanged: (value) {
                              setState(() {
                                pickedcolor = value;
                              });
                            },
                          ),
                        ),
                      ),
                      context: context,
                    );
                  },
                  child: Text(
                    "Pick A color",
                    style: TextStyle(
                        color: whitecolor,
                        fontWeight: FontWeight.w400,
                        fontSize: 25),
                  ),
                )),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: note,
                maxLines: 3,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(width: 3, color: Colors.redAccent),
                    ),
                    hintText: "Add your Reference",
                    labelText: "Enter Your Buisness Name In Marathi & English"),
              ),
            ),
            alreadyrequested == true
                ? Column(
                    children: [
                      int.parse(requestedvalue['status']) == 0
                          ? Text(
                              "Request Is in Progress",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )
                          : const SizedBox.shrink(),
                      requestedvalue['poster'] == null ||
                              requestedvalue['poster'] == 'NA'
                          ? SizedBox.shrink()
                          : downloadingprogress == false
                              ? MaterialButton(
                                  onPressed: () {
                                    setState(() {
                                      downloadingprogress = true;
                                    });
                                    downloadlogo(
                                        '$weburl/${requestedvalue['poster']}');
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text("Download"),
                                      Icon(Icons.download)
                                    ],
                                  ),
                                )
                              : SizedBox.shrink(),
                    ],
                  )
                : progress == true
                    ? Center(child: CircularProgressIndicator())
                    : Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: () {
                            notificationdialog(context,
                                text: "${currentposterimages[0]['logo_mgs']}",
                                onpress: () {
                              if (double.parse(widget.data['price']) > 0) {
                                confirmationdialog(
                                    button: MaterialButton(
                                  color: greyshade400,
                                  onPressed: () {
                                    launchRazorpay();
                                  },
                                  child: Text(
                                    "Pay For Logo",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ));
                              } else {
                                requestalogo();
                              }
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: appBarColor,
                                border: Border.all(
                                  color: blackcolor,
                                ),
                                borderRadius: BorderRadius.circular(10)),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                widget.type == "Design Logo"
                                    ? 'Request Logo'
                                    : 'Request Facebook coverpage',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: whitecolor,
                                  fontFamily: "Poppins",
                                  fontSize: 25,
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
          ],
        ),
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

  confirmationdialog({var button}) {
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, setState) {
            return Dialog(
              child: Wrap(
                alignment: WrapAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: InkWell(
                      onTap: () {
                        backscreen(context);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(Icons.close),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Column(
                          children: [
                            const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                "Your Picked Color",
                                textScaleFactor: 1.2,
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width / 2,
                              color: pickedcolor,
                              child: const Text(
                                "",
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                        note.text.isNotEmpty
                            ? Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    const Text(
                                      "Your Note:-",
                                      textScaleFactor: 1.2,
                                    ),
                                    Text(
                                      " ${note.text}",
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              )
                            : SizedBox.shrink(),
                      ],
                    ),
                  ),
                  button
                ],
              ),
            );
          },
        );
      },
    );
  }
}
