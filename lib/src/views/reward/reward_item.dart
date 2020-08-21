import 'package:flutter/material.dart';
import 'package:flutter_base_app/src/data/model/reward.dart';
import 'package:flutter_base_app/src/utils/const.dart';
import 'package:flutter_base_app/src/views/redeem_confirm/redeem_page.dart';
import 'package:flutter_base_app/src/widget/loa_button.dart';
import 'package:flutter_base_app/src/widget/loa_card.dart';

class RewardItem extends StatelessWidget {

  final Reward reward;
  final double height;

  RewardItem({@required this.reward, @required this.height});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return LoaCard(
        child: Container(
          child: Column(
            children: <Widget>[
              Container(
                height: height / 4,
                width: double.infinity,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                          reward.imageUrl,
                        )
                    )
                ),
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                          decoration: BoxDecoration(
                              color: Colors.blueAccent.withOpacity(.6),
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(10)
                              )
                          ),
                          padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 8),
                          child: Text(
                            '${reward.requiredPoint} poin',
                            style: textTheme.bodyText2.apply(
                                color: Colors.white
                            ),
                          )
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                child: Row(
                  children: <Widget>[
                    Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              reward.caption,
                              style: textTheme.bodyText1,
                            ),
                            Text(
                              'batas penukaran ${reward.validDate}',
                              style: textTheme.caption.apply(
                                  color: Colors.grey
                              ),
                            ),
                          ],

                        )
                    ),
                    SizedBox(width: 8,),
                    LoaButton(
                        title: 'Tukar Sekarang',
                        color: BASE_COLOR,
                        borderColor: BASE_COLOR,
                        titleColor: Colors.white,
                        action: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => RedeemPage(reward: reward,)));
                        }
                    )
                  ],
                ),
              ),
            ],
          ),
        )
    );
  }
}
