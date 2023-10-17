// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:cached_network_image/cached_network_image.dart';
import 'package:click/pages/bottom_navigation/popup_dialog.dart';
import 'package:click/pages/poster_image.dart';
import 'package:click/pages/todaysposter.dart';
import 'package:click/utils/constants.dart';
import 'package:click/utils/navigation.dart';
import 'package:click/utils/styles.dart';
import 'package:click/widgets/category.dart';
import 'package:click/widgets/popupconstant.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Subcategory extends StatefulWidget {
  var value;
  String? popupvalue;
  var catname;
  var subcategory;
  var subcategoryimage;
  bool? frompage;
  Subcategory(
      {Key? key,
      this.popupvalue,
      this.value,
      this.catname,
      this.subcategory,
      this.subcategoryimage,
      this.frompage})
      : super(key: key);

  @override
  State<Subcategory> createState() => _SubcategoryState();
}

class _SubcategoryState extends State<Subcategory> {
  var subcategoryvalue = [];
  var subcategoryimage = [];

  getsubcategory() {
    for (int i = 0; i < widget.subcategory.length; i++) {
      if (widget.subcategory[i]['service'] == widget.value) {
        setState(() {
          subcategoryvalue.add(widget.subcategory[i]);
        });
      }
    }
    for (int i = 0; i < widget.subcategoryimage.length; i++) {
      if (widget.subcategoryimage[i]['service'] == widget.value) {
        setState(() {
          subcategoryimage.add(widget.subcategoryimage[i]);
        });
      }
    }
  }

  getpopupvalues() {
    var data = popuplist;
    List newlist = [];
    if (data.isNotEmpty) {
      for (var id in data) {
        if (id['service'] == '${widget.popupvalue}subservice') {
          setState(() {
            newlist.add(id);
          });
        }
      }
      if (newlist.isNotEmpty) {
        if (widget.popupvalue == 'job' && jobsubservicepopup == false) {
          d(newlist);
          setState(() {
            jobsubservicepopup = true;
          });
        }
        if (widget.popupvalue == 'csc' && cscsubservicepopup == false) {
          d(newlist);
          setState(() {
            cscsubservicepopup = true;
          });
        }
        if (widget.popupvalue == 'scheme' && schemesubservicespopup == false) {
          d(newlist);
          setState(() {
            schemesubservicespopup = true;
          });
        }
        if (widget.popupvalue == 'business' &&
            businesssubservicepopup == false) {
          d(newlist);
          setState(() {
            businesssubservicepopup = true;
          });
        }
      }
    }
  }

  d(var newlist) {
    showDialog(
      context: context,
      builder: (context) {
        return PopupPage(value: newlist);
      },
    );
  }

  @override
  void initState() {
    super.initState();
    getdata();
  }

  getdata() async {
    widget.subcategory == null ? null : await getsubcategory();
    getpopupvalues();
  }

  @override
  Widget build(BuildContext context) {
    //print(widget.subcategoryimage);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text(widget.catname),
      ),
      body: widget.subcategory == null
          ? const Center(
              child: Text("No Data"),
            )
          : subcategoryvalue.isEmpty
              ? const Center(
                  child: Text('No Data Found'),
                )
              : GridView.builder(
                  shrinkWrap: true,
                  physics: const ScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                  ),
                  itemCount: subcategoryvalue.length,
                  itemBuilder: (BuildContext context, int index) {
                    var item = subcategoryvalue[index]['subcategory_image'] !=
                            null
                        ? '$weburl/${subcategoryvalue[index]['subcategory_image']}'
                        : url;
                    return InkWell(
                      onTap: () {
                        if (kDebugMode) {
                          //print(subcategoryvalue[index]['id']);
                        }
                        var newlist = [];
                        for (var id in widget.subcategoryimage) {
                          if (id['subcategory_id'] ==
                              subcategoryvalue[index]['id']) {
                            newlist.add(id);
                          }
                        }
                        toScreen(
                            context,
                            widget.frompage == true
                                ? TodaysPoster(
                                    popupvalue: 'job',
                                    title: subcategoryvalue[index]
                                        ['subcategory_name'],
                                    index: 0,
                                    subimages: newlist,
                                  )
                                : Posterimages(
                                    popupvalue: widget.popupvalue,
                                    id: subcategoryvalue[index]['id'],
                                    subimages: subcategoryimage,
                                  ));
                      },
                      child:
                          // Stack(
                          //   children: [
                          Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              image: DecorationImage(
                                  image: CachedNetworkImageProvider(item),
                                  fit: BoxFit.fill)),
                        ),
                      ),
                      //   Positioned(
                      //     bottom: 0,
                      //     child: Text(
                      //       subcategoryvalue[index]['subcategory_name'] !=
                      //               null
                      //           ? "${subcategoryvalue[index]['subcategory_name']}"
                      //           : 'null value',
                      //       overflow: TextOverflow.ellipsis,
                      //       style: const TextStyle(
                      //         fontSize: 14,
                      //     ),
                      //   )
                      // ],
                      // ),
                    );
                  },
                ),
    );
  }
}
