import 'package:flutter/material.dart';
import 'package:flutter_base_app/src/widget/loa_card.dart';
import 'package:shimmer/shimmer.dart';

class BannerShimmer extends StatelessWidget {
  final double height;
  BannerShimmer({@required this.height});
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
        padding: EdgeInsets.symmetric(vertical: 4),
        child: Shimmer.fromColors(
          child: ListView(
            shrinkWrap: true,
            physics: BouncingScrollPhysics(),
            children: [0, 1, 2].map((_) => Container(
              padding: EdgeInsets.symmetric(vertical: 4.0),
              width: double.infinity,
              height: height,
              child: LoaCard(
                  child: Container(
                    height: 30,
                    width: double.infinity,
                    color: Colors.white38,
                  )
              ),
            )).toList(),
          ),
          baseColor: Colors.grey[100],
          highlightColor: Colors.grey[300])
    );
  }
}
