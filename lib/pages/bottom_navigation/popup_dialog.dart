import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:click/utils/constants.dart';
import 'package:click/utils/navigation.dart';
import 'package:click/utils/styles.dart';
import 'package:click/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';

class PopupPage extends StatefulWidget {
  List value;
  PopupPage({super.key, required this.value});

  @override
  State<PopupPage> createState() => _PopupPageState();
}

class _PopupPageState extends State<PopupPage> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      clipBehavior: Clip.hardEdge,
      child: CarouselSlider(
        items: List.generate(widget.value.length, (index) {
          String imageurl = "$weburl/${widget.value[index]['image']}";
          String link = "${widget.value[index]['link']}";
          return Stack(
            alignment: Alignment.center,
            fit: StackFit.expand,
            children: [
              CachedNetworkImage(
                imageUrl: imageurl,
                fit: BoxFit.fill,
                errorWidget: (context, url, error) {
                  return Icon(Icons.error);
                },
                progressIndicatorBuilder: (context, url, progress) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
              Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                      onTap: () {
                        backscreen(context);
                      },
                      child: Icon(
                        Icons.close,
                        color: blackcolor,
                      )),
                ),
              ),
              link == ""
                  ? SizedBox.shrink()
                  : Positioned(
                      bottom: 10,
                      child: InkWell(
                        onTap: () {
                          launchUrl(Uri.parse(link),
                              mode: LaunchMode.externalApplication);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: primaryColor,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Visit Page',
                              style: TextStyle(color: whitecolor),
                            ),
                          ),
                        ),
                      ),
                    )
            ],
          );
        }),
        options: CarouselOptions(
          aspectRatio: .6,
          viewportFraction: 1,
          autoPlay: false,
          enlargeCenterPage: true,
        ),
      ),
    );
  }
}
