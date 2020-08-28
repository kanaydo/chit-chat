import 'package:flutter/material.dart';
import 'package:flutter_base_app/src/core/const/app_color.dart';
import 'package:flutter_base_app/src/data/model/member.dart';
import 'package:flutter_base_app/src/widget/loa_card.dart';

class UserProfileCard extends StatelessWidget {

  final Member member;

  UserProfileCard({@required this.member});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return LoaCard(
        child: Stack(
          children: <Widget>[
            Container(
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
                      Text(
                        member?.displayName == null ? '-' : member?.displayName,
                        style: textTheme.headline6.apply(
                            color: Colors.grey
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
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Row(
                              children: <Widget>[
                                Text(
                                  '${member?.currentPoints}',
                                  style: textTheme.headline4.apply(
                                      color: AppColor.BASE_COLOR
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            "berlaku hingga ${member?.validUntil == null ? '-' : member?.validUntil}",
                            style: textTheme.caption,
                          )
                        ],
                      )
                    ],
                  ),
                  Divider(
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          ],
        )
    );
  }
}
