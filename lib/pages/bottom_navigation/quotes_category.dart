import 'package:cached_network_image/cached_network_image.dart';
import 'package:click/pages/poster_image.dart';
import 'package:click/utils/constants.dart';
import 'package:click/utils/navigation.dart';
import 'package:click/utils/styles.dart';
import 'package:click/widgets/category.dart';
import 'package:flutter/material.dart';

class Quotescategory extends StatefulWidget {
  var value;
  var subvalue;
  var cat;
  Quotescategory({Key? key, this.value, this.cat, this.subvalue})
      : super(key: key);

  @override
  State<Quotescategory> createState() => _QuotescategoryState();
}

class _QuotescategoryState extends State<Quotescategory> {
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
            crossAxisCount: 2, mainAxisSpacing: 0, crossAxisSpacing: 0),
        itemCount: widget.value.length,
        itemBuilder: (BuildContext context, int index) {
          if (widget.value[index]['image'] == "") {
            return Category(title: 'now value', imagePath: url);
          } else {
            return InkWell(
              onTap: () {
                List subvalue = [];
                for (var id in quotesposterimages) {
                  subvalue.add({
                    "subcategory_image": id['image'],
                    "service": id['category'],
                    'language': id['language'] ?? 'marathi',
                    'rate': id['rate'],
                  });
                }
                toScreen(
                    context,
                    Posterimages(
                      popupvalue: 'quotes',
                      id: quotescategory[index]['id'],
                      subcat: null,
                      subimages: subvalue,
                    ));
              },
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          image: DecorationImage(
                              image: CachedNetworkImageProvider(
                                  '$weburl/${widget.value[index]['image']}'),
                              fit: BoxFit.fill)),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    child: Text(
                      "${widget.value[index]['category']}",
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
