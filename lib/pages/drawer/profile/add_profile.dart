import 'dart:convert';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:click/pages/getapi.dart';
import 'package:click/utils/navigation.dart';
import 'package:click/widgets/confirmation.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:click/pages/authcredential.dart';
import 'package:click/pages/drawer/profile/photos.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_cropper/image_cropper.dart';
import '../../../helpers/layout.dart';
import '../../../utils/constants.dart';
import '../../../utils/styles.dart';
import '../../../widgets/button.dart';
import '../../../widgets/textfield.dart';

class Addprofile extends StatefulWidget {
  final bool csc;
  final bool festival;
  final bool buisness;

  const Addprofile(
      {super.key,
      required this.csc,
      required this.buisness,
      required this.festival});

  @override
  State<Addprofile> createState() => _AddprofileState();
}

class _AddprofileState extends State<Addprofile> {
  bool get csc => widget.csc;
  bool get buisness => widget.buisness;
  bool get festival => widget.festival;

  bool editMode = false;
  TextEditingController name = TextEditingController();
  TextEditingController designation = TextEditingController();
  TextEditingController designation2 = TextEditingController();
  TextEditingController facebook = TextEditingController();
  TextEditingController instagram = TextEditingController();
  TextEditingController twitter = TextEditingController();
  TextEditingController whatsapp = TextEditingController();
  TextEditingController mobile = TextEditingController();
  TextEditingController website = TextEditingController();
  TextEditingController website2 = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController tagline = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController buisnessname = TextEditingController();

  bool progress = false;
  List path1 = [];
  List path2 = [];

  var image;
  var image2;

  toggleEditMode(bool val) {
    setState(() {
      editMode = val;
    });
  }

  getprofile() async {
    var key = (csc == true
        ? "cscprofile"
        : festival == true
            ? "festivalprofile"
            : "businessprofile");
    var logoimagevalue = widget.csc == true
        ? "csc_logo"
        : festival == true
            ? "festival_logo"
            : "business_img";
    var data = await Authcredential().getfromlocal(key);
    csc == true
        ? SentApi().getcscprofieldata().then((value) {
            setState(() {});
          })
        : festival == true
            ? SentApi().getfestivalprofile().then((value) {
                setState(() {});
              })
            : SentApi().getbuisnessprofile().then((value) {
                setState(() {});
              });
    var mapresponse = jsonDecode(data);
    if (mapresponse.length != 0) {
      setState(() {
        widget.csc == true
            ? cscvalue = mapresponse
            : festivalprofilevalue = mapresponse;
        image = mapresponse[0]['profile_img'];
        image2 = mapresponse[0][logoimagevalue];
        name.text = mapresponse[0]['name'];
        mobile.text = mapresponse[0]['mobileno'];
        email.text = mapresponse[0]['email'];
        facebook.text = mapresponse[0]['facebook_username'];
        instagram.text = mapresponse[0]['instagram_username'];
        twitter.text = mapresponse[0]['twitter_username'];
        website.text = mapresponse[0]['web_url'];
        website2.text = mapresponse[0]['web_url2'];
        whatsapp.text = mapresponse[0]['whatsapp_num'];
        designation.text = mapresponse[0]['designation'];
        address.text = mapresponse[0]['address'];
        if (csc == true) {
          buisnessname.text = mapresponse[0]['business_name'];
        }
      });
    } else {
      editMode == true;
    }
  }

  getalldata() async {
    SentApi().getcscprofieldata().then((value) {
      setState(() {});
      getprofile();
    });
  }

  getfestivalalldata() async {
    await SentApi().getfestivalprofile().then((value) {
      setState(() {});
      getprofile();
    });
  }

