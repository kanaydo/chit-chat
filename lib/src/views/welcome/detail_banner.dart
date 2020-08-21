import 'package:flutter/material.dart';

class DetailBanner extends StatelessWidget {

  final String imgUrl;
  DetailBanner({
    @required this.imgUrl
  });

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        height: height,
        width: width,
        child: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Center(
            child: Hero(
              tag: 'imageHero',
              child: Image.network(
                imgUrl,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
