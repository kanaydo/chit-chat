import 'package:flutter/material.dart';
import 'package:flutter_base_app/src/data/model/img_banner.dart';
import 'package:flutter_base_app/src/views/welcome/detail_banner.dart';

class BannerItem extends StatelessWidget {

  final ImgBanner banner;
  final double height;

  BannerItem({@required this.banner, @required this.height});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (_) {
          return DetailBanner(imgUrl: banner.imageUrl);
        }));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Card(
          margin: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                /*height: height / 1.5,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.fitWidth,
                      image: NetworkImage(banner.imageUrl)
                  ),
                )*/
                child: Wrap(
                  children: [
                    Image.network(banner.imageUrl)
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      banner.title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold
                      ),
                    ),
                    SizedBox(height: 4,),
                    Text(
                      banner.caption,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.black54
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      )
    );
  }

}
