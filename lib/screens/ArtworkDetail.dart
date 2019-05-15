import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class ArtworkDetail extends StatelessWidget {
  final String title;
  final String imageUrl;

  ArtworkDetail({
    @required this.title, 
    @required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(this.title),
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        child: PhotoView(
          imageProvider: NetworkImage(this.imageUrl),
        ),
      ),
      backgroundColor: Colors.transparent,
    );
  }

}
