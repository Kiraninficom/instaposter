// ignore_for_file: prefer_typing_uninitialized_variables, must_be_immutable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:click/pages/bottom_navigation/popup_dialog.dart';
import 'package:click/pages/bottom_navigation/subcategory_page.dart';
import 'package:click/pages/poster_image.dart';
import 'package:click/utils/constants.dart';
import 'package:click/utils/navigation.dart';
import 'package:click/utils/styles.dart';
import 'package:click/widgets/category.dart';
import 'package:click/widgets/popupconstant.dart';
import 'package:flutter/material.dart';

class Showallcategory extends StatefulWidget {
  var value;
  var subvalue;
  var subimage;
  var cat;
  bool? activewatermark;
  bool? greeting;
  var popupvalue;
  Showallcategory(
      {Key? key,
      this.value,
      this.popupvalue,
      this.activewatermark,
      this.greeting,
      this.cat,
      this.subimage,
      this.subvalue})
      : super(key: key);

  @override
  State<Showallcategory> createState() => _ShowallcategoryState();
}

class _ShowallcategoryState extends State<Showallcategory> {
  @override
  void initState() {
    super.initState();
    getpopupvalues();
  }

  getpopupvalues() {
    var data = popuplist;
    List newlist = [];
    if (data.isNotEmpty) {
      for (var id in data) {
        if (id['service'] == '${widget.popupvalue}service') {
          setState(() {
            newlist.add(id);
          });
        }
      }
      if (newlist.isNotEmpty) {
        if (widget.popupvalue == 'job' && jobservicepopup == false) {
          d(newlist);
          setState(() {
            jobservicepopup = true;
          });
        }
        if (widget.popupvalue == 'csc' && cscservicepopup == false) {
          d(newlist);
          setState(() {
            cscservicepopup = true;
          });
        }
        if (widget.popupvalue == 'scheme' && schemeservicepopup == false) {
          d(newlist);
          setState(() {
            schemeservicepopup = true;
          });
        }
        if (widget.popupvalue == 'business' && businessservicepopup == false) {
          d(newlist);
          setState(() {
            businessservicepopup = true;
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text(widget.cat),
      ),
      body: GridView.builder(
        shrinkWrap: true,
        physics: const ScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, mainAxisSpacing: 0, crossAxisSpacing: 0),
        itemCount: widget.value.length,
        itemBuilder: (BuildContext context, int index) {
          if (widget.value[index]['category_image'] == "") {
            return Category(title: 'now value', imagePath: url);
          } else {
            return InkWell(
              onTap: () {
                if (widget.popupvalue == 'csc') {
                  toScreen(
                      context,
                      Posterimages(
                        activewatermark: widget.activewatermark,
                        enablegreeting: widget.greeting,
                        popupvalue: "csc",
                        id: widget.value[index]['id'],
                        subimages: widget.subimage,
                        subcat: widget.subvalue,
                      ));
                } else {
                  toScreen(
                      context,
                      Subcategory(
                        value: widget.value[index]['id'],
                        catname: widget.value[index]['category_name'],
                        subcategory: widget.subvalue,
                        subcategoryimage: widget.subimage,
                      ));
                }
              },
              child: widget.popupvalue == 'csc'
                  ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CategoryGrid(
                          imagePath:
                              '$weburl/${widget.value[index]['category_image']}'),
                    )
                  : Stack(
                      alignment: Alignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(20),
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                image: DecorationImage(
                                    image: CachedNetworkImageProvider(
                                        '$weburl/${widget.value[index]['category_image']}'),
                                    fit: BoxFit.fill)),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          child: Text(
                            "${widget.value[index]['category_name'] ?? widget.value[index]['categoryname']}",
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        )
                      ],
                    ),
            );
          }
        },
      ),
    );
  }
}
