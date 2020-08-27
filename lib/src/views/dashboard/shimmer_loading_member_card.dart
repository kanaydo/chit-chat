import 'package:flutter/material.dart';
import 'package:flutter_base_app/src/core/app_color.dart';
import 'package:flutter_base_app/src/utils/banner_shimmer.dart';
import 'package:flutter_base_app/src/utils/fade_animation.dart';
import 'package:flutter_base_app/src/widget/loa_button.dart';
import 'package:flutter_base_app/src/widget/loa_card.dart';
import 'package:flutter_base_app/src/widget/loa_shimmer_container.dart';

class ShimmerLoadingMemberCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    Size screen = MediaQuery.of(context).size;
    return ListView(
      children: [
        LoaCard(
            child: Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Hello,',
                        style: textTheme.overline.apply(
                            color: Colors.grey
                        ),
                      ),
                      LoaShimmerContainer(
                        child: Text(
                          "adada",
                          style: textTheme.headline6.apply(
                              color: Colors.grey
                          ),
                        ),
                      ),
                    ],
                  ),
                  Divider(
                    color: AppColor.SOFT_COLOR,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Total Point',
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 10,
                            fontWeight: FontWeight.w300
                        ),
                      ),
                      LoaShimmerContainer(
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    color: Colors.grey,
                                    child: Text(
                                      '500',
                                      style: textTheme.headline4.apply(
                                          color: AppColor.BASE_COLOR
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Text(
                              'berlaku hingga 31-12-2020',
                              style: textTheme.caption,
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                  Divider(
                    color: Colors.white,
                  ),
                  LoaShimmerContainer(
                    child: LoaButton(
                        titleColor: Colors.white,
                        borderColor: Colors.white,
                        color: AppColor.BASE_COLOR,
                        minWidth: double.infinity,
                        title: 'TUKAR POIN', action: () {}
                    ),
                  )
                ],
              ),
            )
        ),
        FadeAnimation(
          delay: 1.3,
          widget: Padding(
            padding: const EdgeInsets.only(top: 16, bottom: 4),
            child: Text(
              'Banners',
              style: TextStyle(
                color: Colors.black54,
                fontSize: 10,
              ),
            ),
          ),
        ),
        BannerShimmer(height: screen.height / 3)
      ],
    );
  }
}
