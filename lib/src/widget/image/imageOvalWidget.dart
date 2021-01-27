import 'package:flutter/material.dart';

class ImageOvalNetwork extends StatelessWidget {
  final String imageNetworkUrl;
  final Size sizeImage;

  const ImageOvalNetwork(
      {Key key, @required this.imageNetworkUrl, @required this.sizeImage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: sizeImage.width,
        height: sizeImage.width,
        decoration: new BoxDecoration(
            shape: BoxShape.circle,
            image: new DecorationImage(
                fit: BoxFit.fill, image: new NetworkImage(imageNetworkUrl))));
  }
}
