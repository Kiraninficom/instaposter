import 'dart:math';

import 'package:click/pages/getapi.dart';
import 'package:click/pages/notification_subject.dart';
import 'package:click/utils/constants.dart';
import 'package:click/utils/navigation.dart';
import 'package:click/utils/styles.dart';
import 'package:flutter/material.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  bool alldataget = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getdata();
  }

  getdata() async {
    var data = await SentApi().getnotificationdata();
    setState(() {
      notificationlist = data;
      alldataget = true;
    });
  }

  Color getRandomColor() {
    Random random = Random();
    int red = random.nextInt(256);
    int green = random.nextInt(256);
    int blue = random.nextInt(256);
    return Color.fromRGBO(red, green, blue, 1.0);
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.width / 3.8;
    var width = MediaQuery.of(context).size.width * 0.93;
    //print(notificationlist);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: primaryColor,
          title: Text("Notification"),
        ),
        body: notificationlist.isEmpty
            ? alldataget == true
                ? Text("No Notification")
                : Center(
                    child: CircularProgressIndicator(),
                  )
            : ListView.builder(
                itemCount: notificationlist.length,
                itemBuilder: (context, index) {
                  var date =
                      DateTime.parse(notificationlist[index]['created_on']);
                  return InkWell(
                    onTap: () {
                      toScreen(
                          context,
                          NotificationSubjectPage(
                            subject: notificationlist[index]['message'],
                            title: notificationlist[index]['title'],
                          ));
                    },
                    child: Card(
                      elevation: 2,
                      child: IntrinsicHeight(
                        child: Row(
                          children: [
                            Expanded(
                              flex: 3,
                              child: Row(
                                children: [
                                  Container(
                                    width: width / 50,
                                    // height: height,
                                    decoration: BoxDecoration(
                                        color: getRandomColor(),
                                        borderRadius: const BorderRadius.only(
                                            topRight: Radius.circular(5),
                                            bottomRight: Radius.circular(5))),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 8.0, bottom: 8.0, left: 8.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        CircleAvatar(
                                          child: Text("${index + 1}"),
                                        ),
                                        h(5),
                                        Column(
                                          children: [
                                            Text(
                                              "${date.year}-${date.month}-${date.day}",
                                              style: TextStyle(fontSize: 10),
                                            ),
                                            Text(
                                              "${date.hour}:${date.minute}",
                                              style: TextStyle(fontSize: 20),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 8.0, bottom: 8.0),
                              child: VerticalDivider(
                                color: greyshade400,
                                thickness: 2,
                              ),
                            ),
                            Expanded(
                              flex: 9,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 8.0, bottom: 8.0, right: 8.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      notificationlist[index]['title'],
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: "Poppins"),
                                    ),
                                    h(10),
                                    Text(notificationlist[index]['subject']),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
