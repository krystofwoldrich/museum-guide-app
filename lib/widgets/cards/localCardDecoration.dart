import 'package:flutter/material.dart';

Decoration getDecoration(BuildContext context, {@required String fallbackAssetImageUrl, String imageUrl}) {
  ImageProvider<dynamic> backgroundImage = AssetImage(fallbackAssetImageUrl);
  if (imageUrl != null) {
    backgroundImage = NetworkImage(imageUrl);
  }

  return BoxDecoration(
    image: DecorationImage(
      image: backgroundImage,
      fit: BoxFit.cover,
      colorFilter: ColorFilter.mode(Color.fromRGBO(66, 66, 66, 0.68), BlendMode.srcOver),
    ),
    color: Theme.of(context).textTheme.body1.color,
  );
}