  pickpitchure({List? type}) async {
    if (type!.isEmpty) {
      var res = await FilePicker.platform.pickFiles(
          allowMultiple: true,
          type: FileType.custom,
          allowedExtensions: [
            'jpg',
            'png',
          ]);
      //print(res);
      if (res != null) {
        PlatformFile file = res.files.single;
        int maxSizeInBytes =
            2 * 1024 * 1024; // Set your size limit here (e.g., 10 MB)

        if (file.size > maxSizeInBytes) {
          // File size exceeds the limit
          Fluttertoast.showToast(msg: "Max Image Size 2 MB");
        } else {
          List files = res.paths.map((path) => path).toList();
          CroppedFile? croppedFile = await ImageCropper().cropImage(
            sourcePath: files[0],
            compressFormat: "${files[0]}".split(".").last == "png"
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
                  initAspectRatio: CropAspectRatioPreset.original,
                  lockAspectRatio: false),
            ],
          );
          if (croppedFile != null) {
            setState(() {
              type == path1
                  ? path1 = res.paths
                      .map((path) => File("${croppedFile.path}"))
                      .toList()
                  : path2 = res.paths
                      .map((path) => File("${croppedFile.path}"))
                      .toList();
            });
          }
        }
      }
    } else {
      setState(() {
        type.clear();
      });
    }
  }

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    getprofile();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            key: _scaffoldKey,
            appBar: AppBar(
                backgroundColor: primaryColor,
                title: csc == true
                    ? Text("CSC Center Profile")
                    : festival == true
                        ? Text("Festival Profile")
                        : null),
            body: SingleChildScrollView(
              child: Form(
                key: _formkey,
                autovalidateMode: AutovalidateMode.disabled,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.centerRight,
                      child: SwitchListTile(
                        activeColor: primaryColor,
                        title: const Text(
                          'Edit',
                          style: TextStyle(fontSize: 18),
                        ),
                        onChanged: (val) {
                          toggleEditMode(val);
                        },
                        value: editMode,
                      ),
                    ),
                    // if (!widget.csc)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: Center(
                            child: InkWell(
                              onTap: () {
                                editMode ? pickpitchure(type: path1) : null;
                              },
                              child: path1.isNotEmpty
                                  ? ProfilePhoto(
                                      image: FileImage(path1[0]),
                                      title: 'Profile Photo',
                                      editMode: editMode,
                                    )
                                  : ProfilePhoto(
                                      image: CachedNetworkImageProvider(
                                          "$weburl/$image"),
                                      title: 'Profile Photo',
                                      editMode: editMode,
                                    ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: Center(
                            child: InkWell(
                              onTap: () {
                                editMode ? pickpitchure(type: path2) : null;
                              },
                              child: path2.isNotEmpty
                                  ? ProfilePhoto(
                                      image: FileImage(path2[0]),
                                      title: 'logo',
                                      editMode: editMode,
                                    )
                                  : ProfilePhoto(
                                      image: CachedNetworkImageProvider(
                                          "$weburl/$image2"),
                                      title: 'logo',
                                      editMode: editMode,
                                    ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    // if (widget.csc)
                    //   Padding(
                    //     padding: const EdgeInsets.only(top: 20.0),
                    //     child: Center(
                    //       child: InkWell(
                    //         onTap: () {
                    //           editMode ? pickpitchure() : null;
                    //         },
                    //         child: path1.isNotEmpty
                    //             ? ProfilePhoto(
                    //                 image: Image.file(File(path1[0])),
                    //                 title: 'Profile Photo',
                    //                 editMode: editMode,
                    //               )
                    //             : ProfilePhoto(
                    //                 image: CachedNetworkImageProvider(
                    //                     image == null ? url : "$weburl/$image"),
                    //                 title: 'Profile Photo',
                    //                 editMode: editMode,
                    //               ),
                    //       ),
                    //     ),
                    //   ),

                    const Center(
                      child: Text(
                        'Image size below 2MB',
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                    h(20),
                    CustomTextField(
                      validate: (value) {
                        if (value.isEmpty) {
                          return widget.csc
                              ? 'Enter your full name'
                              : 'Enter your Name';
                        }
                        final RegExp nameRegExp = RegExp('[0-9.,]');
                        if (nameRegExp.hasMatch(value)) {
                          return "Please enter correctname";
                        }
                      },
                      height: 60,
                      controller: name,
                      labelText: widget.csc ? 'Enter your full name' : 'Name',
                      enabled: editMode,
                    ),
                    h(6),
                    if (widget.csc == true) ...[
                      CustomTextField(
                        validate: (value) {
                          if (value.isEmpty) {
                            return 'Enter your Buisness name';
                          }
                          final RegExp nameRegExp = RegExp('[0-9.,]');
                          if (nameRegExp.hasMatch(value)) {
                            return "Please enter correctname";
                          }
                        },
                        height: 60,
                        controller: buisnessname,
                        labelText: 'Buisness Name',
                        enabled: editMode,
                      ),
                    ],

                    CustomTextField(
                      validate: (value) {
                        if (value.isEmpty) {
                          return "Enter Your address";
                        }
                      },
                      height: 60,
                      controller: address,
                      labelText: 'Address',
                      enabled: editMode,
                    ),

                    CustomTextField(
                      height: 60,
                      controller: designation,
                      labelText:
                          !widget.csc ? 'Enter your designation' : 'Tagline',
                      enabled: editMode,
                    ),

                    CustomTextField(
                      validate: (value) {
                        if (value.isNotEmpty) {
                          String pattern =
                              r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                          RegExp regex = RegExp(pattern);
                          if (!regex.hasMatch(value!)) {
                            return 'Enter Valid Email';
                          } else {
                            return null;
                          }
                        }
                      },
                      height: 60,
                      controller: email,
                      labelText: 'Enter your mail id',
                      enabled: editMode,
                      prefixIcon:
                          widget.csc ? null : const Icon(Icons.email_outlined),
                    ),

                    CustomTextField(
                      enabled: editMode,
                      height: 60,
                      controller: facebook,
                      labelText: 'Facebook username',
                      prefixIcon: const Icon(
                        FontAwesomeIcons.facebook,
                        color: Colors.blue,
                        size: 18,
                      ),
                    ),

                    CustomTextField(
                      enabled: editMode,
                      height: 60,
                      controller: instagram,
                      labelText: 'Instagram username',
                      prefixIcon: const Icon(
                        FontAwesomeIcons.instagram,
                        color: Colors.redAccent,
                        size: 18,
                      ),
                    ),

                    CustomTextField(
                      enabled: editMode,
                      height: 60,
                      controller: twitter,
                      labelText: 'Twitter username',
                      prefixIcon: const Icon(
                        FontAwesomeIcons.twitter,
                        color: Colors.lightBlue,
                        size: 18,
                      ),
                    ),
                    CustomTextField(
                      validate: (value) {
                        if (value.isEmpty) {
                          return "Enter Your mobile number";
                        }
                        if (value.length != 10) {
                          return "please enter correct mobile number";
                        }
                      },
                      enabled: editMode,
                      height: 60,
                      controller: mobile,
                      labelText: 'Mobile number',
                      maxlength: 10,
                      prefixIcon: const Icon(
                        Icons.phone_android,
                        size: 18,
                      ),
                    ),
                    CustomTextField(
                      validate: (value) {
                        if (value.isEmpty) {
                          return "Enter Your Whatsapp number";
                        }
                        if (value.length != 10) {
                          return "please enter correct whatsapp number";
                        }
                      },
                      enabled: editMode,
                      controller: whatsapp,
                      maxlength: 10,
                      labelText: 'Whatsapp Number',
                      prefixIcon: CachedNetworkImage(
                        imageUrl:
                            "https://img.icons8.com/color/512/whatsapp--v1.png",
                        width: 10,
                      ),
                    ),
                    CustomTextField(
                      validate: (value) {
                        if (value.isNotEmpty) {
                          final urlRegex = RegExp(
                              r"^((http:\/\/www\.|https:\/\/www\.|http:\/\/|https:\/\/)?[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?)$");

                          if (!urlRegex.hasMatch(value)) {
                            return 'Please enter a valid URL';
                          }
                        }
                      },
                      enabled: editMode,
                      height: 60,
                      controller: website,
                      labelText: 'Enter your csc web url',
                      prefixIcon: const Icon(
                        Icons.language_outlined,
                        size: 18,
                      ),
                    ),

                    CustomTextField(
                      validate: (value) {
                        if (value.isNotEmpty) {
                          final urlRegex = RegExp(
                              r"^((http:\/\/www\.|https:\/\/www\.|http:\/\/|https:\/\/)?[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?)$");

                          if (!urlRegex.hasMatch(value)) {
                            return 'Please enter a valid URL';
                          }
                        }
                      },
                      enabled: editMode,
                      height: 60,
                      controller: website2,
                      labelText: 'Enter your job web url',
                      prefixIcon: const Icon(
                        Icons.language_outlined,
                        size: 18,
                      ),
                    ),
                    // if (festival == true) ...[
                    //
                    //   CustomTextField(
                    //     enabled: editMode,
                    //     height: 60,
                    //     controller: address,
                    //     labelText: 'Enter your Address',
                    //     prefixIcon: const Icon(
                    //       Icons.email_outlined,
                    //       size: 18,
                    //     ),
                    //   ),
                    // ],
                    h(20),
                    editMode
                        ? progress == true
                            ? Center(
                                child: CircularProgressIndicator(),
                              )
                            : Center(
                                child: SizedBox(
                                  width: AppLayout.getScreenWidth() / 2,
                                  height: 60,
                                  child: Button(
                                    radius: 15,
                                    text: 'Submit',
                                    style: const TextStyle(fontSize: 18),
                                    primaryColor: primaryColor,
                                    onPressed: () {
                                      if (_formkey.currentState!.validate()) {
                                        submitprofile();
                                      } else {
                                        Fluttertoast.showToast(
                                            msg:
                                                "Please check Entered Details");
                                      }
                                    },
                                  ),
                                ),
                              )
                        : SizedBox.shrink(),
                    h(10),
                  ],
                ),
              ),
            )));
  }

  submitprofile() async {
    var message;
    var profilename =
        path1.isNotEmpty ? "${path1[0].path}".split("/").last : null;
    var logoname = path2.isNotEmpty ? "${path2[0].path}".split("/").last : null;
    var updatelink = csc == true
        ? "csc_profile_add"
        : festival == true
            ? "festival_profile_add"
            : "business_profile_add";
    var logoimagevalue = csc == true
        ? "csc_logo"
        : festival == true
            ? "festival_logo"
            : "business_img";
    setState(() {
      progress = true;
    });
    try {
      //print(buisnessname.text);
      var gettoken = await Authcredential().getToken();
      final request = http.MultipartRequest(
          "POST", Uri.parse("$weburl/api/api/$updatelink"));
      request.headers.addAll({
        'token': "$gettoken",
      });
      request.files.addAll({
        if (path1.isNotEmpty)
          http.MultipartFile.fromBytes(
              "profile_img", path1[0].readAsBytesSync(),
              filename: "$profilename"),
        if (path2.isNotEmpty)
          http.MultipartFile.fromBytes(
              "$logoimagevalue", path2[0].readAsBytesSync(),
              filename: "$logoname")
      });
      request.fields.addAll({
        "name": name.text,
        "mobile": mobile.text,
        "email": email.text,
        "share_code": "13",
        "designation": designation.text,
        "whatsapp_num": whatsapp.text,
        "twitter_username": twitter.text,
        "facebook_username": facebook.text,
        "web_url": website.text,
        "web_url2": website2.text,
        "instagram_username": instagram.text,
        "address": address.text,
        if (widget.csc == true) "business_name": buisnessname.text
      });

      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Waiting")));
      var resp = await request.send();
      http.Response response = await http.Response.fromStream(resp);
      //print(response.body);
      var mapresponse = jsonDecode(response.body);
      message = "${mapresponse['response']['response_message']}";
      widget.csc == true ? await getalldata() : await getfestivalalldata();
      //print(message);

      setState(() {
        editMode = false;
        progress = false;
      });
      durationdialog(message, true, false);
      path1.clear();
      path2.clear();
    } catch (e) {
      //print(message);
      //print(e);
      durationdialog(message, false, true);
      setState(() {
        progress = false;
      });
    }
  }

  durationdialog(var message, bool sucess, bool failur) {
    return showDialog(
        context: context,
        builder: (context) {
          Future.delayed(Duration(seconds: 6), () {
            backscreen(context);
          });
          return ConfirmationDialog(
            title: message,
            sucess: sucess,
            failure: failur,
          );
        });
  }
}
