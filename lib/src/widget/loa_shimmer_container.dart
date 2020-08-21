import 'package:flutter/material.dart';
import 'package:flutter_base_app/src/utils/const.dart';
import 'package:shimmer/shimmer.dart';

class LoaShimmerContainer extends StatelessWidget {

  final Widget child;

  LoaShimmerContainer({@required this.child});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[100],
      highlightColor: Colors.grey[300],
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: SOFT_COLOR
        ),
        child: child,
      ),
    );
  }
}
