// ignore_for_file: must_be_immutable, prefer_typing_uninitialized_variables

import 'package:cached_network_image/cached_network_image.dart';
import 'package:click/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Category extends StatelessWidget {
  final String title;
  final String imagePath;

  const Category({
    Key? key,
    required this.title,
    required this.imagePath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        h(10),
        CircleAvatar(
          radius: MediaQuery.of(context).size.width * .09,
          backgroundImage: CachedNetworkImageProvider(imagePath),
        ),
        h(15),
        Text(
          title,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontSize: 14,
          ),
        )
      ],
    );
  }
}

class Categorysquare extends StatelessWidget {
  final String title;
  final String imagePath;
  var height;
  var width;
  bool? assetsimagetrue;
  Categorysquare(
      {super.key,
      this.height,
      required this.title,
      required this.imagePath,
      this.width,
      this.assetsimagetrue});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        h(10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Container(
            height: height,
            width: width,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                image: DecorationImage(
                    image: assetsimagetrue == true
                        ? Image.asset(
                            imagePath,
                            fit: BoxFit.fill,
                          ).image
                        : CachedNetworkImageProvider(imagePath),
                    fit: BoxFit.fill)),
          ),
        ),
        Text(
          title,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontSize: 14,
          ),
        )
      ],
    );
  }
}

class CategoryGrid extends StatelessWidget {
  final String imagePath;
  bool? assetsimagetrue;
  CategoryGrid({
    super.key,
    this.assetsimagetrue,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    var imageissvg = (imagePath.split(".").last == 'svg');
    return Container(
      decoration: BoxDecoration(
          image: imageissvg == true
              ? null
              : DecorationImage(
                  image: assetsimagetrue == true
                      ? Image.asset(
                          imagePath,
                          fit: BoxFit.fill,
                        ).image
                      : CachedNetworkImageProvider(
                          imagePath,
                          errorListener: () {},
                        ),
                  fit: BoxFit.fill)),
      child: imageissvg == true ? SvgPicture.network(imagePath) : null,
    );
  }
}
