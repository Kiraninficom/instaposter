// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:convert';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:click/helpers/layout.dart';
import 'package:click/pages/authcredential.dart';
import 'package:click/pages/drawer/profile/photos.dart';
import 'package:click/pages/getapi.dart';
import 'package:click/utils/constants.dart';
import 'package:click/utils/navigation.dart';
import 'package:click/utils/styles.dart';
import 'package:click/widgets/button.dart';
import 'package:click/widgets/confirmation.dart';
import 'package:click/widgets/textfield.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:image_cropper/image_cropper.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({Key? key}) : super(key: key);

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  bool editMode = false;
  bool progress = false;
  TextEditingController name = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController referCode = TextEditingController();
  TextEditingController regNo = TextEditingController();
  TextEditingController email = TextEditingController();

  toggleEditMode(bool val) {
    setState(() {
      editMode = val;
    });
  }

  List path1 = [];
  List path2 = [];

  Future getdata() async {
    var response = await SentApi().getuserdata();
    var mapreduce = response;
    if (kDebugMode) {
      //print(mapreduce);
    }

    setState(() {
      userdata = mapreduce;
      name.text = '${userdata["name"]}';
      email.text = '${userdata["email"]}';
      address.text = '${userdata["address"]}';
      referCode.text = '${userdata["referal"]}';
      regNo.text = '${userdata["mobileno"]}';
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
          // File is within the size limit, you can proceed with the file
          print('Selected file: ${file.name}, size: ${file.size} bytes');
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

  @override
  void initState() {
    super.initState();
    getdata();
    if (userdata != null) {
      setState(() {
        name.text = '${userdata["name"]}';
        email.text = '${userdata["email"]}';
        userdata["address"] == null
            ? null
            : address.text = '${userdata["address"]}';
        referCode.text = '${userdata["referal"]}';
        regNo.text = '${userdata["mobileno"]}';
      });
    }
  }

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (editMode) {
          toggleEditMode(false);
          return false;
        }
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: primaryColor,
          title: Text(editMode ? 'Edit Profile' : 'My Profile'),
        ),
        body: userdata == null
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                child: Form(
                  key: _formkey,
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
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Row(
                          children: [
                            InkWell(
                              onTap: () async {
                                if (editMode == true) {
                                  pickpitchure(type: path1);
                                }
                              },
                              child: path1.isNotEmpty
                                  ? ProfilePhoto(
                                      image: FileImage(path1[0]),
                                      title: 'Profile Photo',
                                      editMode: editMode,
                                    )
                                  : ProfilePhoto(
                                      image: CachedNetworkImageProvider(
                                          "$weburl/${userdata["profile_img"]}"),
                                      title: 'Profile Photo',
                                      editMode: editMode,
                                    ),
                            ),
                            const Spacer(),
                            InkWell(
                              onTap: () async {
                                if (editMode == true) {
                                  pickpitchure(type: path2);
                                }
                              },
                              child: path2.isNotEmpty
                                  ? ProfilePhoto(
                                      image: FileImage(path2[0]),
                                      title: 'Profile Photo',
                                      editMode: editMode,
                                    )
                                  : ProfilePhoto(
                                      image: CachedNetworkImageProvider(
                                          "$weburl/${userdata["users_logo"]}"),
                                      title: 'Logo ',
                                      editMode: editMode,
                                    ),
                            )
                          ],
                        ),
                      ),
                      h(20),
                      CustomTextField(
                        validate: (value) {
                          final RegExp nameRegExp = RegExp('[0-9.,]');
                          if (nameRegExp.hasMatch(value)) {
                            return "Please enter correctname";
                          }
                        },
                        controller: name,
                        labelText: 'Name',
                        enabled: editMode,
                      ),
                      h(6),
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
                        controller: email,
                        labelText: 'Email',
                        enabled: editMode,
                      ),
                      h(6),
                      CustomTextField(
                        validate: (value) {
                          if (value.isEmpty) {
                            return "Please Enter Your Address";
                          }
                        },
                        controller: address,
                        labelText: 'Address',
                        enabled: editMode,
                      ),
                      h(6),
                      CustomTextField(
                        fillColor: greyshade300,
                        controller: regNo,
                        labelText: 'Phone',
                        enabled: false,
                      ),
                      CustomTextField(
                        fillColor: greyshade300,
                        enabled: false,
                        controller: referCode,
                        labelText: 'Refer Code',
                      ),
                      h(30),
                      if (editMode)
                        progress == true
                            ? Center(
                                child: CircularProgressIndicator(),
                              )
                            : Center(
                                child: SizedBox(
                                  width: AppLayout.getScreenWidth() / 2,
                                  height: 50,
                                  child: Button(
                                    radius: 15,
                                    text: 'Update',
                                    style: const TextStyle(fontSize: 18),
                                    primaryColor: primaryColor,
                                    onPressed: () async {
                                      if (_formkey.currentState!.validate()) {
                                        updateprofile();
                                      } else {
                                        Fluttertoast.showToast(
                                            msg:
                                                "Please check Entered Details");
                                      }
                                    },
                                  ),
                                ),
                              ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }

  updateprofile() async {
    var message;
    setState(() {
      progress = true;
    });
    try {
      var profilename =
          path1.isNotEmpty ? "${path1[0].path}".split("/").last : null;
      var logoname =
          path2.isNotEmpty ? "${path2[0].path}".split("/").last : null;
      final request = http.MultipartRequest(
          "POST", Uri.parse("${baseurl}update_user_details"));
      request.headers.addAll({
        'token': token,
      });
      request.files.addAll({
        if (path1.isNotEmpty)
          http.MultipartFile.fromBytes(
              "profile_img", path1[0].readAsBytesSync(),
              filename: "$profilename"),
        if (path2.isNotEmpty)
          http.MultipartFile.fromBytes("users_logo", path2[0].readAsBytesSync(),
              filename: "$logoname")
      });
      request.fields.addAll({
        "name": name.text,
        "mobileno": regNo.text,
        "address": address.text,
        "email": email.text,
      });
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Waiting")));
      var resp = await request.send();
      http.Response response = await http.Response.fromStream(resp);
      var mapresponse = jsonDecode(response.body);
      message = "${mapresponse['response']['response_message']}";
      if (kDebugMode) {
        //print(response.body);
      }
      var mapres = jsonDecode(response.body);
      Fluttertoast.showToast(msg: "${mapres['response']['response_message']}");

      setState(() {
        editMode = false;
        progress = false;
      });
      durationdialog(message, true, false);
      getdata();
    } catch (e) {
      if (kDebugMode) {
        //print(e);
      }
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
