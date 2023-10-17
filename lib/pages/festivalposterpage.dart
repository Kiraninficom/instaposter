// // ignore_for_file: prefer_typing_uninitialized_variables, use_build_context_synchronously

// import 'dart:convert';
// import 'dart:io';
// import 'dart:ui';
// import 'package:auto_size_text/auto_size_text.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter_colorpicker/flutter_colorpicker.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:http/http.dart' as http;
// import 'package:click/pages/authcredential.dart';
// import 'package:click/utils/constants.dart';
// import 'package:click/utils/styles.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:screenshot/screenshot.dart';
// import 'package:pdf/widgets.dart' as pw;

// import 'package:url_launcher/url_launcher.dart';

// // ignore: must_be_immutable
// class Festivalposterpage extends StatefulWidget {
//   var id;
//   var getimage;
//   var profilevalue;
//   Festivalposterpage({Key? key, this.getimage, this.profilevalue, this.id})
//       : super(key: key);

//   @override
//   State<Festivalposterpage> createState() => _FestivalposterpageState();
// }

// class _FestivalposterpageState extends State<Festivalposterpage> {
//   var watermarktext = [];
//   DrawableRoot? svgRoot;
//   bool editingvalue = false;
//   bool otherinfovalue = false;
//   bool watermark = true;
//   bool framesetting = false;
//   Color pickedcolor = blackcolor;
//   var scrollcontroller = ScrollController();
//   var titlefontvalue;
//   var otherfontvalue;
//   var titlesizevalue;
//   var othersizevalue;
//   Color titlecolorvalue = redcolor;
//   Color othercolorvalue = bluecolor;
//   var fontlist = [
//     // {
//     //   "fontname": "example",
//     //   "font": "SHREE-DEV7-4909",
//     // },
//     {
//       "fontname": "sample",
//       "font": "SHREE-DEV7-1089",
//     },
//     {
//       "fontname": "sample",
//       "font": "SHREE-DEV7-2317",
//     },
//     {
//       "fontname": "sample",
//       "font": "SHREE-DEV7-3687",
//     },
//     {
//       "fontname": "sample",
//       "font": "SHREE-DEV7-2336",
//     },
//     {
//       "fontname": "sample",
//       "font": "SHREE-DEV7-3690",
//     }
//   ];

//   int _frameno = 1;
//   final ScreenshotController controller = ScreenshotController();
//   var videodata;
//   void num(index, str) {
//     for (int i = 0; i <= index; i++) {
//       var space;
//       space = "  " * i * str.length;
//       space = space + "Addon\n";
//       setState(() {
//         watermarktext.add(space);
//       });
//     }
//   }

//   void predifiendtextvalue() {
//     setState(() {
//       if (window.physicalSize.width <= 900.0) {
//         titlesizevalue = 12;
//         othersizevalue = 12;
//       } else if (window.physicalSize.width <= 1100.0) {
//         titlesizevalue = 15;
//         othersizevalue = 15;
//       } else if (window.physicalSize.width <= 1350.0) {
//         titlesizevalue = 18;
//         othersizevalue = 18;
//       } else if (window.physicalSize.width > 1350) {
//         titlesizevalue = 22;
//         othersizevalue = 22;
//       }
//     });
//   }

//   getvideo() async {
//     var gettoken = await Authcredential().getToken();

//     http.Response response = await http.post(
//         Uri.parse('$weburl/api/api/cscsubservicesvideos_list_by_service'),
//         headers: {'token': '$gettoken'},
//         body: {'cscsubservice_id': widget.id});
//     if (response.statusCode == 200) {
//       var mapreduce = json.decode(response.body);
//       setState(() {
//         videodata = mapreduce;
//       });
//     }
//   }

//   @override
//   void dispose() {
//     scrollcontroller.dispose();
//     super.dispose();
//   }

//   @override
//   void initState() {
//     super.initState();
//     num(8, "Addon");
//     getvideo();
//     predifiendtextvalue();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//         child: Scaffold(
//       body: ListView(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: buildImage(),
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: [
//               Column(
//                 children: [
//                   Transform.scale(
//                     scale: 0.5,
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
//                     scale: 0.5,
//                     child: CupertinoSwitch(
//                       trackColor: blackcolor,
//                       value: otherinfovalue,
//                       onChanged: (value) {
//                         setState(() {
//                           otherinfovalue = value;
//                         });
//                       },
//                     ),
//                   ),
//                   const Text('Other info')
//                 ],
//               ),
//               Column(
//                 children: [
//                   Transform.scale(
//                     scale: 0.5,
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
//                   const Text('Frame Setting')
//                 ],
//               ),
//             ],
//           ),
//           editingvalue == false
//               ? Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: SizedBox(
//                     width: MediaQuery.of(context).size.width,
//                     child: IntrinsicHeight(
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Column(
//                             children: [
//                               const Text(
//                                 'Design',
//                                 style: TextStyle(
//                                     fontWeight: FontWeight.bold, fontSize: 25),
//                               ),
//                               SizedBox(
//                                 width: MediaQuery.of(context).size.width * .45,
//                                 height:
//                                     MediaQuery.of(context).size.height * .15,
//                                 child: GridView.count(
//                                     crossAxisCount: 4,
//                                     children: List.generate(12, (index) {
//                                       return Padding(
//                                         padding: const EdgeInsets.all(8.0),
//                                         child: InkWell(
//                                           onTap: () {
//                                             setState(() {
//                                               // svgRoot = newsvg;
//                                               _frameno = index + 1;
//                                             });
//                                           },
//                                           child: CircleAvatar(
//                                             radius: 5,
//                                             backgroundColor:
//                                                 index + 1 == _frameno
//                                                     ? Colors.blue
//                                                     : primaryColor,
//                                             child: Text(
//                                               '${index + 1}',
//                                               style: TextStyle(
//                                                 color: index + 1 == _frameno
//                                                     ? Colors.black
//                                                     : Colors.white,
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                       );
//                                     })),
//                               ),
//                               SizedBox(
//                                 width: MediaQuery.of(context).size.width * .45,
//                                 child: Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     Container(
//                                       decoration: BoxDecoration(
//                                           color: primaryColor,
//                                           border: Border.all(color: blackcolor),
//                                           borderRadius:
//                                               BorderRadius.circular(15)),
//                                       child: Padding(
//                                         padding: const EdgeInsets.all(8.0),
//                                         child: Text("Share"),
//                                       ),
//                                     ),
//                                     Container(
//                                       decoration: BoxDecoration(
//                                           color: primaryColor,
//                                           border: Border.all(color: blackcolor),
//                                           borderRadius:
//                                               BorderRadius.circular(15)),
//                                       child: Padding(
//                                         padding: const EdgeInsets.all(8.0),
//                                         child: Text("Download"),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ],
//                           ),
//                           VerticalDivider(
//                             color: blackcolor,
//                             thickness: 2,
//                             indent: 5,
//                             endIndent: 5,
//                           ),
//                           Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Container(
//                               width: MediaQuery.of(context).size.width * .4,
//                               padding: const EdgeInsets.all(15),
//                               decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(15),
//                                   border:
//                                       Border.all(color: blackcolor, width: 1)),
//                               child: Column(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   Text(
//                                     'Click here to see',
//                                     textAlign: TextAlign.center,
//                                     style: TextStyle(color: blackcolor),
//                                   ),
//                                   Text(
//                                     'Premium \nTemplate',
//                                     textAlign: TextAlign.center,
//                                     style: TextStyle(
//                                         color: primaryColor,
//                                         fontSize: 20,
//                                         fontWeight: FontWeight.bold),
//                                   )
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 )
//               : Column(
//                   children: [
//                     IntrinsicHeight(
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceAround,
//                         children: [
//                           Column(
//                             children: [
//                               const Text(
//                                 'Design',
//                                 style: TextStyle(
//                                     fontWeight: FontWeight.bold, fontSize: 25),
//                               ),
//                               SizedBox(
//                                 width: MediaQuery.of(context).size.width * .45,
//                                 height:
//                                     MediaQuery.of(context).size.height * .15,
//                                 child: GridView.builder(
//                                   shrinkWrap: true,
//                                   physics: const ScrollPhysics(),
//                                   gridDelegate:
//                                       const SliverGridDelegateWithFixedCrossAxisCount(
//                                     crossAxisCount: 4,
//                                   ),
//                                   itemCount: 12,
//                                   itemBuilder:
//                                       (BuildContext context, int index) {
//                                     return Padding(
//                                       padding: const EdgeInsets.all(8.0),
//                                       child: InkWell(
//                                         onTap: () {
//                                           setState(() {
//                                             // svgRoot = newsvg;
//                                             _frameno = index + 1;
//                                           });
//                                         },
//                                         child: CircleAvatar(
//                                           backgroundColor: index + 1 == _frameno
//                                               ? Colors.blue
//                                               : null,
//                                           child: Text(
//                                             '${index + 1}',
//                                             style: TextStyle(
//                                               color: index + 1 == _frameno
//                                                   ? Colors.black
//                                                   : Colors.white,
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                     );
//                                   },
//                                 ),
//                               ),
//                               SizedBox(
//                                 width: MediaQuery.of(context).size.width * .45,
//                                 child: Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     Container(
//                                       decoration: BoxDecoration(
//                                           color: primaryColor,
//                                           border: Border.all(color: blackcolor),
//                                           borderRadius:
//                                               BorderRadius.circular(15)),
//                                       child: Padding(
//                                         padding: const EdgeInsets.all(8.0),
//                                         child: Text("Share"),
//                                       ),
//                                     ),
//                                     Container(
//                                       decoration: BoxDecoration(
//                                           color: primaryColor,
//                                           border: Border.all(color: blackcolor),
//                                           borderRadius:
//                                               BorderRadius.circular(15)),
//                                       child: Padding(
//                                         padding: const EdgeInsets.all(8.0),
//                                         child: Text("Download"),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               Padding(
//                                 padding: const EdgeInsets.all(8.0),
//                                 child: Container(
//                                   padding: const EdgeInsets.all(15),
//                                   decoration: BoxDecoration(
//                                       borderRadius: BorderRadius.circular(15),
//                                       border: Border.all(
//                                           color: blackcolor, width: 1)),
//                                   child: Column(
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     children: [
//                                       Text(
//                                         'Click here to see',
//                                         style: TextStyle(color: blackcolor),
//                                       ),
//                                       Text(
//                                         'Premium \nTemplate',
//                                         style: TextStyle(
//                                             color: primaryColor,
//                                             fontSize: 25,
//                                             fontWeight: FontWeight.bold),
//                                       )
//                                     ],
//                                   ),
//                                 ),
//                               )
//                             ],
//                           ),
//                           VerticalDivider(
//                             color: blackcolor,
//                             thickness: 2,
//                             indent: 20,
//                             endIndent: 20,
//                           ),
//                           Column(
//                             mainAxisAlignment: MainAxisAlignment.spaceAround,
//                             children: [
//                               Column(
//                                 children: [
//                                   Transform.scale(
//                                     scale: 0.7,
//                                     child: CupertinoSwitch(
//                                       trackColor: redcolor,
//                                       activeColor: bluecolor,
//                                       value: framesetting,
//                                       onChanged: (value) {
//                                         setState(() {
//                                           framesetting = value;
//                                         });
//                                       },
//                                     ),
//                                   ),
//                                   Text(framesetting == false
//                                       ? 'Tile Setting'
//                                       : 'other setting')
//                                 ],
//                               ),
//                               Column(
//                                 children: [
//                                   Padding(
//                                     padding: const EdgeInsets.symmetric(
//                                         vertical: 8.0),
//                                     child: Column(
//                                       children: [
//                                         const Text(
//                                           'Font',
//                                           style: TextStyle(
//                                               fontWeight: FontWeight.bold,
//                                               fontSize: 30),
//                                         ),
//                                         PopupMenuButton(
//                                           child: Padding(
//                                             padding: const EdgeInsets.all(5.0),
//                                             child: Container(
//                                               padding: const EdgeInsets.all(5),
//                                               decoration: BoxDecoration(
//                                                   borderRadius:
//                                                       BorderRadius.circular(15),
//                                                   border: Border.all(
//                                                       color: blackcolor,
//                                                       width: 1)),
//                                               child: Row(
//                                                 children: [
//                                                   framesetting == false
//                                                       ? titlefontvalue != null
//                                                           ? Text(
//                                                               titlefontvalue[
//                                                                   'fontname'],
//                                                               style: TextStyle(
//                                                                   fontFamily:
//                                                                       titlefontvalue[
//                                                                           'font']))
//                                                           : const Text(
//                                                               "select font")
//                                                       : otherfontvalue != null
//                                                           ? Text(
//                                                               otherfontvalue[
//                                                                   'fontname'],
//                                                               style: TextStyle(
//                                                                   fontFamily:
//                                                                       otherfontvalue[
//                                                                           'font']))
//                                                           : const Text(
//                                                               "select font"),
//                                                   const Icon(
//                                                       Icons.arrow_drop_down)
//                                                 ],
//                                               ),
//                                             ),
//                                           ),
//                                           itemBuilder: (context) {
//                                             return List.generate(
//                                                 fontlist.length,
//                                                 (index) => PopupMenuItem(
//                                                     onTap: () {
//                                                       setState(() {
//                                                         framesetting == false
//                                                             ? titlefontvalue =
//                                                                 fontlist[index]
//                                                             : otherfontvalue =
//                                                                 fontlist[index];
//                                                       });
//                                                     },
//                                                     value: framesetting == false
//                                                         ? titlefontvalue
//                                                         : otherfontvalue,
//                                                     child: Text(
//                                                         fontlist[index]
//                                                             ["fontname"]!,
//                                                         style: TextStyle(
//                                                             fontFamily:
//                                                                 fontlist[index][
//                                                                     'font']))));
//                                           },
//                                         )
//                                       ],
//                                     ),
//                                   ),
//                                   Padding(
//                                     padding: const EdgeInsets.all(8.0),
//                                     child: Column(
//                                       children: [
//                                         const Text(
//                                           'Text Size',
//                                           style: TextStyle(
//                                               fontWeight: FontWeight.bold,
//                                               fontSize: 25),
//                                         ),
//                                         PopupMenuButton(
//                                           child: Padding(
//                                             padding: const EdgeInsets.all(5.0),
//                                             child: Container(
//                                               padding: const EdgeInsets.all(5),
//                                               decoration: BoxDecoration(
//                                                   borderRadius:
//                                                       BorderRadius.circular(15),
//                                                   border: Border.all(
//                                                       color: blackcolor,
//                                                       width: 1)),
//                                               child: Row(
//                                                 children: [
//                                                   framesetting == false
//                                                       ? Text(titlesizevalue !=
//                                                               null
//                                                           ? "$titlesizevalue"
//                                                           : "Select size")
//                                                       : Text(othersizevalue !=
//                                                               null
//                                                           ? "$othersizevalue"
//                                                           : "Select size"),
//                                                   const Icon(
//                                                       Icons.arrow_drop_down)
//                                                 ],
//                                               ),
//                                             ),
//                                           ),
//                                           itemBuilder: (context) {
//                                             return List.generate(
//                                                 25,
//                                                 (index) => PopupMenuItem(
//                                                     onTap: () {
//                                                       setState(() {
//                                                         framesetting == false
//                                                             ? titlesizevalue =
//                                                                 index + 1
//                                                             : othersizevalue =
//                                                                 index + 1;
//                                                       });
//                                                     },
//                                                     value: framesetting == false
//                                                         ? titlesizevalue
//                                                         : othersizevalue,
//                                                     child:
//                                                         Text("${index + 1}")));
//                                           },
//                                         )
//                                       ],
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ],
//                           )
//                         ],
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.all(10.0),
//                       child: Column(
//                         children: [
//                           Text(
//                             'Color Picker (${framesetting == false ? "Title" : "Other"})',
//                             style: const TextStyle(
//                                 fontWeight: FontWeight.bold, fontSize: 25),
//                           ),
//                           SizedBox(
//                             height: MediaQuery.of(context).size.height * .1,
//                             width: MediaQuery.of(context).size.width,
//                             child: BlockPicker(
//                               pickerColor: pickedcolor, //default color
//                               onColorChanged: (Color color) {
//                                 setState(() {
//                                   framesetting == false
//                                       ? titlecolorvalue = color
//                                       : othercolorvalue = color;
//                                 });
//                               },
//                               layoutBuilder: (context, colors, child) {
//                                 return GridView.count(
//                                   crossAxisCount: 10,
//                                   shrinkWrap: true,
//                                   children: [
//                                     for (Color color in colors) child(color)
//                                   ],
//                                 );
//                               },
//                             ),
//                           ),
//                         ],
//                       ),
//                     )
//                   ],
//                 ),
//           otherinfovalue == true
//               ? Container(
//                   width: MediaQuery.of(context).size.width,
//                   color: appBarColor,
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       // editingvalue == true
//                       //     ? Padding(
//                       //         padding: const EdgeInsets.all(8.0),
//                       //         child: InkWell(
//                       //             onTap: () {
//                       //               showDialog(
//                       //                 context: context,
//                       //                 builder: (context) {
//                       //                   return selectcolor();
//                       //                 },
//                       //               );
//                       //             },
//                       //             child: Container(
//                       //                 height: MediaQuery.of(context).size.height / 20,
//                       //                 width: MediaQuery.of(context).size.width / 3.5,
//                       //                 decoration: BoxDecoration(
//                       //                     color: whitecolor,
//                       //                     borderRadius: BorderRadius.circular(10)),
//                       //                 child: Center(
//                       //                   child: Text(
//                       //                     'select color',
//                       //                     style: TextStyle(
//                       //                         color: pickedcolor,
//                       //                         fontWeight: FontWeight.bold),
//                       //                   ),
//                       //                 ))),
//                       //       )
//                       //     : const SizedBox.shrink(),

