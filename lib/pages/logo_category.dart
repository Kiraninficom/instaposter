import 'dart:convert';

import 'package:click/Pages/authcredential.dart';
import 'package:click/pages/bottom_navigation/showall_category.dart';
import 'package:click/pages/bottom_navigation/showall_option.dart';
import 'package:click/pages/bottom_navigation/subcategory_page.dart';
import 'package:click/pages/getapi.dart';
import 'package:click/pages/todaysposter.dart';
import 'package:click/utils/constants.dart';
import 'package:click/utils/navigation.dart';
import 'package:click/utils/styles.dart';
import 'package:click/widgets/category.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Logocategory extends StatefulWidget {
  const Logocategory({super.key});

  @override
  State<Logocategory> createState() => _LogocategoryState();
}

class _LogocategoryState extends State<Logocategory> {
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

  getlogodata() async {
    var logo = await await SentApi().getlogoservices();
    setState(() {
      designlogo = logo;
    });
  }

  getfestival() async {
    var festival = await await SentApi().getfestivalposter();
    setState(() {
      festivalposter = festival;
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
    getlogodata();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: const ScrollPhysics(),
      children: [
        header('Today\'s logo', onpress: () {
          toScreen(
              context,
              Showalloption(
                data: designlogo,
                cat: 'Today Logo',
              ));
        }, catlength: 1),
        designlogo.isEmpty
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
                itemCount: designlogo.length > 3 ? 3 : designlogo.length,
                itemBuilder: (BuildContext context, int index) {
                  if (designlogo[index]['logo'] == "") {
                    return Category(title: 'now value', imagePath: url);
                  } else {
                    return InkWell(
                      onTap: () {
                        toScreen(
                            context,
                            Showalloption(
                              data: designlogo,
                              cat: 'Today Logo',
                            ));
                      },
                      child: Category(
                        title: "${designlogo[index]['logonu']}",
                        imagePath: '$weburl/${designlogo[index]['logo']}',
                      ),
                    );
                  }
                },
              ),
        header('Tommorow\'s Festival', onpress: () {}, catlength: 1),
        festivalposter.isEmpty
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
                    festivalposter.length > 3 ? 3 : festivalposter.length,
                itemBuilder: (BuildContext context, int index) {
                  if (festivalposter[index]['subucategory_image'] == "") {
                    return Category(title: 'now value', imagePath: url);
                  } else {
                    return InkWell(
                      onTap: () {
                        toScreen(
                            context,
                            TodaysPoster(
                              popupvalue: 'festival',
                              subimages: festivalposter,
                              tommorow: true,
                            ));
                      },
                      child: Category(
                        title: "${festivalposter[index]['poster_name']}",
                        imagePath:
                            '$weburl/${festivalposter[index]['subcategory_image']}',
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
