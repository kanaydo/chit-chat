import 'package:flutter/material.dart';
import 'package:flutter_base_app/src/widget/loa_card.dart';
import 'package:flutter_base_app/src/widget/loa_shimmer_container.dart';

class RewardShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    double height = MediaQuery.of(context).size.height;
    return ListView(
      shrinkWrap: true,
      physics: BouncingScrollPhysics(),
      children: [0, 1, 2].map((_) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: LoaCard(
          child: Container(
            child: Column(
              children: <Widget>[
                LoaShimmerContainer(
                  child: Container(
                    height: height / 5,
                    child: Container(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.bottomCenter,
                              colors: [
                            Colors.black.withOpacity(.6),
                            Colors.black.withOpacity(.1)
                          ])),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                          child: LoaShimmerContainer(
                            child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "caption",
                                style: textTheme.bodyText1,
                              ),
                              Text(
                                'reward time',
                                style:
                                    textTheme.caption.apply(color: Colors.grey),
                              ),
                            ],
                        ),
                          )
                      ),
                    ],
                  ),
                ),
              ],
            ),
              )),
      ))
          .toList(),
    );
  }
}
