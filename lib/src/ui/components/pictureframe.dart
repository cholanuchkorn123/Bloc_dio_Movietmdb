import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../modal/movie.dart';

class Pictureframe extends StatelessWidget {
  Pictureframe(
      {required this.movie,
      required this.baseurl,
      this.radius = 10,
      this.width = 200,
      this.height = 250});

  final Movie movie;
  final String baseurl;
  final double radius;
  final double width;
  final double height;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(radius)),
      child: CachedNetworkImage(
        imageUrl: '$baseurl${movie.backdropPath}',
        placeholder: (context, url) => Platform.isAndroid
            ? CircularProgressIndicator()
            : CupertinoActivityIndicator(),
        height: height,
        width: width,
        fit: BoxFit.cover,
        errorWidget: (context, url, error) => Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/image/not.jpg'),
            ),
          ),
        ),
      ),
    );
  }
}
