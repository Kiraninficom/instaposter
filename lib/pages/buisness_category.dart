import 'dart:convert';

import 'package:click/Pages/authcredential.dart';
import 'package:click/pages/bottom_navigation/showall_category.dart';
import 'package:click/pages/bottom_navigation/subcategory_page.dart';
import 'package:click/pages/getapi.dart';
import 'package:click/pages/todaysposter.dart';
import 'package:click/utils/constants.dart';
import 'package:click/utils/navigation.dart';
import 'package:click/utils/styles.dart';
import 'package:click/widgets/category.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Buisnesscategory extends StatefulWidget {
  const Buisnesscategory({Key? key}) : super(key: key);

  @override
  State<Buisnesscategory> createState() => _BuisnesscategoryState();
}

class _BuisnesscategoryState extends State<Buisnesscategory> {
  Widget header(String title, {var onpress, catlength}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Container(
        color: primaryColor,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                ),
              ),
              catlength > 4 ? const Spacer() : const SizedBox.shrink(),
              catlength > 4
                  ? TextButton(
                      onPressed: onpress,
                      child: const Text(
                        'Show All',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                        ),
                      ),
                    )
                  : const SizedBox.shrink(),
            ],
          ),
        ),
      ),
    );
  }

  getbuisnessdata() async {
    var buisness = await await SentApi().getbuisnessbasic();
    setState(() {
      buisnesscategory = buisness;
    });
  }

  getbuisnesssubdata() async {
    var buisnessub = await await SentApi().getbuisnesssubservices();
    setState(() {
      buisnesssubservice = buisnessub;
    });
  }

  getbuisnessimage() async {
    var buisnessimag = await await SentApi().getbuisnessimage();
    setState(() {
      buisnessimage = buisnessimag;
    });
  }

  getfestival() async {
    var festival = await await SentApi().getfestivalposter();
    setState(() {
      festivalposter = festival;
    });
    getseprate();
  }

  getseprate() {
    todaysbuisness.clear();
    tommorowfestival.clear();
    for (int i = 0; i < festivalposter.length; i++) {
      DateTime date1 = todaydate;
      DateTime date2 = DateTime.parse(festivalposter[i]['date']);
      Duration difference = date2.difference(date1);
      if (difference.inDays > 0) {
        setState(() {
          tommorowfestival.add(festivalposter[i]);
        });
      }
    }
    for (int i = 0; i < buisnessimage.length; i++) {
      DateTime date1 = todaydate;
      DateTime date2 = DateTime.parse(buisnessimage[i]['created_at']);
      Duration difference = date2.difference(date1);
      if (difference.inDays == 0) {
        setState(() {
          todaysbuisness.add(buisnessimage[i]);
        });
      }
    }
    setState(() {
      alldataget = true;
    });
  }

  @override
  void initState() {
    super.initState();
    getbuisnessdata();
    getbuisnessimage();
    getbuisnesssubdata();
    getfestival();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: const ScrollPhysics(),
      children: [
        header('Today\'s buisness', onpress: () {}, catlength: 1),
        todaysfestival.isEmpty
            ? alldataget
                ? Center(child: Text("No Values"))
                : Center(
                    child: Image.asset(
                    "assets/loading.gif",
                    height: 100,
                  ))
            : GridView.builder(
                shrinkWrap: true,
                physics: const ScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                ),
                itemCount:
                    todaysfestival.length > 3 ? 3 : todaysfestival.length,
                itemBuilder: (BuildContext context, int index) {
                  if (todaysbuisness[index]['subcategory_image'] == "") {
                    return Category(title: 'now value', imagePath: url);
                  } else {
                    return InkWell(
                      onTap: () {
                        toScreen(
                            context,
                            TodaysPoster(
                              popupvalue: 'buisness',
                              subimages: todaysbuisness,
                              tommorow: false,
                            ));
                      },
                      child: Category(
                        title: "${todaysbuisness[index]['poster_name']}",
                        imagePath:
                            '$weburl/${todaysbuisness[index]['subcategory_image']}',
                      ),
                    );
                  }
                },
              ),
        header('Tommorow\'s Festival', onpress: () {}, catlength: 1),
        tommorowfestival.isEmpty
            ? alldataget
                ? Center(child: Text("No Values"))
                : Center(
                    child: Image.asset(
                    "assets/loading.gif",
                    height: 100,
                  ))
            : GridView.builder(
                shrinkWrap: true,
                physics: const ScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                ),
                itemCount:
                    tommorowfestival.length > 3 ? 3 : tommorowfestival.length,
                itemBuilder: (BuildContext context, int index) {
                  if (tommorowfestival[index]['category_image'] == "") {
                    return Category(title: 'now value', imagePath: url);
                  } else {
                    return InkWell(
                      onTap: () {
                        toScreen(
                            context,
                            TodaysPoster(
                              popupvalue: 'festival',
                              subimages: tommorowfestival,
                              tommorow: true,
                            ));
                      },
                      child: Category(
                        title: "${tommorowfestival[index]['poster_name']}",
                        imagePath:
                            '$weburl/${tommorowfestival[index]['category_image']}',
                      ),
                    );
                  }
                },
              ),
        header('Quotes/ status', onpress: () {}, catlength: 1),
        GridView.builder(
          shrinkWrap: true,
          physics: const ScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
          ),
          itemCount: 3,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                backgroundColor: appBarColor,
              ),
            );
          },
        ),
        header('Other Buisness Category', onpress: () {
          toScreen(
              context,
              Showallcategory(
                value: buisnesscategory,
                subimage: buisnesssubservice,
                subvalue: buisnessimage,
                cat: 'Other Buisness Category',
              ));
        }, catlength: buisnesscategory.isEmpty ? 1 : buisnesscategory.length),
        buisnesscategory.isEmpty
            ? alldataget
                ? Center(child: Text("No Values"))
                : Center(
                    child: Image.asset(
                    "assets/loading.gif",
                    height: 100,
                  ))
            : GridView.builder(
                shrinkWrap: true,
                physics: const ScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3, mainAxisSpacing: 0, crossAxisSpacing: 0),
                itemCount:
                    buisnesscategory.length > 3 ? 3 : buisnesscategory.length,
                itemBuilder: (BuildContext context, int index) {
                  if (buisnesscategory[index]['category_image'] == "") {
                    return Category(title: 'now value', imagePath: url);
                  } else {
                    return InkWell(
                      onTap: () {
                        toScreen(
                            context,
                            Subcategory(
                              value: buisnesscategory[index]['id'],
                              catname: buisnesscategory[index]['category_name'],
                              subcategory: buisnesssubservice,
                              subcategoryimage: buisnessimage,
                            ));
                      },
                      child: Category(
                        title: "${buisnesscategory[index]['category_name']}",
                        imagePath:
                            '$weburl/${buisnesscategory[index]['category_image']}',
                      ),
                    );
                  }
                },
              ),
      ],
    );
  }
}
