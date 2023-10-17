import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:click/pages/bottom_navigation/popup_dialog.dart';
import 'package:click/pages/drawer/profile/add_profile.dart';
import 'package:click/pages/drawer/profile/my_profile.dart';
import 'package:click/pages/getapi.dart';
import 'package:click/poster_page/poster_page.dart';
import 'package:click/utils/constants.dart';
import 'package:click/utils/navigation.dart';
import 'package:click/utils/styles.dart';
import 'package:click/widgets/popupconstant.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:math' as math;

class Posterimages extends StatefulWidget {
  var subimages;
  String? popupvalue;
  var id;
  var subcat;
  bool? activewatermark;
  bool? enablegreeting;
  Posterimages(
      {Key? key,
      this.id,
      this.enablegreeting,
      this.activewatermark,
      this.popupvalue,
      this.subimages,
      this.subcat})
      : super(key: key);

  @override
  State<Posterimages> createState() => _PosterimagesState();
}

class _PosterimagesState extends State<Posterimages> {
  int selected = 0;
  var subcategory = [];
  var subimagesvalue = [];
  var languagelist = ["all", "marathi", "english", "hindi"];
  var selectedlanguage = 0;

  Future getdata() async {
    final prefs = await SharedPreferences.getInstance()
        .then((value) => json.decode("${value.getString("userdata")}"));

    setState(() {
      userdata = prefs;
    });
  }

  getsubcategory() {
    subcategory.clear();
    setState(() {
      subcategory.add("See all");
    });
    if (widget.subcat != null) {
      for (int i = 0; i < widget.subcat.length; i++) {
        if (widget.subcat[i]['service'] == widget.id) {
          setState(() {
            subcategory.add(widget.subcat[i]);
          });
        }
      }
    }
    getposter();
  }

