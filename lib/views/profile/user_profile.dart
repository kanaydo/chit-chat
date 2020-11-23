import 'package:flutter/material.dart';
import 'package:flutter_base_app/core/const/app_color.dart';
import 'package:flutter_base_app/data/model/user.dart';
import 'package:flutter_base_app/widget/loa_text.dart';

class UserProfile extends StatelessWidget {
  final User user;
  UserProfile({this.user});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return ListView(
      children: [
        Center(
          child: CircleAvatar(
            radius: 52,
            backgroundColor: AppColor.BASE_COLOR,
            child: CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(user.image),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Center(
            child: Column(
              children: [
                Text(
                  user.name,
                  style: textTheme.headline6.apply(color: Colors.black),
                ),
                Text(
                  user.username == null ? '-' : user.username,
                  style: textTheme.overline,
                )
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Text(
                        'scan me',
                        style: textTheme.overline.apply(color: Colors.grey),
                      ),
                      Icon(Icons.qr_code),
                    ],
                  ),
                  Container(
                      height: 50,
                      child: VerticalDivider(
                        color: Colors.red,
                      )
                  ),
                  Column(
                    children: [
                      Text(
                        'contacts',
                        style: textTheme.overline.apply(color: Colors.grey),
                      ),
                      Icon(Icons.qr_code),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              LoaText(
                title: 'email',
                content: user.email == null ? "-" : user.email,
              ),
              LoaText(
                title: 'username',
                content: user.username == null ? '-' : user.username,
              )
            ],
          ),

        )
      ],
    );
  }
}