//                       Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceAround,
//                           children: [
//                             InkWell(
//                               onTap: () async {
//                                 if (videodata == null) {
//                                   Fluttertoast.showToast(msg: 'No video Found');
//                                 }
//                                 final url = Uri.parse(videodata['data']
//                                     ['cscsubservicesvideos'][0]['video_link']);
//                                 await launchUrl(url,
//                                     mode: LaunchMode.externalApplication);
//                               },
//                               child: Container(
//                                 padding: const EdgeInsets.all(10),
//                                 decoration: BoxDecoration(
//                                     color: whitecolor,
//                                     borderRadius: BorderRadius.circular(10)),
//                                 child: Center(
//                                     child: Text(
//                                   'See Video',
//                                   style: TextStyle(color: blackcolor),
//                                 )),
//                               ),
//                             ),
//                             Container(
//                               padding: const EdgeInsets.all(10),
//                               decoration: BoxDecoration(
//                                   color: whitecolor,
//                                   borderRadius: BorderRadius.circular(10)),
//                               child: Center(
//                                   child: Text(
//                                 'Web link',
//                                 style: TextStyle(color: blackcolor),
//                               )),
//                             ),
//                             InkWell(
//                               onTap: () async {
//                                 final Uint8List image = await controller
//                                     .captureFromWidget(buildImage(),
//                                         pixelRatio: 10.0, context: context);
//                                 final pdf = pw.Document();
//                                 pdf.addPage(
//                                     pw.Page(build: (pw.Context context) {
//                                   final im = pw.MemoryImage(image);
//                                   return pw.Center(
//                                     child: pw.Image(im),
//                                   ); // Center
//                                 }));

//                                 Fluttertoast.showToast(msg: "Saving pdf");
//                                 Directory? directory =
//                                     await getExternalStorageDirectory();
//                                 String newPath = "";
//                                 final List<String> paths =
//                                     directory!.path.split("/");
//                                 for (int x = 1; x < paths.length; x++) {
//                                   final String folder = paths[x];
//                                   if (folder != "Android") {
//                                     newPath += "/$folder";
//                                   } else {
//                                     break;
//                                   }
//                                 }
//                                 newPath = "$newPath/clickonadd";
//                                 directory = Directory(newPath);
//                                 var status = await Permission.storage.status;

//                                 if (!status.isGranted) {
//                                   await Permission.storage.request();
//                                 }

//                                 if (!await directory.exists()) {
//                                   directory.create();
//                                 }

//                                 if (await directory.exists()) {
//                                   final File file =
//                                       File("${directory.path}/clickonadd.pdf");

//                                   file.writeAsBytesSync(await pdf.save());
//                                   ScaffoldMessenger.of(context).showSnackBar(
//                                       SnackBar(
//                                           content: Text(
//                                               "${directory.path}${"/clickonadd.pdf"}")));
//                                 }
//                               },
//                               child: Container(
//                                 padding: const EdgeInsets.all(10),
//                                 decoration: BoxDecoration(
//                                     color: whitecolor,
//                                     borderRadius: BorderRadius.circular(10)),
//                                 child: Center(
//                                     child: Text(
//                                   'Download PDF',
//                                   style: TextStyle(color: blackcolor),
//                                 )),
//                               ),
//                             )
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 )
//               : const SizedBox.shrink(),
//         ],
//       ),
//     ));
//   }

//   Widget buildImage() {
//     var height = MediaQuery.of(context).size.width / 7;
//     var width = MediaQuery.of(context).size.width * 0.93;
//     return Wrap(
//       children: [
//         Card(
//           child: Container(
//               decoration: BoxDecoration(
//                 border: Border.all(color: Colors.black, width: 1),
//               ),
//               child: Stack(
//                 alignment: Alignment.topCenter,
//                 children: [
//                   Column(
//                     children: [
//                       _frameno == 6
//                           ? SizedBox(
//                               width: width,
//                               height: height,
//                               child: Stack(children: <Widget>[
//                                 Positioned(
//                                     top: 0,
//                                     left: 0,
//                                     child: Container(
//                                         width: width,
//                                         height: height,
//                                         decoration: const BoxDecoration(
//                                           image: DecorationImage(
//                                               image: AssetImage(
//                                                   'assets/Header-1.png'),
//                                               fit: BoxFit.fitWidth),
//                                         ))),
//                                 Positioned(
//                                     top: height / 6.2,
//                                     left: width / 34.25,
//                                     child: Container(
//                                         width: width / 8.74,
//                                         height: width / 8.74,
//                                         decoration: BoxDecoration(
//                                           image: DecorationImage(
//                                               image: CachedNetworkImageProvider(
//                                                 widget.profilevalue == null
//                                                     ? url
//                                                     : "$weburl/${widget.profilevalue["profile_img"]}",
//                                               ),
//                                               fit: BoxFit.fitWidth),
//                                           borderRadius: const BorderRadius.all(
//                                               Radius.elliptical(47, 47)),
//                                         ))),
//                                 Positioned(
//                                   top: height / 4,
//                                   left: width / 4.8,
//                                   child: AutoSizeText(
//                                     widget.profilevalue != null
//                                         ? 'Mauli computers & multi Service'
//                                         : widget.profilevalue['name'],
//                                     softWrap: true,
//                                     maxLines: 1,
//                                     style: TextStyle(
//                                       color: titlecolorvalue,
//                                       fontSize: titlesizevalue.toDouble(),
//                                       fontFamily: titlefontvalue != null
//                                           ? titlefontvalue['font']
//                                           : null,
//                                     ),
//                                   ),
//                                 ),
//                               ]))
//                           : const SizedBox.shrink(),
//                       Image(image: CachedNetworkImageProvider(widget.getimage)),
//                       getframe(),
//                     ],
//                   ),
//                   watermark == true
//                       ? Opacity(
//                           opacity: 0.5,
//                           child: ListView.builder(
//                             shrinkWrap: true,
//                             itemCount: watermarktext.length,
//                             itemBuilder: (BuildContext context, int index) {
//                               return Text(
//                                 "${watermarktext[index]}",
//                               );
//                             },
//                           ),
//                         )
//                       : const SizedBox.shrink(),
//                 ],
//               )),
//         ),
//       ],
//     );
//   }