  getpopupvalues() {
    var data = popuplist;
    List newlist = [];
    if (data.isNotEmpty) {
      for (var id in data) {
        if (id['service'] == '${widget.popupvalue}poster') {
          setState(() {
            newlist.add(id);
          });
        }
      }
      if (newlist.isNotEmpty) {
        if (widget.popupvalue == 'job' && jobposterpopup == false) {
          d(newlist);
          setState(() {
            jobposterpopup = true;
          });
        }
        if (widget.popupvalue == 'csc' && cscposterpopup == false) {
          d(newlist);
          setState(() {
            cscposterpopup = true;
          });
        }
        if (widget.popupvalue == 'scheme' && schemeposterpopup == false) {
          d(newlist);
          setState(() {
            schemeposterpopup = true;
          });
        }
        if (widget.popupvalue == 'business' && businessposterpopup == false) {
          d(newlist);
          setState(() {
            businessposterpopup = true;
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

  getposter() {
    subimagesvalue.clear();
    for (int i = 0; i < widget.subimages.length; i++) {
      if ("${widget.subimages[i]['service']}" == "${widget.id}") {
        if (widget.subimages[i]['language'] == languagelist[selectedlanguage]) {
          if (selected != 0 &&
              widget.subimages[i]['subcategory_id'] ==
                  subcategory[selected]['id']) {
            setState(() {
              subimagesvalue.add(widget.subimages[i]);
            });
          }
          if (selected == 0) {
            setState(() {
              subimagesvalue.add(widget.subimages[i]);
            });
          }
        } else if (languagelist[selectedlanguage] == "all") {
          if (selected != 0 &&
              widget.subimages[i]['subcategory_id'] ==
                  subcategory[selected]['id']) {
            setState(() {
              subimagesvalue.add(widget.subimages[i]);
            });
          }
          if (selected == 0) {
            setState(() {
              subimagesvalue.add(widget.subimages[i]);
            });
          }
        }
      }
    }
  }

  getcscsubdata() async {
    var cscsubservice = await SentApi().getcscsubservices();
    if (widget.popupvalue == "csc" && widget.enablegreeting == null) {
      setState(() {
        widget.subcat = cscsubservice;
      });
    }
  }

  getcscimage() async {
    var cscimage = await SentApi().getcscimage();
    if (widget.popupvalue == "csc" && widget.enablegreeting == null) {
      setState(() {
        widget.subimages = cscimage;
      });
    }
    getvalue();
  }

  getvalue() async {
    await getsubcategory();
    await getdata();
    getpopupvalues();
  }

  @override
  void initState() {
    super.initState();
    getcscimage();
    getcscsubdata();
    getvalue();
  }

  @override
  Widget build(BuildContext context) {
    print(token);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: const Text("Posters"),
        actions: [
          PopupMenuButton(
            initialValue: selectedlanguage,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Text("${languagelist[selectedlanguage]}".toUpperCase()),
                  w(5),
                  Icon(Icons.language)
                ],
              ),
            ),
            onSelected: (value) {
              setState(() {
                selectedlanguage = value;
              });
              getposter();
            },
            itemBuilder: (context) {
              return List.generate(
                  languagelist.length,
                  (index) => PopupMenuItem(
                      value: index,
                      child: Text(languagelist[index].toUpperCase())));
            },
          ),
        ],
      ),
      body: ListView(
        children: [
          subcategory.length == 1 && subcategory[0] == "See all"
              ? SizedBox.shrink()
              : SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(
                        subcategory.length,
                        (index) => Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    selected = index;
                                  });
                                  getposter();
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: selected == index
                                          ? primaryColor
                                          : Color(0xfff5f5f5),
                                      borderRadius: BorderRadius.circular(20),
                                      border:
                                          Border.all(color: Color(0xffe2e2e2))),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10.0,
                                        right: 10.0,
                                        top: 5,
                                        bottom: 5),
                                    child: Text(
                                      index == 0
                                          ? subcategory[index]
                                          : subcategory[index]
                                              ['subcategory_name'],
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: selected == index
                                              ? whitecolor
                                              : null),
                                    ),
                                  ),
                                ),
                              ),
                            )),
                  ),
                ),
          subcategory.length == 1 && subcategory[0] == "See all"
              ? SizedBox.shrink()
              : Divider(
                  color: blackcolor,
                ),
          subimagesvalue.isEmpty
              ? const Center(
                  child: Text('No Poster Found'),
                )
              : GridView.builder(
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                  ),
                  itemCount: subimagesvalue.length,
                  itemBuilder: (BuildContext context, int i) {
                    var index = subimagesvalue.length - (i + 1);
                    print(subimagesvalue.length);
                    var image =
                        '$weburl/${subimagesvalue[index]['subcategory_image']}';
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                          onTap: () {
                            pagescondition(
                                subimagesvalue, index, subimagesvalue[index]);
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
                                        topLeft: Radius.circular(20),
                                        topRight: Radius.circular(20),
                                        bottomLeft: Radius.circular(20),
                                        bottomRight: Radius.circular(20),
                                      ),
                                      image: DecorationImage(
                                          image:
                                              CachedNetworkImageProvider(image),
                                          fit: BoxFit.fill),
                                    ))),
                            subscriptiondetail != null &&
                                    subscriptiondetail['plan_type'] == '1'
                                ? SizedBox.shrink()
                                : Positioned(
                                    top: 0,
                                    left: 0,
                                    child: Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.2,
                                        height:
                                            MediaQuery.of(context).size.width *
                                                0.2,
                                        decoration: const BoxDecoration(
                                          image: DecorationImage(
                                              image:
                                                  AssetImage('assets/tag.png'),
                                              fit: BoxFit.fitWidth),
                                        ))),
                            subscriptiondetail != null &&
                                    subscriptiondetail['plan_type'] == '1'
                                ? SizedBox.shrink()
                                : Positioned(
                                    top: MediaQuery.of(context).size.width *
                                        0.05,
                                    left: MediaQuery.of(context).size.width *
                                        0.01,
                                    child: Transform.rotate(
                                      angle:
                                          -45.99999828106503 * (math.pi / 180),
                                      child: Text(
                                        double.parse(
                                                    '${subimagesvalue[index]['rate']}') ==
                                                0.0
                                            ? 'Free'
                                            : '${subimagesvalue[index]['rate']}',
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                            color: Color.fromRGBO(
                                                255, 255, 255, 1),
                                            fontFamily: 'Inter',
                                            fontSize: 18,
                                            fontWeight: FontWeight.normal,
                                            height: 1),
                                      ),
                                    )),
                          ]))),
                    );
                  },
                ),
        ],
      ),
    );
  }

  pagescondition(var item, int index, var data) {
    if (subscriptiondetail != null) {
      if (int.parse(subscriptiondetail['days_left']) >= 0) {
        selectprofile(item, index, data);
      } else if (double.parse(item[index]['rate']) == 0.0) {
        List newitem = [];
        for (var i in item) {
          if (double.parse(i['rate']) == 0.0) {
            setState(() {
              newitem.add(i);
            });
          }
        }
        selectprofile(newitem, 0, data);
      } else {
        nosubscriptiondialog(context);
      }
    } else if (subscriptiondetail == null) {
      if ((DateTime.now()
              .difference(DateTime.parse(userdata['created_at']))
              .inDays) <
          7) {
        selectprofile(item, index, data);
      } else if (double.parse(item[index]['rate']) == 0.0) {
        List newitem = [];
        for (var i in item) {
          if (double.parse(i['rate']) == 0.0) {
            setState(() {
              newitem.add(i);
            });
          }
        }

        selectprofile(newitem, 0, data);
      } else {
        nosubscriptiondialog(context);
      }
    } else {
      nosubscriptiondialog(context);
    }
  }

  selectprofile(var item, int index, var data) {
    print("userdata ${userdata['address']}");
    return showModalBottomSheet(
      backgroundColor: Colors.blueGrey[50],
      context: context,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Select Profile',
                      style: TextStyle(color: blackcolor, fontSize: 20),
                    ),
                    InkWell(
                        onTap: () {
                          backscreen(context);
                        },
                        child: Icon(
                          Icons.close,
                          color: blackcolor,
                        ))
                  ],
                ),
              ),
              userdata['address'] == null ||
                      userdata['address'] == "null" ||
                      userdata['address'] == ''
                  ? InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return MyProfile();
                          },
                        )).then((value) {
                          backscreen(context);
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: whitecolor,
                            boxShadow: [BoxShadow(blurRadius: 2)],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListTile(
                              title: Text(
                                'Add Profile Address',
                                style: TextStyle(
                                  color: primaryColor,
                                  fontSize: 18,
                                ),
                              ),
                              leading: Icon(Icons.add),
                            ),
                          ),
                        ),
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () {
                          toScreen(
                              context,
                              PosterPage(
                                normalprofile: true,
                                activewatermark: widget.activewatermark,
                                itsgreeting: widget.enablegreeting,
                                activecsc: true,
                                getimage: item,
                                profilevalue: userdata,
                                selected: index,
                                data: data,
                              ));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: whitecolor,
                            boxShadow: [BoxShadow(blurRadius: 2)],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListTile(
                              leading: CircleAvatar(
                                radius: 30,
                                backgroundImage: userdata["profile_img"] == null
                                    ? CachedNetworkImageProvider(weburl)
                                    : CachedNetworkImageProvider(
                                        "$weburl/${userdata["profile_img"]}"),
                              ),
                              title: Text(
                                '${userdata["name"]}',
                                style: TextStyle(
                                  color: primaryColor,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
              festivalprofilevalue.isNotEmpty
                  ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () {
                          toScreen(
                              context,
                              PosterPage(
                                activewatermark: widget.activewatermark,
                                itsgreeting: widget.enablegreeting,
                                activecsc: false,
                                getimage: item,
                                profilevalue: festivalprofilevalue[0],
                                selected: index,
                                data: data,
                              ));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: whitecolor,
                            boxShadow: [BoxShadow(blurRadius: 2)],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListTile(
                              leading: CircleAvatar(
                                radius: 30,
                                backgroundImage: CachedNetworkImageProvider(
                                    "$weburl/${festivalprofilevalue[0]['profile_img']}"),
                              ),
                              subtitle: Text('Festival Profile'),
                              title: Text(
                                '${festivalprofilevalue[0]['name']}',
                                style: TextStyle(
                                  color: primaryColor,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  : InkWell(
                      onTap: () {
                        toScreen(
                            context,
                            Addprofile(
                                csc: false, buisness: false, festival: true));
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: whitecolor,
                            boxShadow: [BoxShadow(blurRadius: 2)],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListTile(
                              title: Text(
                                'Add Festival Profile',
                                style: TextStyle(
                                  color: primaryColor,
                                  fontSize: 18,
                                ),
                              ),
                              leading: Icon(Icons.add),
                            ),
                          ),
                        ),
                      ),
                    ),
              cscvalue.isNotEmpty
                  ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () {
                          toScreen(
                              context,
                              PosterPage(
                                activewatermark: widget.activewatermark,
                                itsgreeting: widget.enablegreeting,
                                activecsc: true,
                                getimage: item,
                                selected: index,
                                profilevalue: cscvalue[0],
                                data: data,
                              ));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: whitecolor,
                            boxShadow: [BoxShadow(blurRadius: 2)],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListTile(
                              leading: CircleAvatar(
                                radius: 30,
                                backgroundImage: CachedNetworkImageProvider(
                                    "$weburl/${cscvalue[0]['profile_img']}"),
                              ),
                              subtitle: Text('Csc Profile'),
                              title: Text(
                                '${cscvalue[0]['name']}',
                                style: TextStyle(
                                  color: primaryColor,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  : InkWell(
                      onTap: () {
                        toScreen(
                            context,
                            Addprofile(
                                csc: true, buisness: false, festival: false));
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: whitecolor,
                            boxShadow: [BoxShadow(blurRadius: 2)],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListTile(
                              title: Text(
                                'Add Csc Profile',
                                style: TextStyle(
                                  color: primaryColor,
                                  fontSize: 18,
                                ),
                              ),
                              leading: Icon(Icons.add),
                            ),
                          ),
                        ),
                      ),
                    ),
            ],
          ),
        );
      },
    );
  }
}