//   getframe() {
//     if (_frameno == 1) {
//       var height = MediaQuery.of(context).size.width / 4.37;
//       var width = MediaQuery.of(context).size.width * 0.93;
//       return SizedBox(
//           width: width,
//           height: height,
//           child: Stack(children: <Widget>[
//             Positioned(
//                 top: 0,
//                 left: 0,
//                 child: Container(
//                     width: width,
//                     height: height,
//                     decoration: const BoxDecoration(
//                       image: DecorationImage(
//                           image: AssetImage('assets/Desig Only.png'),
//                           fit: BoxFit.fitWidth),
//                     ))),
//             Positioned(
//                 top: height / 5.2,
//                 left: width / 1.27,
//                 child: Container(
//                     width: width / 6.85,
//                     height: width / 6.85,
//                     decoration: BoxDecoration(
//                       image: DecorationImage(
//                           image: CachedNetworkImageProvider(
//                             widget.profilevalue == null
//                                 ? url
//                                 : "$weburl/${widget.profilevalue["profile_img"]}",
//                           ),
//                           fit: BoxFit.fitWidth),
//                     ))),
//             Positioned(
//                 left: width / 12.84,
//                 child: SizedBox(
//                   height: height - height / 10,
//                   width: width,
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceAround,
//                     children: [
//                       Expanded(
//                         flex: 8,
//                         child: FittedBox(
//                           fit: BoxFit.fill,
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.spaceAround,
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               AutoSizeText(
//                                 widget.profilevalue != null
//                                     ? 'Mauli computers & multi Service'
//                                     : widget.profilevalue['name'],
//                                 softWrap: true,
//                                 maxLines: 1,
//                                 style: TextStyle(
//                                   color: titlecolorvalue,
//                                   fontSize: titlesizevalue.toDouble(),
//                                   fontFamily: titlefontvalue != null
//                                       ? titlefontvalue['font']
//                                       : null,
//                                 ),
//                               ),
//                               Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   Row(
//                                     children: [
//                                       CircleAvatar(
//                                           radius: 8,
//                                           backgroundColor: titlecolorvalue,
//                                           child: Icon(
//                                             Icons.person,
//                                             size: 15,
//                                             color: whitecolor,
//                                           )),
//                                       const SizedBox(width: 5),
//                                       AutoSizeText(
//                                         widget.profilevalue == null
//                                             ? 'Mauli computers & multi Service'
//                                             : widget.profilevalue['name'],
//                                         maxLines: 1,
//                                         style: TextStyle(
//                                           color: titlecolorvalue,
//                                           fontSize: othersizevalue.toDouble(),
//                                           fontFamily: otherfontvalue != null
//                                               ? otherfontvalue['font']
//                                               : null,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                   Row(
//                                     children: [
//                                       CircleAvatar(
//                                           radius: 8,
//                                           backgroundColor: othercolorvalue,
//                                           child: Icon(
//                                             Icons.call,
//                                             size: 15,
//                                             color: whitecolor,
//                                           )),
//                                       const SizedBox(width: 5),
//                                       Text(
//                                         widget.profilevalue == null
//                                             ? '1234567890'
//                                             : widget.profilevalue['mobileno'],
//                                         style: TextStyle(
//                                           color: othercolorvalue,
//                                           fontSize: othersizevalue.toDouble(),
//                                           fontFamily: otherfontvalue != null
//                                               ? otherfontvalue['font']
//                                               : null,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                   const SizedBox()
//                                 ],
//                               ),
//                               FittedBox(
//                                 child: Row(
//                                   children: [
//                                     CircleAvatar(
//                                         radius: 8,
//                                         backgroundColor: othercolorvalue,
//                                         child: Icon(
//                                           Icons.email,
//                                           size: 15,
//                                           color: whitecolor,
//                                         )),
//                                     const SizedBox(width: 5),
//                                     AutoSizeText(
//                                       widget.profilevalue == null
//                                           ? 'Clickonadd@gmail.com'
//                                           : widget.profilevalue['email'],
//                                       maxLines: 1,
//                                       style: TextStyle(
//                                         color: othercolorvalue,
//                                         fontSize: othersizevalue.toDouble(),
//                                         fontFamily: otherfontvalue != null
//                                             ? otherfontvalue['font']
//                                             : null,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               FittedBox(
//                                 child: Row(
//                                   children: [
//                                     CircleAvatar(
//                                         radius: 8,
//                                         backgroundColor: othercolorvalue,
//                                         child: Icon(
//                                           Icons.location_on,
//                                           size: 15,
//                                           color: whitecolor,
//                                         )),
//                                     const SizedBox(width: 5),
//                                     AutoSizeText(
//                                       'Near SBI Bank,Keshav Nagar',
//                                       maxLines: 1,
//                                       style: TextStyle(
//                                         color: othercolorvalue,
//                                         fontSize: othersizevalue.toDouble(),
//                                         fontFamily: otherfontvalue != null
//                                             ? otherfontvalue['font']
//                                             : null,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               FittedBox(
//                                 child: Row(
//                                   children: [
//                                     CircleAvatar(
//                                         radius: 8,
//                                         backgroundColor: othercolorvalue,
//                                         child: Icon(
//                                           Icons.language_sharp,
//                                           size: 15,
//                                           color: whitecolor,
//                                         )),
//                                     const SizedBox(width: 5),
//                                     AutoSizeText(
//                                       'www.clickonadd.com',
//                                       maxLines: 1,
//                                       style: TextStyle(
//                                         color: othercolorvalue,
//                                         fontSize: othersizevalue.toDouble(),
//                                         fontFamily: otherfontvalue != null
//                                             ? otherfontvalue['font']
//                                             : null,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               )
//                             ],
//                           ),
//                         ),
//                       ),
//                       const Expanded(flex: 4, child: SizedBox()),
//                       const Expanded(child: SizedBox(width: 10)),
//                     ],
//                   ),
//                 )),
//           ]));
//     }
//     if (_frameno == 2) {
//       var height = MediaQuery.of(context).size.width / 4.37;
//       var width = MediaQuery.of(context).size.width * 0.93;
//       return SizedBox(
//           width: width,
//           height: height,
//           child: Stack(children: <Widget>[
//             Positioned(
//                 top: 0,
//                 left: 0,
//                 child: Container(
//                     width: width,
//                     height: height,
//                     decoration: const BoxDecoration(
//                       image: DecorationImage(
//                           image: AssetImage('assets/8.Design Only.png'),
//                           fit: BoxFit.fitWidth),
//                     ))),
//             Positioned(
//                 top: height / 5.2,
//                 left: width / 17.86,
//                 child: Container(
//                     width: width / 6.85,
//                     height: width / 6.85,
//                     decoration: BoxDecoration(
//                       image: DecorationImage(
//                           image: CachedNetworkImageProvider(
//                             widget.profilevalue == null
//                                 ? url
//                                 : "$weburl/${widget.profilevalue["profile_img"]}",
//                           ),
//                           fit: BoxFit.fitWidth),
//                     ))),
//             Positioned(
//                 child: SizedBox(
//               height: height - height / 10,
//               width: width,
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceAround,
//                 children: [
//                   const Expanded(flex: 4, child: SizedBox()),
//                   Expanded(
//                     flex: 8,
//                     child: FittedBox(
//                       fit: BoxFit.fill,
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.spaceAround,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           AutoSizeText(
//                             widget.profilevalue != null
//                                 ? 'Mauli computers & multi Service'
//                                 : widget.profilevalue['name'],
//                             softWrap: true,
//                             maxLines: 1,
//                             style: TextStyle(
//                               color: titlecolorvalue,
//                               fontSize: titlesizevalue.toDouble(),
//                               fontFamily: titlefontvalue != null
//                                   ? titlefontvalue['font']
//                                   : null,
//                             ),
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Row(
//                                 children: [
//                                   CircleAvatar(
//                                       radius: 8,
//                                       backgroundColor: titlecolorvalue,
//                                       child: Icon(
//                                         Icons.person,
//                                         size: 15,
//                                         color: whitecolor,
//                                       )),
//                                   const SizedBox(width: 5),
//                                   AutoSizeText(
//                                     widget.profilevalue == null
//                                         ? 'Mauli computers & multi Service'
//                                         : widget.profilevalue['name'],
//                                     maxLines: 1,
//                                     style: TextStyle(
//                                       color: titlecolorvalue,
//                                       fontSize: othersizevalue.toDouble(),
//                                       fontFamily: otherfontvalue != null
//                                           ? otherfontvalue['font']
//                                           : null,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                               Row(
//                                 children: [
//                                   CircleAvatar(
//                                       radius: 8,
//                                       backgroundColor: othercolorvalue,
//                                       child: Icon(
//                                         Icons.call,
//                                         size: 15,
//                                         color: whitecolor,
//                                       )),
//                                   const SizedBox(width: 5),
//                                   Text(
//                                     widget.profilevalue == null
//                                         ? '1234567890'
//                                         : widget.profilevalue['mobileno'],
//                                     style: TextStyle(
//                                       color: othercolorvalue,
//                                       fontSize: othersizevalue.toDouble(),
//                                       fontFamily: otherfontvalue != null
//                                           ? otherfontvalue['font']
//                                           : null,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                               const SizedBox()
//                             ],
//                           ),
//                           FittedBox(
//                             child: Row(
//                               children: [
//                                 CircleAvatar(
//                                     radius: 8,
//                                     backgroundColor: othercolorvalue,
//                                     child: Icon(
//                                       Icons.email,
//                                       size: 15,
//                                       color: whitecolor,
//                                     )),
//                                 const SizedBox(width: 5),
//                                 AutoSizeText(
//                                   widget.profilevalue == null
//                                       ? 'Clickonadd@gmail.com'
//                                       : widget.profilevalue['email'],
//                                   maxLines: 1,
//                                   style: TextStyle(
//                                     color: othercolorvalue,
//                                     fontSize: othersizevalue.toDouble(),
//                                     fontFamily: otherfontvalue != null
//                                         ? otherfontvalue['font']
//                                         : null,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           FittedBox(
//                             child: Row(
//                               children: [
//                                 CircleAvatar(
//                                     radius: 8,
//                                     backgroundColor: othercolorvalue,
//                                     child: Icon(
//                                       Icons.location_on,
//                                       size: 15,
//                                       color: whitecolor,
//                                     )),
//                                 const SizedBox(width: 5),
//                                 AutoSizeText(
//                                   'Near SBI Bank,Keshav Nagar',
//                                   maxLines: 1,
//                                   style: TextStyle(
//                                     color: othercolorvalue,
//                                     fontSize: othersizevalue.toDouble(),
//                                     fontFamily: otherfontvalue != null
//                                         ? otherfontvalue['font']
//                                         : null,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           FittedBox(
//                             child: Row(
//                               children: [
//                                 CircleAvatar(
//                                     radius: 8,
//                                     backgroundColor: othercolorvalue,
//                                     child: Icon(
//                                       Icons.language_sharp,
//                                       size: 15,
//                                       color: whitecolor,
//                                     )),
//                                 const SizedBox(width: 5),
//                                 AutoSizeText(
//                                   'www.clickonadd.com',
//                                   maxLines: 1,
//                                   style: TextStyle(
//                                     color: othercolorvalue,
//                                     fontSize: othersizevalue.toDouble(),
//                                     fontFamily: otherfontvalue != null
//                                         ? otherfontvalue['font']
//                                         : null,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           )
//                         ],
//                       ),
//                     ),
//                   ),
//                   const Expanded(child: SizedBox(width: 10)),
//                 ],
//               ),
//             )),
//           ]));
//     }
//     if (_frameno == 3) {
//       var height = MediaQuery.of(context).size.width / 4.37;
//       var width = MediaQuery.of(context).size.width * 0.93;
//       return SizedBox(
//           width: width,
//           height: height,
//           child: Stack(children: <Widget>[
//             Positioned(
//                 top: 0,
//                 left: 0,
//                 child: Container(
//                     width: width,
//                     height: height,
//                     decoration: const BoxDecoration(
//                       image: DecorationImage(
//                           image: AssetImage('assets/Design Only.png'),
//                           fit: BoxFit.fitWidth),
//                     ))),
//             Positioned(
//                 top: height / 4.5,
//                 left: width / 1.211,
//                 child: Container(
//                     width: width / 7.33,
//                     height: width / 7.33,
//                     decoration: BoxDecoration(
//                       borderRadius: const BorderRadius.only(
//                         topLeft: Radius.circular(7),
//                         topRight: Radius.circular(7),
//                         bottomLeft: Radius.circular(7),
//                         bottomRight: Radius.circular(7),
//                       ),
//                       image: DecorationImage(
//                           image: CachedNetworkImageProvider(
//                             widget.profilevalue == null
//                                 ? url
//                                 : "$weburl/${widget.profilevalue["profile_img"]}",
//                           ),
//                           fit: BoxFit.fitWidth),
//                     ))),
//             Positioned(
//                 top: height / 4.5,
//                 left: width / 29.3,
//                 child: Container(
//                     width: width / 7.33,
//                     height: width / 7.33,
//                     decoration: BoxDecoration(
//                       borderRadius: const BorderRadius.only(
//                         topLeft: Radius.circular(7),
//                         topRight: Radius.circular(7),
//                         bottomLeft: Radius.circular(7),
//                         bottomRight: Radius.circular(7),
//                       ),
//                       image: DecorationImage(
//                           image: CachedNetworkImageProvider(
//                             widget.profilevalue == null
//                                 ? url
//                                 : "$weburl/${widget.profilevalue["profile_img"]}",
//                           ),
//                           fit: BoxFit.fitWidth),
//                     ))),
//             Positioned(
//               child: SizedBox(
//                 height: height,
//                 width: width,
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                   children: [
//                     const Expanded(flex: 3, child: SizedBox()),
//                     Expanded(
//                       flex: 7,
//                       child: Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: FittedBox(
//                           fit: BoxFit.fill,
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.spaceAround,
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               AutoSizeText(
//                                 widget.profilevalue != null
//                                     ? 'Mauli computers & multi Service'
//                                     : widget.profilevalue['name'],
//                                 softWrap: true,
//                                 maxLines: 1,
//                                 style: TextStyle(
//                                   color: titlecolorvalue,
//                                   fontSize: titlesizevalue.toDouble(),
//                                   fontFamily: titlefontvalue != null
//                                       ? titlefontvalue['font']
//                                       : null,
//                                 ),
//                               ),
//                               Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   Row(
//                                     children: [
//                                       CircleAvatar(
//                                           radius: 8,
//                                           backgroundColor: titlecolorvalue,
//                                           child: Icon(
//                                             Icons.person,
//                                             size: 15,
//                                             color: whitecolor,
//                                           )),
//                                       const SizedBox(width: 5),
//                                       AutoSizeText(
//                                         widget.profilevalue == null
//                                             ? 'Mauli computers & multi Service'
//                                             : widget.profilevalue['name'],
//                                         maxLines: 1,
//                                         style: TextStyle(
//                                           color: titlecolorvalue,
//                                           fontSize: othersizevalue.toDouble(),
//                                           fontFamily: otherfontvalue != null
//                                               ? otherfontvalue['font']
//                                               : null,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                   w(5),
//                                   Row(
//                                     children: [
//                                       CircleAvatar(
//                                           radius: 8,
//                                           backgroundColor: othercolorvalue,
//                                           child: Icon(
//                                             Icons.call,
//                                             size: 15,
//                                             color: whitecolor,
//                                           )),
//                                       const SizedBox(width: 5),
//                                       Text(
//                                         widget.profilevalue == null
//                                             ? '1234567890'
//                                             : widget.profilevalue['mobileno'],
//                                         style: TextStyle(
//                                           color: othercolorvalue,
//                                           fontSize: othersizevalue.toDouble(),
//                                           fontFamily: otherfontvalue != null
//                                               ? otherfontvalue['font']
//                                               : null,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ],
//                               ),
//                               FittedBox(
//                                 child: Row(
//                                   children: [
//                                     CircleAvatar(
//                                         radius: 8,
//                                         backgroundColor: othercolorvalue,
//                                         child: Icon(
//                                           Icons.email,
//                                           size: 15,
//                                           color: whitecolor,
//                                         )),
//                                     const SizedBox(width: 5),
//                                     AutoSizeText(
//                                       widget.profilevalue == null
//                                           ? 'Clickonadd@gmail.com'
//                                           : widget.profilevalue['email'],
//                                       maxLines: 1,
//                                       style: TextStyle(
//                                         color: othercolorvalue,
//                                         fontSize: othersizevalue.toDouble(),
//                                         fontFamily: otherfontvalue != null
//                                             ? otherfontvalue['font']
//                                             : null,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               FittedBox(
//                                 child: Row(
//                                   children: [
//                                     CircleAvatar(
//                                         radius: 8,
//                                         backgroundColor: othercolorvalue,
//                                         child: Icon(
//                                           Icons.location_on,
//                                           size: 15,
//                                           color: whitecolor,
//                                         )),
//                                     const SizedBox(width: 5),
//                                     AutoSizeText(
//                                       'Near SBI Bank,Keshav Nagar',
//                                       maxLines: 1,
//                                       style: TextStyle(
//                                         color: othercolorvalue,
//                                         fontSize: othersizevalue.toDouble(),
//                                         fontFamily: otherfontvalue != null
//                                             ? otherfontvalue['font']
//                                             : null,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               FittedBox(
//                                 child: Row(
//                                   children: [
//                                     CircleAvatar(
//                                         radius: 8,
//                                         backgroundColor: othercolorvalue,
//                                         child: Icon(
//                                           Icons.language_sharp,
//                                           size: 15,
//                                           color: whitecolor,
//                                         )),
//                                     const SizedBox(width: 5),
//                                     AutoSizeText(
//                                       'www.clickonadd.com',
//                                       maxLines: 1,
//                                       style: TextStyle(
//                                         color: othercolorvalue,
//                                         fontSize: othersizevalue.toDouble(),
//                                         fontFamily: otherfontvalue != null
//                                             ? otherfontvalue['font']
//                                             : null,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               )
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                     const Expanded(flex: 3, child: SizedBox()),
//                   ],
//                 ),
//               ),
//             ),
//           ]));
//     }
//     if (_frameno == 4) {
//       var height = MediaQuery.of(context).size.width / 4.37;
//       var width = MediaQuery.of(context).size.width * 0.93;
//       return SizedBox(
//           width: width,
//           height: height,
//           child: Stack(children: <Widget>[
//             Positioned(
//                 top: 0,
//                 left: 0,
//                 child: Container(
//                     width: width,
//                     height: height,
//                     decoration: const BoxDecoration(
//                       image: DecorationImage(
//                           image: AssetImage('assets/10.Design Only.png'),
//                           fit: BoxFit.fitWidth),
//                     ))),
//             Positioned(
//                 top: height / 6.4,
//                 left: width / 41.1,
//                 child: Container(
//                     width: width / 6.85,
//                     height: width / 6.85,
//                     decoration: BoxDecoration(
//                       image: DecorationImage(
//                           image: CachedNetworkImageProvider(
//                             widget.profilevalue == null
//                                 ? url
//                                 : "$weburl/${widget.profilevalue["profile_img"]}",
//                           ),
//                           fit: BoxFit.fitWidth),
//                       borderRadius:
//                           const BorderRadius.all(Radius.elliptical(60, 60)),
//                     ))),
//             Positioned(
//                 top: height / 6.4,
//                 left: width / 1.20,
//                 child: Container(
//                     width: width / 6.85,
//                     height: width / 6.85,
//                     decoration: BoxDecoration(
//                       image: DecorationImage(
//                           image: CachedNetworkImageProvider(
//                             widget.profilevalue == null
//                                 ? url
//                                 : "$weburl/${widget.profilevalue["profile_img"]}",
//                           ),
//                           fit: BoxFit.fitWidth),
//                       borderRadius:
//                           const BorderRadius.all(Radius.elliptical(60, 60)),
//                     ))),
//             Positioned(
//               child: SizedBox(
//                 height: height,
//                 width: width,
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                   children: [
//                     const Expanded(flex: 3, child: SizedBox()),
//                     Expanded(
//                       flex: 7,
//                       child: Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: FittedBox(
//                           fit: BoxFit.fill,
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.spaceAround,
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               AutoSizeText(
//                                 widget.profilevalue != null
//                                     ? 'Mauli computers & multi Service'
//                                     : widget.profilevalue['name'],
//                                 softWrap: true,
//                                 maxLines: 1,
//                                 style: TextStyle(
//                                   color: titlecolorvalue,
//                                   fontSize: titlesizevalue.toDouble(),
//                                   fontFamily: titlefontvalue != null
//                                       ? titlefontvalue['font']
//                                       : null,
//                                 ),
//                               ),
//                               Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   Row(
//                                     children: [
//                                       CircleAvatar(
//                                           radius: 8,
//                                           backgroundColor: titlecolorvalue,
//                                           child: Icon(
//                                             Icons.person,
//                                             size: 15,
//                                             color: whitecolor,
//                                           )),
//                                       const SizedBox(width: 5),
//                                       AutoSizeText(
//                                         widget.profilevalue == null
//                                             ? 'Mauli computers & multi Service'
//                                             : widget.profilevalue['name'],
//                                         maxLines: 1,
//                                         style: TextStyle(
//                                           color: titlecolorvalue,
//                                           fontSize: othersizevalue.toDouble(),
//                                           fontFamily: otherfontvalue != null
//                                               ? otherfontvalue['font']
//                                               : null,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                   w(5),
//                                   Row(
//                                     children: [
//                                       CircleAvatar(
//                                           radius: 8,
//                                           backgroundColor: othercolorvalue,
//                                           child: Icon(
//                                             Icons.call,
//                                             size: 15,
//                                             color: whitecolor,
//                                           )),
//                                       const SizedBox(width: 5),
//                                       Text(
//                                         widget.profilevalue == null
//                                             ? '1234567890'
//                                             : widget.profilevalue['mobileno'],
//                                         style: TextStyle(
//                                           color: othercolorvalue,
//                                           fontSize: othersizevalue.toDouble(),
//                                           fontFamily: otherfontvalue != null
//                                               ? otherfontvalue['font']
//                                               : null,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ],
//                               ),
//                               FittedBox(
//                                 child: Row(
//                                   children: [
//                                     CircleAvatar(
//                                         radius: 8,
//                                         backgroundColor: othercolorvalue,
//                                         child: Icon(
//                                           Icons.email,
//                                           size: 15,
//                                           color: whitecolor,
//                                         )),
//                                     const SizedBox(width: 5),
//                                     AutoSizeText(
//                                       widget.profilevalue == null
//                                           ? 'Clickonadd@gmail.com'
//                                           : widget.profilevalue['email'],
//                                       maxLines: 1,
//                                       style: TextStyle(
//                                         color: othercolorvalue,
//                                         fontSize: othersizevalue.toDouble(),
//                                         fontFamily: otherfontvalue != null
//                                             ? otherfontvalue['font']
//                                             : null,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               FittedBox(
//                                 child: Row(
//                                   children: [
//                                     CircleAvatar(
//                                         radius: 8,
//                                         backgroundColor: othercolorvalue,
//                                         child: Icon(
//                                           Icons.location_on,
//                                           size: 15,
//                                           color: whitecolor,
//                                         )),
//                                     const SizedBox(width: 5),
//                                     AutoSizeText(
//                                       'Near SBI Bank,Keshav Nagar',
//                                       maxLines: 1,
//                                       style: TextStyle(
//                                         color: othercolorvalue,
//                                         fontSize: othersizevalue.toDouble(),
//                                         fontFamily: otherfontvalue != null
//                                             ? otherfontvalue['font']
//                                             : null,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               FittedBox(
//                                 child: Row(
//                                   children: [
//                                     CircleAvatar(
//                                         radius: 8,
//                                         backgroundColor: othercolorvalue,
//                                         child: Icon(
//                                           Icons.language_sharp,
//                                           size: 15,
//                                           color: whitecolor,
//                                         )),
//                                     const SizedBox(width: 5),
//                                     AutoSizeText(
//                                       'www.clickonadd.com',
//                                       maxLines: 1,
//                                       style: TextStyle(
//                                         color: othercolorvalue,
//                                         fontSize: othersizevalue.toDouble(),
//                                         fontFamily: otherfontvalue != null
//                                             ? otherfontvalue['font']
//                                             : null,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               )
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                     const Expanded(flex: 3, child: SizedBox()),
//                   ],
//                 ),
//               ),
//             ),
//           ]));
//     }
//     if (_frameno == 5) {
//       var height = MediaQuery.of(context).size.width / 4.37;
//       var width = MediaQuery.of(context).size.width * 0.93;

//       return SizedBox(
//           width: width,
//           height: height,
//           child: Stack(children: <Widget>[
//             Positioned(
//                 top: 0,
//                 left: 0,
//                 child: Container(
//                     width: width,
//                     height: height,
//                     decoration: const BoxDecoration(
//                       image: DecorationImage(
//                           image: AssetImage('assets/11.Design Only.png'),
//                           fit: BoxFit.fitWidth),
//                     ))),
//             Positioned(
//                 top: height / 7,
//                 left: width / 58.71,
//                 child: Container(
//                     width: width / 5.87,
//                     height: width / 5.87,
//                     decoration: BoxDecoration(
//                       image: DecorationImage(
//                           image: CachedNetworkImageProvider(
//                             widget.profilevalue == null
//                                 ? url
//                                 : "$weburl/${widget.profilevalue["profile_img"]}",
//                           ),
//                           fit: BoxFit.fitWidth),
//                       borderRadius:
//                           const BorderRadius.all(Radius.elliptical(70, 70)),
//                     ))),
//             Positioned(
//                 top: height / 7,
//                 left: width / 1.24,
//                 child: Container(
//                     width: width / 5.87,
//                     height: width / 5.87,
//                     decoration: BoxDecoration(
//                       image: DecorationImage(
//                           image: CachedNetworkImageProvider(
//                             widget.profilevalue == null
//                                 ? url
//                                 : "$weburl/${widget.profilevalue["profile_img"]}",
//                           ),
//                           fit: BoxFit.fitWidth),
//                       borderRadius:
//                           const BorderRadius.all(Radius.elliptical(70, 70)),
//                     ))),
//             Positioned(
//               child: SizedBox(
//                 height: height,
//                 width: width,
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                   children: [
//                     const Expanded(flex: 3, child: SizedBox()),
//                     Expanded(
//                       flex: 7,
//                       child: Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: FittedBox(
//                           fit: BoxFit.fill,
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.spaceAround,
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               AutoSizeText(
//                                 widget.profilevalue != null
//                                     ? 'Mauli computers & multi Service'
//                                     : widget.profilevalue['name'],
//                                 softWrap: true,
//                                 maxLines: 1,
//                                 style: TextStyle(
//                                   color: titlecolorvalue,
//                                   fontSize: titlesizevalue.toDouble(),
//                                   fontFamily: titlefontvalue != null
//                                       ? titlefontvalue['font']
//                                       : null,
//                                 ),
//                               ),
//                               Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   Row(
//                                     children: [
//                                       CircleAvatar(
//                                           radius: 8,
//                                           backgroundColor: titlecolorvalue,
//                                           child: Icon(
//                                             Icons.person,
//                                             size: 15,
//                                             color: whitecolor,
//                                           )),
//                                       const SizedBox(width: 5),
//                                       AutoSizeText(
//                                         widget.profilevalue == null
//                                             ? 'Mauli computers & multi Service'
//                                             : widget.profilevalue['name'],
//                                         maxLines: 1,
//                                         style: TextStyle(
//                                           color: titlecolorvalue,
//                                           fontSize: othersizevalue.toDouble(),
//                                           fontFamily: otherfontvalue != null
//                                               ? otherfontvalue['font']
//                                               : null,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                   w(5),
//                                   Row(
//                                     children: [
//                                       CircleAvatar(
//                                           radius: 8,
//                                           backgroundColor: othercolorvalue,
//                                           child: Icon(
//                                             Icons.call,
//                                             size: 15,
//                                             color: whitecolor,
//                                           )),
//                                       const SizedBox(width: 5),
//                                       Text(
//                                         widget.profilevalue == null
//                                             ? '1234567890'
//                                             : widget.profilevalue['mobileno'],
//                                         style: TextStyle(
//                                           color: othercolorvalue,
//                                           fontSize: othersizevalue.toDouble(),
//                                           fontFamily: otherfontvalue != null
//                                               ? otherfontvalue['font']
//                                               : null,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ],
//                               ),
//                               FittedBox(
//                                 child: Row(
//                                   children: [
//                                     CircleAvatar(
//                                         radius: 8,
//                                         backgroundColor: othercolorvalue,
//                                         child: Icon(
//                                           Icons.email,
//                                           size: 15,
//                                           color: whitecolor,
//                                         )),
//                                     const SizedBox(width: 5),
//                                     AutoSizeText(
//                                       widget.profilevalue == null
//                                           ? 'Clickonadd@gmail.com'
//                                           : widget.profilevalue['email'],
//                                       maxLines: 1,
//                                       style: TextStyle(
//                                         color: othercolorvalue,
//                                         fontSize: othersizevalue.toDouble(),
//                                         fontFamily: otherfontvalue != null
//                                             ? otherfontvalue['font']
//                                             : null,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               FittedBox(
//                                 child: Row(
//                                   children: [
//                                     CircleAvatar(
//                                         radius: 8,
//                                         backgroundColor: othercolorvalue,
//                                         child: Icon(
//                                           Icons.location_on,
//                                           size: 15,
//                                           color: whitecolor,
//                                         )),
//                                     const SizedBox(width: 5),
//                                     AutoSizeText(
//                                       'Near SBI Bank,Keshav Nagar',
//                                       maxLines: 1,
//                                       style: TextStyle(
//                                         color: othercolorvalue,
//                                         fontSize: othersizevalue.toDouble(),
//                                         fontFamily: otherfontvalue != null
//                                             ? otherfontvalue['font']
//                                             : null,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               FittedBox(
//                                 child: Row(
//                                   children: [
//                                     CircleAvatar(
//                                         radius: 8,
//                                         backgroundColor: othercolorvalue,
//                                         child: Icon(
//                                           Icons.language_sharp,
//                                           size: 15,
//                                           color: whitecolor,
//                                         )),
//                                     const SizedBox(width: 5),
//                                     AutoSizeText(
//                                       'www.clickonadd.com',
//                                       maxLines: 1,
//                                       style: TextStyle(
//                                         color: othercolorvalue,
//                                         fontSize: othersizevalue.toDouble(),
//                                         fontFamily: otherfontvalue != null
//                                             ? otherfontvalue['font']
//                                             : null,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               )
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                     const Expanded(flex: 3, child: SizedBox()),
//                   ],
//                 ),
//               ),
//             ),
//           ]));
//     }

//     if (_frameno == 6) {
//       var height = MediaQuery.of(context).size.width / 7;
//       var width = MediaQuery.of(context).size.width * 0.93;
//       return SizedBox(
//           width: width,
//           height: height + 5,
//           child: Stack(children: <Widget>[
//             Positioned(
//                 top: 0,
//                 left: 0,
//                 child: Container(
//                     width: width,
//                     height: height,
//                     decoration: const BoxDecoration(
//                       image: DecorationImage(
//                           image: AssetImage('assets/Footer-1.png'),
//                           fit: BoxFit.fitWidth),
//                     ))),
//             Positioned(
//                 top: height / 20.66,
//                 child: SizedBox(
//                   width: width,
//                   height: height,
//                   child: Row(
//                     children: [
//                       Expanded(
//                         flex: 8,
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.spaceAround,
//                           children: [
//                             AutoSizeText(
//                               widget.profilevalue == null
//                                   ? 'Mauli computers & multi Service'
//                                   : widget.profilevalue['name'],
//                               maxLines: 1,
//                               style: TextStyle(
//                                 color: titlecolorvalue,
//                                 fontSize: othersizevalue.toDouble(),
//                                 fontFamily: otherfontvalue != null
//                                     ? otherfontvalue['font']
//                                     : null,
//                               ),
//                             ),
//                             FittedBox(
//                               child: Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceAround,
//                                 children: [
//                                   FittedBox(
//                                     child: Padding(
//                                       padding: const EdgeInsets.only(left: 10),
//                                       child: Row(
//                                         children: [
//                                           CircleAvatar(
//                                               radius: 8,
//                                               backgroundColor: othercolorvalue,
//                                               child: Icon(
//                                                 Icons.email,
//                                                 size: 15,
//                                                 color: whitecolor,
//                                               )),
//                                           const SizedBox(width: 5),
//                                           AutoSizeText(
//                                             widget.profilevalue == null
//                                                 ? 'Clickonadd@gmail.com'
//                                                 : widget.profilevalue['email'],
//                                             maxLines: 1,
//                                             style: TextStyle(
//                                               color: othercolorvalue,
//                                               fontSize:
//                                                   othersizevalue.toDouble(),
//                                               fontFamily: otherfontvalue != null
//                                                   ? otherfontvalue['font']
//                                                   : null,
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                   ),
//                                   const SizedBox(width: 5),
//                                   FittedBox(
//                                     child: Padding(
//                                       padding: const EdgeInsets.only(right: 10),
//                                       child: Row(
//                                         children: [
//                                           CircleAvatar(
//                                               radius: 8,
//                                               backgroundColor: othercolorvalue,
//                                               child: Icon(
//                                                 Icons.call,
//                                                 size: 15,
//                                                 color: whitecolor,
//                                               )),
//                                           const SizedBox(width: 5),
//                                           AutoSizeText(
//                                             widget.profilevalue == null
//                                                 ? '1234567890'
//                                                 : widget
//                                                     .profilevalue['mobileno'],
//                                             maxLines: 1,
//                                             style: TextStyle(
//                                               color: othercolorvalue,
//                                               fontSize:
//                                                   othersizevalue.toDouble(),
//                                               fontFamily: otherfontvalue != null
//                                                   ? otherfontvalue['font']
//                                                   : null,
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 CircleAvatar(
//                                     radius: 8,
//                                     backgroundColor: othercolorvalue,
//                                     child: Icon(
//                                       Icons.location_on,
//                                       size: 15,
//                                       color: whitecolor,
//                                     )),
//                                 const SizedBox(width: 5),
//                                 AutoSizeText(
//                                   'Near SBI Bank,Keshav Nagar',
//                                   maxLines: 1,
//                                   style: TextStyle(
//                                     color: othercolorvalue,
//                                     fontSize: othersizevalue.toDouble(),
//                                     fontFamily: otherfontvalue != null
//                                         ? otherfontvalue['font']
//                                         : null,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 )),
//           ]));
//     }

//     if (_frameno == 7) {
//       var height = MediaQuery.of(context).size.width / 4.37;
//       var width = MediaQuery.of(context).size.width * 0.93;
//       return Container(
//           alignment: Alignment.center,
//           width: width,
//           height: height,
//           child: Stack(children: <Widget>[
//             Positioned(
//                 top: 0,
//                 left: 0,
//                 child: Container(
//                     width: width,
//                     height: height,
//                     decoration: const BoxDecoration(
//                       image: DecorationImage(
//                           image: AssetImage('assets/2.png'),
//                           fit: BoxFit.fitWidth),
//                     ))),
//             Positioned(
//                 top: height / 7,
//                 left: width / 6.9,
//                 child: Container(
//                     width: width / 8.4,
//                     height: width / 8.4,
//                     decoration: BoxDecoration(
//                       image: DecorationImage(
//                           image: CachedNetworkImageProvider(
//                             widget.profilevalue == null
//                                 ? url
//                                 : "$weburl/${widget.profilevalue["profile_img"]}",
//                           ),
//                           fit: BoxFit.fitWidth),
//                       borderRadius: BorderRadius.all(
//                           Radius.elliptical(width / 8.7, width / 8.7)),
//                     ))),
//             Positioned(
//                 top: height / 7,
//                 left: width / 1.36,
//                 child: Container(
//                     width: width / 8.4,
//                     height: width / 8.4,
//                     decoration: BoxDecoration(
//                       image: DecorationImage(
//                           image: CachedNetworkImageProvider(
//                             widget.profilevalue == null
//                                 ? url
//                                 : "$weburl/${widget.profilevalue["profile_img"]}",
//                           ),
//                           fit: BoxFit.fitWidth),
//                       borderRadius: BorderRadius.all(
//                           Radius.elliptical(width / 8.7, width / 8.7)),
//                     ))),
//             Positioned(
//                 top: height / 4.5,
//                 left: width / 3.3,
//                 right: width / 3.3,
//                 child: SizedBox(
//                   width: width / 2,
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       FittedBox(
//                         child: AutoSizeText(
//                           widget.profilevalue == null
//                               ? 'Mauli computers & multi Service'
//                               : widget.profilevalue['name'],
//                           maxLines: 1,
//                           style: TextStyle(
//                             color: titlecolorvalue,
//                             fontSize: othersizevalue.toDouble(),
//                             fontFamily: otherfontvalue != null
//                                 ? otherfontvalue['font']
//                                 : null,
//                           ),
//                         ),
//                       ),
//                       h(2),
//                       FittedBox(
//                         child: AutoSizeText(
//                           widget.profilevalue != null
//                               ? 'Mauli computers & multi Service Mauli computers & multi Service'
//                               : widget.profilevalue['name'],
//                           softWrap: true,
//                           maxLines: 2,
//                           style: TextStyle(
//                             color: titlecolorvalue,
//                             fontSize: titlesizevalue.toDouble(),
//                             fontFamily: titlefontvalue != null
//                                 ? titlefontvalue['font']
//                                 : null,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 )),
//             Positioned(
//                 top: height / 1.4,
//                 left: width / 29,
//                 right: width / 29,
//                 child: SizedBox(
//                     width: width,
//                     height: height / 6,
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceAround,
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         FittedBox(
//                           child: Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Row(
//                               children: [
//                                 CircleAvatar(
//                                     radius: 12,
//                                     backgroundColor: othercolorvalue,
//                                     child: Icon(
//                                       Icons.call,
//                                       size: 15,
//                                       color: whitecolor,
//                                     )),
//                                 const SizedBox(width: 5),
//                                 AutoSizeText(
//                                   widget.profilevalue == null
//                                       ? '1234567890'
//                                       : widget.profilevalue['mobileno'],
//                                   maxLines: 1,
//                                   style: TextStyle(
//                                     color: othercolorvalue,
//                                     fontSize: othersizevalue.toDouble(),
//                                     fontFamily: otherfontvalue != null
//                                         ? otherfontvalue['font']
//                                         : null,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                         FittedBox(
//                           child: Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Row(
//                               children: [
//                                 CircleAvatar(
//                                     radius: 12,
//                                     backgroundColor: othercolorvalue,
//                                     child: Icon(
//                                       Icons.email,
//                                       size: 15,
//                                       color: whitecolor,
//                                     )),
//                                 const SizedBox(width: 5),
//                                 AutoSizeText(
//                                   widget.profilevalue == null
//                                       ? 'Clickonadd@gmail.com'
//                                       : widget.profilevalue['email'],
//                                   maxLines: 1,
//                                   style: TextStyle(
//                                     color: othercolorvalue,
//                                     fontSize: othersizevalue.toDouble(),
//                                     fontFamily: otherfontvalue != null
//                                         ? otherfontvalue['font']
//                                         : null,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                         FittedBox(
//                             child: Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               CircleAvatar(
//                                   radius: 12,
//                                   backgroundColor: othercolorvalue,
//                                   child: Icon(
//                                     Icons.location_on,
//                                     size: 15,
//                                     color: whitecolor,
//                                   )),
//                               const SizedBox(width: 5),
//                               AutoSizeText(
//                                 'Near SBI Bank,Keshav Nagar',
//                                 maxLines: 1,
//                                 style: TextStyle(
//                                   color: othercolorvalue,
//                                   fontSize: othersizevalue.toDouble(),
//                                   fontFamily: otherfontvalue != null
//                                       ? otherfontvalue['font']
//                                       : null,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ))
//                       ],
//                     ))),
//           ]));
//     }
//     if (_frameno == 8) {
//       return Container(
//         decoration: const BoxDecoration(),
//         child: Column(
//           children: [
//             Container(
//               padding: const EdgeInsets.only(top: 5, bottom: 5),
//               decoration: const BoxDecoration(
//                   gradient: LinearGradient(
//                       colors: [Color(0xffd20b82), Color(0xff300c4a)])),
//               child: Row(
//                 children: [
//                   Expanded(
//                     flex: 2,
//                     child: Center(
//                       child: CircleAvatar(
//                         radius: MediaQuery.of(context).size.width / 14,
//                         backgroundColor: whitecolor,
//                         foregroundColor: whitecolor,
//                         child: CircleAvatar(
//                           radius: MediaQuery.of(context).size.width / 15,
//                           backgroundColor: blackcolor,
//                           backgroundImage: CachedNetworkImageProvider(
//                             widget.profilevalue == null
//                                 ? url
//                                 : "$weburl/${widget.profilevalue["profile_img"]}",
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                   Expanded(
//                     flex: 8,
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             FittedBox(
//                               child: AutoSizeText(
//                                 widget.profilevalue == null
//                                     ? 'Mauli computers & multi Service'
//                                     : widget.profilevalue['name'],
//                                 maxLines: 1,
//                                 style: TextStyle(
//                                   color: titlecolorvalue,
//                                   fontSize: othersizevalue.toDouble(),
//                                   fontFamily: otherfontvalue != null
//                                       ? otherfontvalue['font']
//                                       : null,
//                                 ),
//                               ),
//                             ),
//                             FittedBox(
//                               child: Container(
//                                 padding: const EdgeInsets.all(10),
//                                 decoration: BoxDecoration(
//                                   color: Colors.yellow,
//                                   border:
//                                       Border.all(color: whitecolor, width: 2),
//                                   borderRadius: const BorderRadius.only(
//                                       bottomLeft: Radius.circular(25),
//                                       topLeft: Radius.circular(25)),
//                                 ),
//                                 child: Text(
//                                   "केंद्र एक सेवा अनेक",
//                                   style: TextStyle(
//                                       fontWeight: FontWeight.bold,
//                                       foreground: Paint()
//                                         ..shader = const LinearGradient(
//                                             colors: [
//                                               Color(0xff870f2e),
//                                               Color(0xff300c4a)
//                                             ]).createShader(
//                                             const Rect.fromLTRB(2, 3, 2, 2))),
//                                 ),
//                               ),
//                             )
//                           ],
//                         ),
//                         FittedBox(
//                           child: AutoSizeText(
//                             widget.profilevalue != null
//                                 ? 'Mauli computers & multi Service'
//                                 : widget.profilevalue['name'],
//                             softWrap: true,
//                             maxLines: 1,
//                             style: TextStyle(
//                               color: titlecolorvalue,
//                               fontSize: titlesizevalue.toDouble(),
//                               fontFamily: titlefontvalue != null
//                                   ? titlefontvalue['font']
//                                   : null,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   )
//                 ],
//               ),
//             ),
//             FittedBox(
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceAround,
//                 children: [
//                   FittedBox(
//                     child: Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Row(
//                         children: [
//                           CircleAvatar(
//                               radius: 12,
//                               backgroundColor: othercolorvalue,
//                               child: Icon(
//                                 Icons.call,
//                                 size: 15,
//                                 color: whitecolor,
//                               )),
//                           const SizedBox(width: 5),
//                           AutoSizeText(
//                             widget.profilevalue == null
//                                 ? '1234567890'
//                                 : widget.profilevalue['mobileno'],
//                             maxLines: 1,
//                             style: TextStyle(
//                               color: othercolorvalue,
//                               fontSize: othersizevalue.toDouble(),
//                               fontFamily: otherfontvalue != null
//                                   ? otherfontvalue['font']
//                                   : null,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   FittedBox(
//                     child: Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Row(
//                         children: [
//                           CircleAvatar(
//                               radius: 12,
//                               backgroundColor: othercolorvalue,
//                               child: Icon(
//                                 Icons.email,
//                                 size: 15,
//                                 color: whitecolor,
//                               )),
//                           const SizedBox(width: 5),
//                           AutoSizeText(
//                             widget.profilevalue == null
//                                 ? 'Clickonadd@gmail.com'
//                                 : widget.profilevalue['email'],
//                             maxLines: 1,
//                             style: TextStyle(
//                               color: othercolorvalue,
//                               fontSize: othersizevalue.toDouble(),
//                               fontFamily: otherfontvalue != null
//                                   ? otherfontvalue['font']
//                                   : null,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   FittedBox(
//                       child: Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         CircleAvatar(
//                             radius: 12,
//                             backgroundColor: othercolorvalue,
//                             child: Icon(
//                               Icons.location_on,
//                               size: 15,
//                               color: whitecolor,
//                             )),
//                         const SizedBox(width: 5),
//                         AutoSizeText(
//                           'Near SBI Bank,Keshav Nagar',
//                           maxLines: 1,
//                           style: TextStyle(
//                             color: othercolorvalue,
//                             fontSize: othersizevalue.toDouble(),
//                             fontFamily: otherfontvalue != null
//                                 ? otherfontvalue['font']
//                                 : null,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ))
//                 ],
//               ),
//             ),
//           ],
//         ),
//       );
//     }
//     if (_frameno == 9) {
//       var height = MediaQuery.of(context).size.width / 4.37;
//       var width = MediaQuery.of(context).size.width * 0.94;
//       return SizedBox(
//           width: width,
//           height: height,
//           child: Stack(children: <Widget>[
//             Positioned(
//                 top: 0,
//                 left: 0,
//                 child: Container(
//                     width: width,
//                     height: height,
//                     decoration: const BoxDecoration(
//                       image: DecorationImage(
//                           image: AssetImage('assets/3.png'),
//                           fit: BoxFit.fitWidth),
//                     ))),
//             Positioned(
//                 top: height / 8.4,
//                 left: width / 3.76,
//                 child: Container(
//                     width: width / 5.48,
//                     height: height / 1.35,
//                     decoration: BoxDecoration(
//                       image: DecorationImage(
//                           image: CachedNetworkImageProvider(
//                             widget.profilevalue == null
//                                 ? url
//                                 : "$weburl/${widget.profilevalue["profile_img"]}",
//                           ),
//                           fit: BoxFit.fitWidth),
//                       borderRadius:
//                           const BorderRadius.all(Radius.elliptical(75, 74)),
//                     ))),
//             Positioned(
//               top: height / 9,
//               left: width / 31,
//               child: SizedBox(
//                 width: width,
//                 height: height / 2,
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     Expanded(
//                       flex: 4,
//                       child: Text(
//                         widget.profilevalue == null
//                             ? 'Mauli computers & multi Service'
//                             : widget.profilevalue['name'],
//                         maxLines: 2,
//                         softWrap: true,
//                         style: TextStyle(
//                           color: titlecolorvalue,
//                           fontSize: othersizevalue.toDouble(),
//                           fontFamily: otherfontvalue != null
//                               ? otherfontvalue['font']
//                               : null,
//                         ),
//                       ),
//                     ),
//                     Expanded(flex: 2, child: Container()),
//                     Expanded(
//                       flex: 8,
//                       child: Text(
//                         widget.profilevalue != null
//                             ? 'Mauli computers & multi Service'
//                             : widget.profilevalue['name'],
//                         softWrap: true,
//                         maxLines: 3,
//                         style: TextStyle(
//                           color: titlecolorvalue,
//                           fontSize: titlesizevalue.toDouble(),
//                           fontFamily: titlefontvalue != null
//                               ? titlefontvalue['font']
//                               : null,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             Positioned(
//                 top: height / 1.6,
//                 left: width / 41,
//                 child: SizedBox(
//                   width: width,
//                   height: height / 3.125,
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Expanded(
//                         flex: 4,
//                         child: Row(
//                           children: [
//                             CircleAvatar(
//                                 radius: 12,
//                                 backgroundColor: othercolorvalue,
//                                 child: Icon(
//                                   Icons.call,
//                                   size: 15,
//                                   color: whitecolor,
//                                 )),
//                             const SizedBox(width: 5),
//                             Text(
//                               widget.profilevalue == null
//                                   ? '1234567890'
//                                   : widget.profilevalue['mobileno'],
//                               maxLines: 1,
//                               style: TextStyle(
//                                 color: othercolorvalue,
//                                 fontSize: othersizevalue.toDouble(),
//                                 fontFamily: otherfontvalue != null
//                                     ? otherfontvalue['font']
//                                     : null,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       Expanded(flex: 2, child: Container()),
//                       Expanded(
//                           flex: 8,
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               CircleAvatar(
//                                   radius: 12,
//                                   backgroundColor: othercolorvalue,
//                                   child: Icon(
//                                     Icons.location_on,
//                                     size: 15,
//                                     color: whitecolor,
//                                   )),
//                               const SizedBox(width: 5),
//                               Text(
//                                 'Near SBI Bank,Keshav Nagar',
//                                 maxLines: 1,
//                                 style: TextStyle(
//                                   color: othercolorvalue,
//                                   fontSize: othersizevalue.toDouble(),
//                                   fontFamily: otherfontvalue != null
//                                       ? otherfontvalue['font']
//                                       : null,
//                                 ),
//                               ),
//                             ],
//                           )),
//                     ],
//                   ),
//                 )),
//           ]));
//     }
//     if (_frameno == 10) {
//       var height = MediaQuery.of(context).size.width / 4.37;
//       var width = MediaQuery.of(context).size.width * 0.94;
//       return SizedBox(
//           width: width,
//           height: height,
//           child: Stack(children: <Widget>[
//             Positioned(
//                 top: 0,
//                 left: 0,
//                 child: Container(
//                     width: width,
//                     height: height,
//                     decoration: const BoxDecoration(
//                       image: DecorationImage(
//                           image: AssetImage('assets/4.png'),
//                           fit: BoxFit.fitWidth),
//                     ))),
//             Positioned(
//                 top: height / 7.8,
//                 left: width / 15.22,
//                 child: Container(
//                     width: width / 5.48,
//                     height: height / 1.35,
//                     decoration: BoxDecoration(
//                       image: DecorationImage(
//                           image: CachedNetworkImageProvider(
//                             widget.profilevalue == null
//                                 ? url
//                                 : "$weburl/${widget.profilevalue["profile_img"]}",
//                           ),
//                           fit: BoxFit.fitWidth),
//                       borderRadius:
//                           const BorderRadius.all(Radius.elliptical(75, 74)),
//                     ))),
//             Positioned(
//               top: height / 1.44,
//               left: width / 2.81,
//               child: AutoSizeText(
//                 'Near SBI Bank,Keshav Nagar',
//                 maxLines: 1,
//                 style: TextStyle(
//                   color: othercolorvalue,
//                   fontSize: othersizevalue.toDouble(),
//                   fontFamily:
//                       otherfontvalue != null ? otherfontvalue['font'] : null,
//                 ),
//               ),
//             ),
//             Positioned(
//                 // top: height / 9.09,
//                 left: width / 3.18,
//                 child: SizedBox(
//                   width: width / 1.5,
//                   height: height / 1.5,
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.spaceAround,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       FittedBox(
//                         child: Text(
//                           widget.profilevalue != null
//                               ? 'Mauli computers & multi Service'
//                               : widget.profilevalue['name'],
//                           softWrap: true,
//                           maxLines: 2,
//                           style: TextStyle(
//                             color: titlecolorvalue,
//                             fontSize: titlesizevalue.toDouble(),
//                             fontFamily: titlefontvalue != null
//                                 ? titlefontvalue['font']
//                                 : null,
//                           ),
//                         ),
//                       ),
//                       FittedBox(
//                         child: Row(
//                           children: [
//                             CircleAvatar(
//                                 radius: 10,
//                                 backgroundColor: othercolorvalue,
//                                 child: Icon(
//                                   Icons.email,
//                                   size: 10,
//                                   color: whitecolor,
//                                 )),
//                             const SizedBox(width: 5),
//                             AutoSizeText(
//                               widget.profilevalue == null
//                                   ? 'Clickonadd@gmail.com'
//                                   : widget.profilevalue['email'],
//                               maxLines: 1,
//                               style: TextStyle(
//                                 color: othercolorvalue,
//                                 fontSize: othersizevalue.toDouble(),
//                                 fontFamily: otherfontvalue != null
//                                     ? otherfontvalue['font']
//                                     : null,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       FittedBox(
//                         child: Row(
//                           children: [
//                             CircleAvatar(
//                                 radius: 10,
//                                 backgroundColor: othercolorvalue,
//                                 child: Icon(
//                                   Icons.call,
//                                   size: 10,
//                                   color: whitecolor,
//                                 )),
//                             const SizedBox(width: 5),
//                             AutoSizeText(
//                               widget.profilevalue == null
//                                   ? '1234567890'
//                                   : widget.profilevalue['mobileno'],
//                               maxLines: 1,
//                               style: TextStyle(
//                                 color: othercolorvalue,
//                                 fontSize: othersizevalue.toDouble(),
//                                 fontFamily: otherfontvalue != null
//                                     ? otherfontvalue['font']
//                                     : null,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 )),
//           ]));
//     }
//     if (_frameno == 11) {
//       var height = MediaQuery.of(context).size.width / 4.37;
//       var width = MediaQuery.of(context).size.width * 0.94;
//       return SizedBox(
//           width: width,
//           height: height,
//           child: Stack(children: <Widget>[
//             Positioned(
//                 top: 0,
//                 left: 0,
//                 child: Container(
//                     width: width,
//                     height: height,
//                     decoration: const BoxDecoration(
//                       image: DecorationImage(
//                           image: AssetImage('assets/5.png'),
//                           fit: BoxFit.fitWidth),
//                     ))),
//             Positioned(
//                 top: height / 7,
//                 left: width / 2.41,
//                 child: Container(
//                     width: width / 5.87,
//                     height: width / 5.87,
//                     decoration: BoxDecoration(
//                       image: DecorationImage(
//                           image: CachedNetworkImageProvider(
//                             widget.profilevalue == null
//                                 ? url
//                                 : "$weburl/${widget.profilevalue["profile_img"]}",
//                           ),
//                           fit: BoxFit.fitWidth),
//                       borderRadius:
//                           const BorderRadius.all(Radius.elliptical(70, 70)),
//                     ))),
//             Positioned(
//               top: height / 9.8,
//               left: width / 100,
//               child: SizedBox(
//                 width: width,
//                 height: height / 2,
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Expanded(
//                       flex: 5,
//                       child: Text(
//                         widget.profilevalue != null
//                             ? 'Mauli computers & multi Service'
//                             : widget.profilevalue['name'],
//                         softWrap: true,
//                         maxLines: 2,
//                         style: TextStyle(
//                           color: titlecolorvalue,
//                           fontSize: titlesizevalue.toDouble(),
//                           fontFamily: titlefontvalue != null
//                               ? titlefontvalue['font']
//                               : null,
//                         ),
//                       ),
//                     ),
//                     const Expanded(flex: 2, child: SizedBox()),
//                     const Expanded(flex: 5, child: SizedBox())
//                   ],
//                 ),
//               ),
//             ),
//             Positioned(
//                 top: height / 1.85,
//                 // left: 17,
//                 child: SizedBox(
//                   width: width,
//                   height: height / 2.3,
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceAround,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Expanded(
//                         flex: 5,
//                         child: Padding(
//                           padding: const EdgeInsets.only(left: 10),
//                           child: FittedBox(
//                             child: Column(
//                               mainAxisAlignment: MainAxisAlignment.spaceAround,
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 FittedBox(
//                                   child: Row(
//                                     children: [
//                                       CircleAvatar(
//                                           radius: 10,
//                                           backgroundColor: othercolorvalue,
//                                           child: Icon(
//                                             Icons.call,
//                                             size: 10,
//                                             color: whitecolor,
//                                           )),
//                                       const SizedBox(width: 5),
//                                       AutoSizeText(
//                                         widget.profilevalue == null
//                                             ? '1234567890'
//                                             : widget.profilevalue['mobileno'],
//                                         maxLines: 1,
//                                         style: TextStyle(
//                                           color: othercolorvalue,
//                                           fontSize: othersizevalue.toDouble(),
//                                           fontFamily: otherfontvalue != null
//                                               ? otherfontvalue['font']
//                                               : null,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                                 FittedBox(
//                                   child: Row(
//                                     children: [
//                                       CircleAvatar(
//                                           radius: 10,
//                                           backgroundColor: othercolorvalue,
//                                           child: Icon(
//                                             Icons.email,
//                                             size: 10,
//                                             color: whitecolor,
//                                           )),
//                                       const SizedBox(width: 5),
//                                       AutoSizeText(
//                                         widget.profilevalue == null
//                                             ? 'Clickonadd@gmail.com'
//                                             : widget.profilevalue['email'],
//                                         maxLines: 1,
//                                         style: TextStyle(
//                                           color: othercolorvalue,
//                                           fontSize: othersizevalue.toDouble(),
//                                           fontFamily: otherfontvalue != null
//                                               ? otherfontvalue['font']
//                                               : null,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ),
//                       const Expanded(flex: 2, child: SizedBox()),
//                       Expanded(
//                           flex: 5,
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             crossAxisAlignment: CrossAxisAlignment.end,
//                             children: [
//                               Row(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   CircleAvatar(
//                                       radius: 12,
//                                       backgroundColor: othercolorvalue,
//                                       child: Icon(
//                                         Icons.location_on,
//                                         size: 15,
//                                         color: whitecolor,
//                                       )),
//                                   const SizedBox(width: 5),
//                                   Flexible(
//                                     child: AutoSizeText(
//                                       'Near SBI Bank,Keshav Nagar',
//                                       maxLines: 2,
//                                       softWrap: true,
//                                       style: TextStyle(
//                                         color: othercolorvalue,
//                                         fontSize: othersizevalue.toDouble(),
//                                         fontFamily: otherfontvalue != null
//                                             ? otherfontvalue['font']
//                                             : null,
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                               const SizedBox()
//                             ],
//                           ))
//                     ],
//                   ),
//                 )),
//           ]));
//     }
//     if (_frameno == 12) {
//       var height = MediaQuery.of(context).size.width / 4.37;
//       var width = MediaQuery.of(context).size.width * 0.94;
//       return SizedBox(
//           width: width,
//           height: height,
//           child: Stack(children: <Widget>[
//             Positioned(
//                 top: 0,
//                 left: 0,
//                 child: Container(
//                     width: width,
//                     height: height,
//                     decoration: const BoxDecoration(
//                       image: DecorationImage(
//                           image: AssetImage('assets/6.png'),
//                           fit: BoxFit.fitWidth),
//                     ))),
//             Positioned(
//                 top: height / 6.8,
//                 left: width / 12.8,
//                 child: Container(
//                     width: width / 5.87,
//                     height: width / 5.87,
//                     decoration: BoxDecoration(
//                       image: DecorationImage(
//                           image: CachedNetworkImageProvider(
//                             widget.profilevalue == null
//                                 ? url
//                                 : "$weburl/${widget.profilevalue["profile_img"]}",
//                           ),
//                           fit: BoxFit.fitWidth),
//                       borderRadius:
//                           const BorderRadius.all(Radius.elliptical(70, 70)),
//                     ))),
//             Positioned(
//                 left: width / 3.7,
//                 child: Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: SizedBox(
//                     height: height / 1.1,
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.spaceAround,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         FittedBox(
//                           child: Row(
//                             children: [
//                               Row(
//                                 children: [
//                                   CircleAvatar(
//                                       radius: 8,
//                                       backgroundColor: titlecolorvalue,
//                                       child: Icon(
//                                         Icons.person,
//                                         size: 15,
//                                         color: whitecolor,
//                                       )),
//                                   const SizedBox(width: 5),
//                                   AutoSizeText(
//                                     widget.profilevalue == null
//                                         ? 'Mauli computers & multi Service'
//                                         : widget.profilevalue['name'],
//                                     maxLines: 1,
//                                     style: TextStyle(
//                                       color: titlecolorvalue,
//                                       fontSize: othersizevalue.toDouble(),
//                                       fontFamily: otherfontvalue != null
//                                           ? otherfontvalue['font']
//                                           : null,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ],
//                           ),
//                         ),
//                         FittedBox(
//                           child: Row(
//                             children: [
//                               CircleAvatar(
//                                   radius: 8,
//                                   backgroundColor: othercolorvalue,
//                                   child: Icon(
//                                     Icons.call,
//                                     size: 15,
//                                     color: whitecolor,
//                                   )),
//                               const SizedBox(width: 5),
//                               Text(
//                                 widget.profilevalue == null
//                                     ? '1234567890'
//                                     : widget.profilevalue['mobileno'],
//                                 style: TextStyle(
//                                   color: othercolorvalue,
//                                   fontSize: othersizevalue.toDouble(),
//                                   fontFamily: otherfontvalue != null
//                                       ? otherfontvalue['font']
//                                       : null,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         // FittedBox(
//                         //   child: Row(
//                         //     children: [
//                         //       CircleAvatar(
//                         //           radius: 8,
//                         //           backgroundColor: othercolorvalue,
//                         //           child: Icon(
//                         //             Icons.email,
//                         //             size: 15,
//                         //             color: whitecolor,
//                         //           )),
//                         //       const SizedBox(width: 5),
//                         //       AutoSizeText(
//                         //         widget.profilevalue == null
//                         //             ? 'Clickonadd@gmail.com'
//                         //             : widget.profilevalue['email'],
//                         //         maxLines: 1,
//                         //         style: TextStyle(
//                         //           color: othercolorvalue,
//                         //           fontSize: othersizevalue.toDouble(),
//                         //           fontFamily: otherfontvalue != null
//                         //               ? otherfontvalue['font']
//                         //               : null,
//                         //         ),
//                         //       ),
//                         //     ],
//                         //   ),
//                         // ),
//                         FittedBox(
//                           child: Row(
//                             children: [
//                               CircleAvatar(
//                                   radius: 8,
//                                   backgroundColor: othercolorvalue,
//                                   child: Icon(
//                                     Icons.language_sharp,
//                                     size: 15,
//                                     color: whitecolor,
//                                   )),
//                               const SizedBox(width: 5),
//                               AutoSizeText(
//                                 'www.clickonadd.com',
//                                 maxLines: 1,
//                                 style: TextStyle(
//                                   color: othercolorvalue,
//                                   fontSize: othersizevalue.toDouble(),
//                                   fontFamily: otherfontvalue != null
//                                       ? otherfontvalue['font']
//                                       : null,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         FittedBox(
//                           child: Row(
//                             children: [
//                               CircleAvatar(
//                                   radius: 8,
//                                   backgroundColor: othercolorvalue,
//                                   child: Icon(
//                                     Icons.location_on,
//                                     size: 15,
//                                     color: whitecolor,
//                                   )),
//                               const SizedBox(width: 5),
//                               AutoSizeText(
//                                 'Near SBI Bank,Keshav Nagar',
//                                 maxLines: 1,
//                                 style: TextStyle(
//                                   color: othercolorvalue,
//                                   fontSize: othersizevalue.toDouble(),
//                                   fontFamily: otherfontvalue != null
//                                       ? otherfontvalue['font']
//                                       : null,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         )
//                       ],
//                     ),
//                   ),
//                 )),
//             Positioned(
//               top: height / 2.7,
//               left: width / 1.84,
//               child: FittedBox(
//                 child: AutoSizeText(
//                   widget.profilevalue != null
//                       ? 'Mauli computers & multi Service'
//                       : widget.profilevalue['name'],
//                   softWrap: true,
//                   maxLines: 1,
//                   style: TextStyle(
//                     color: titlecolorvalue,
//                     fontSize: titlesizevalue.toDouble(),
//                     fontFamily:
//                         titlefontvalue != null ? titlefontvalue['font'] : null,
//                   ),
//                 ),
//               ),
//             ),
//           ]));
//     }
//   }
// }

// class MyWaveClipper5 extends CustomClipper<Path> {
//   @override
//   Path getClip(Size size) {
//     var path = Path();
//     path.lineTo(0, 30);
//     path.lineTo(0, size.height);
//     path.lineTo(size.width, size.height);
//     path.lineTo(size.width, 30);
//     path.quadraticBezierTo(
//         size.width * 0.16 * 5, 60, size.width * 0.16 * 4, 30);
//     path.quadraticBezierTo(size.width * 0.16 * 3, 0, size.width * 0.16 * 2, 30);
//     path.quadraticBezierTo(size.width * 0.16 * 1, 60, 0, 30);
//     path.close();
//     return path;
//   }

//   @override
//   bool shouldReclip(CustomClipper<Path> oldClipper) {
//     return false;
//   }
// }

// class MyWaveClipper6 extends CustomClipper<Path> {
//   @override
//   Path getClip(Size size) {
//     var path = Path();
//     path.lineTo(0, 30);
//     path.lineTo(0, size.height);
//     path.lineTo(size.width, size.height);
//     path.lineTo(size.width, 30);
//     path.quadraticBezierTo(
//         size.width * 0.16 * 5, 60, size.width * 0.16 * 4, 30);
//     path.quadraticBezierTo(size.width * 0.16 * 3, 0, size.width * 0.16 * 2, 30);
//     path.quadraticBezierTo(size.width * 0.16 * 1, 60, 0, 30);
//     path.close();
//     return path;
//   }

//   @override
//   bool shouldReclip(CustomClipper<Path> oldClipper) {
//     return false;
//   }
// }

// class MyWaveClipper7 extends CustomClipper<Path> {
//   @override
//   Path getClip(Size size) {
//     var path = Path();
//     path.lineTo(0, 0);
//     path.lineTo(0, size.height);
//     path.lineTo(size.width, size.height);
//     path.lineTo(size.width, 0);
//     path.quadraticBezierTo(
//         size.width * 0.15 * 6, 90, size.width * 0.15 * 3, 30);
//     path.quadraticBezierTo(size.width * 0.15, 0, 0, 30);
//     path.close();
//     return path;
//   }

//   @override
//   bool shouldReclip(CustomClipper<Path> oldClipper) {
//     return false;
//   }
// }

// // if (_frameno == 1) {
// //   return Padding(
// //     padding: const EdgeInsets.all(8.0),
// //     child: Row(
// //       children: [
// //         Container(
// //           height: 70,
// //           width: 70,
// //           decoration: BoxDecoration(
// //               borderRadius: BorderRadius.circular(10),
// //               border: Border.all(color: Colors.black, width: 1),
// //               image: DecorationImage(
// //                   image: CachedNetworkImageProvider(widget.profilevalue == null
// //                       ? url
// //                       : "$weburl/${widget.profilevalue["profile_img"]}"))),
// //         ),
// //         const SizedBox(
// //           width: 10,
// //         ),
// //         SizedBox(
// //           height: 70,
// //           child: Column(
// //             children: [
// //               Text(
// //                 widget.profilevalue == null
// //                     ? 'Mauli computers & multi Service'
// //                     : widget.profilevalue['name'],
// //                 style: TextStyle(
// //                   fontFamily: Assets.labell,
// //                   decoration: TextDecoration.none,
// //                   color: pickedcolor,
// //                   fontSize: 15,
// //                   // fontWeight: FontWeight.bold
// //                 ),
// //               ),
// //               Text(
// //                 'Address',
// //                 style: TextStyle(
// //                     decoration: TextDecoration.none,
// //                     color: pickedcolor,
// //                     fontSize: 15,
// //                     fontWeight: FontWeight.bold),
// //               ),
// //               Text(
// //                 widget.profilevalue == null
// //                     ? 'Clickonadd@gmail.com'
// //                     : widget.profilevalue['email'],
// //                 style: TextStyle(
// //                     decoration: TextDecoration.none,
// //                     color: pickedcolor,
// //                     fontSize: 15,
// //                     fontWeight: FontWeight.bold),
// //               ),
// //             ],
// //           ),
// //         ),
// //       ],
// //     ),
// //   );
// // }
// // if (_frameno == 2) {
// //   return Padding(
// //     padding: const EdgeInsets.all(8.0),
// //     child: SizedBox(
// //       child: Column(
// //         children: [
// //           Text(
// //             widget.profilevalue == null
// //                 ? 'Mauli computers & multi Service'
// //                 : widget.profilevalue['name'],
// //             style: TextStyle(
// //                 color: pickedcolor,
// //                 fontSize: 15,
// //                 decoration: TextDecoration.none,
// //                 fontWeight: FontWeight.bold),
// //           ),
// //           Row(
// //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //             children: [
// //               Text(
// //                 widget.profilevalue == null
// //                     ? 'Clickonadd@gmail.com'
// //                     : widget.profilevalue['email'],
// //                 style: TextStyle(
// //                   color: pickedcolor,
// //                   fontSize: 15,
// //                   decoration: TextDecoration.none,
// //                 ),
// //               ),
// //               Text(
// //                 widget.profilevalue == null
// //                     ? '1234567890'
// //                     : widget.profilevalue['mobileno'],
// //                 style: TextStyle(
// //                   color: pickedcolor,
// //                   fontSize: 15,
// //                   decoration: TextDecoration.none,
// //                 ),
// //               ),
// //               Text(
// //                 'Address',
// //                 style: TextStyle(
// //                   color: pickedcolor,
// //                   fontSize: 15,
// //                   decoration: TextDecoration.none,
// //                 ),
// //               ),
// //             ],
// //           ),
// //           Row(
// //             mainAxisAlignment: MainAxisAlignment.center,
// //             children: [
// //               Icon(Icons.location_on),
// //               Text(
// //                 'Near SBI Bank,Keshav Nagar,Pune-411036',
// //                 style: TextStyle(
// //                   color: pickedcolor,
// //                   fontSize: 15,
// //                   decoration: TextDecoration.none,
// //                 ),
// //               ),
// //             ],
// //           ),
// //         ],
// //       ),
// //     ),
// //   );
// // }
// // if (_frameno == 3) {
// //   return Padding(
// //     padding: const EdgeInsets.all(8.0),
// //     child: Container(
// //       child: Row(
// //         children: [
// //           CircleAvatar(
// //             radius: 40,
// //             backgroundImage: CachedNetworkImageProvider(
// //               widget.profilevalue == null
// //                   ? url
// //                   : "$weburl/${widget.profilevalue["profile_img"]}",
// //             ),
// //           ),
// //           const SizedBox(
// //             width: 5,
// //           ),
// //           SizedBox(
// //             height: 80,
// //             child: Column(
// //               children: [
// //                 Text(
// //                   widget.profilevalue == null
// //                       ? 'Mauli computers & multi Service'
// //                       : widget.profilevalue['name'],
// //                   softWrap: true,
// //                   style: TextStyle(
// //                       color: pickedcolor,
// //                       fontSize: 15,
// //                       decoration: TextDecoration.none,
// //                       fontWeight: FontWeight.bold),
// //                 ),
// //                 Row(
// //                   children: [
// //                     Text(
// //                       widget.profilevalue == null
// //                           ? 'Clickonadd@gmail.com'
// //                           : widget.profilevalue['email'],
// //                       style: TextStyle(
// //                         color: pickedcolor,
// //                         fontSize: 15,
// //                         decoration: TextDecoration.none,
// //                       ),
// //                     ),
// //                     SizedBox(width: 5),
// //                     Text(
// //                       widget.profilevalue == null
// //                           ? '1234567890'
// //                           : widget.profilevalue['mobileno'],
// //                       style: TextStyle(
// //                         color: pickedcolor,
// //                         fontSize: 15,
// //                         decoration: TextDecoration.none,
// //                       ),
// //                     ),
// //                   ],
// //                 ),
// //                 Row(
// //                   children: [
// //                     Icon(Icons.location_on),
// //                     Text(
// //                       'Near SBI Bank,Keshav Nagar',
// //                       style: TextStyle(
// //                         color: pickedcolor,
// //                         fontSize: 15,
// //                         decoration: TextDecoration.none,
// //                       ),
// //                     ),
// //                   ],
// //                 ),
// //               ],
// //             ),
// //           ),
// //         ],
// //       ),
// //     ),
// //   );
// // }
// // if (_frameno == 4) {
// //   return Padding(
// //     padding: const EdgeInsets.all(8.0),
// //     child: Container(
// //       height: 100,
// //       child: Row(
// //         children: [
// //           SizedBox(
// //             child: Stack(
// //               children: [
// //                 Container(
// //                   height: 80,
// //                   width: 70,
// //                   decoration: const BoxDecoration(
// //                     borderRadius: BorderRadius.only(
// //                         bottomLeft: Radius.circular(35.0),
// //                         bottomRight: Radius.circular(35.0)),
// //                     color: Color(0Xffdddddd),
// //                   ),
// //                 ),
// //                 Positioned(
// //                   top: 15,
// //                   left: 5,
// //                   child: CircleAvatar(
// //                     radius: 30,
// //                     backgroundImage: CachedNetworkImageProvider(
// //                       widget.profilevalue == null
// //                           ? url
// //                           : "$weburl/${widget.profilevalue["profile_img"]}",
// //                     ),
// //                   ),
// //                 ),
// //               ],
// //             ),
// //           ),
// //           const SizedBox(
// //             width: 5,
// //           ),
// //           SizedBox(
// //             width: MediaQuery.of(context).size.width * 0.7,
// //             child: Column(
// //               children: [
// //                 Text(
// //                   widget.profilevalue == null
// //                       ? 'Mauli computers & multi Service'
// //                       : widget.profilevalue['name'],
// //                   style: TextStyle(
// //                       color: pickedcolor,
// //                       fontSize: 15,
// //                       decoration: TextDecoration.none,
// //                       fontWeight: FontWeight.bold),
// //                 ),
// //                 SizedBox(
// //                   child: Row(
// //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                     children: [
// //                       Text(
// //                         widget.profilevalue == null
// //                             ? 'Clickonadd@gmail.com'
// //                             : widget.profilevalue['email'],
// //                         style: TextStyle(
// //                             color: pickedcolor,
// //                             decoration: TextDecoration.none,
// //                             fontSize: 15),
// //                       ),
// //                       Text(
// //                         widget.profilevalue == null
// //                             ? '1234567890'
// //                             : widget.profilevalue['mobileno'],
// //                         style: TextStyle(
// //                           color: pickedcolor,
// //                           decoration: TextDecoration.none,
// //                           fontSize: 15,
// //                         ),
// //                       ),
// //                     ],
// //                   ),
// //                 ),
// //                 SizedBox(
// //                   child: Row(
// //                     children: [
// //                       Icon(Icons.location_on),
// //                       Text(
// //                         'Near SBI Bank,Keshav Nagar',
// //                         style: TextStyle(
// //                           color: pickedcolor,
// //                           fontSize: 15,
// //                           decoration: TextDecoration.none,
// //                         ),
// //                       ),
// //                     ],
// //                   ),
// //                 ),
// //               ],
// //             ),
// //           ),
// //         ],
// //       ),
// //     ),
// //   );
// // }
// // if (_frameno == 5) {
// //   return Container(
// //     height: MediaQuery.of(context).size.height / 7,
// //     alignment: Alignment.bottomCenter,
// //     child: Stack(
// //       alignment: Alignment.bottomCenter,
// //       children: [
// //         ClipPath(
// //           clipper: MyWaveClipper5(),
// //           child: Container(
// //             color: Colors.yellow,
// //             height: 100,
// //             width: double.infinity,
// //           ),
// //         ),
// //         Container(
// //           margin: const EdgeInsets.only(bottom: 40),
// //           child: CircleAvatar(
// //             radius: 50,
// //             backgroundColor: const Color.fromARGB(255, 27, 17, 91),
// //             child: CircleAvatar(
// //               radius: 35,
// //               backgroundImage: CachedNetworkImageProvider(
// //                 widget.profilevalue == null
// //                     ? url
// //                     : "$weburl/${widget.profilevalue["profile_img"]}",
// //               ),
// //             ),
// //           ),
// //         )
// //       ],
// //     ),
// //   );
// // }
// // if (_frameno == 6) {
// //   return Container(
// //     height: MediaQuery.of(context).size.height / 7,
// //     alignment: Alignment.bottomCenter,
// //     child: Stack(
// //       alignment: Alignment.bottomCenter,
// //       children: [
// //         Container(
// //           color: Colors.orange,
// //           height: 90,
// //         ),
// //         ClipPath(
// //           clipper: MyWaveClipper6(),
// //           child: Container(
// //             color: Colors.yellow,
// //             height: 100,
// //             width: double.infinity,
// //           ),
// //         ),
// //         Container(
// //           margin: const EdgeInsets.only(bottom: 40),
// //           child: CircleAvatar(
// //             radius: 50,
// //             backgroundColor: const Color.fromARGB(255, 27, 17, 91),
// //             child: CircleAvatar(
// //               radius: 35,
// //               backgroundImage: CachedNetworkImageProvider(
// //                 widget.profilevalue == null
// //                     ? url
// //                     : "$weburl/${widget.profilevalue["profile_img"]}",
// //               ),
// //             ),
// //           ),
// //         )
// //       ],
// //     ),
// //   );
// // }
// // if (_frameno == 7) {
// //   return Container(
// //       alignment: Alignment.bottomCenter,
// //       height: MediaQuery.of(context).size.height / 5,
// //       child: Column(
// //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //         crossAxisAlignment: CrossAxisAlignment.center,
// //         children: [
// //           Container(
// //             alignment: Alignment.bottomCenter,
// //             child: Stack(
// //               alignment: Alignment.bottomLeft,
// //               children: [
// //                 ClipPath(
// //                   clipper: MyWaveClipper7(),
// //                   child: Container(
// //                     margin: const EdgeInsets.only(bottom: 20),
// //                     color: Colors.orange,
// //                     height: 100,
// //                     width: double.infinity,
// //                   ),
// //                 ),
// //                 ClipPath(
// //                   clipper: MyWaveClipper7(),
// //                   child: Container(
// //                     color: Colors.white,
// //                     height: 100,
// //                     width: double.infinity,
// //                   ),
// //                 ),
// //                 Container(
// //                   margin: const EdgeInsets.only(left: 15, bottom: 40),
// //                   child: CircleAvatar(
// //                     radius: 50,
// //                     backgroundColor: const Color.fromARGB(255, 27, 17, 91),
// //                     child: CircleAvatar(
// //                       radius: 40,
// //                       backgroundImage: CachedNetworkImageProvider(widget.getimage),
// //                     ),
// //                   ),
// //                 )
// //               ],
// //             ),
// //           )
// //         ],
// //       ));
// // }
