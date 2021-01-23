/*
 * Created by Batara Kanaydo on 23/1/2021
 * email: batara.girsang@outlook.com
 * Copyright © 2021 Batara Kanaydo. All rights reserved.
 * Last modified 1/23/21 9:57 AM
 */

import 'package:flutter/material.dart';
import 'package:flutter_base_app/core/const/app_color.dart';
import 'package:flutter_base_app/data/model/conversation.dart';
import 'package:flutter_base_app/data/model/user.dart';
import 'package:flutter_base_app/widget/loa_image_bubble.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/chat_app_bar_cubit.dart';

class ChatAppBar extends StatelessWidget {
  final User friend;
  final int conversationId;

  ChatAppBar({
    @required this.friend,
    @required this.conversationId
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Row(
      children: [
        LoaImageBubble(url: friend.image),
        SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              friend.name,
              style: textTheme.bodyText1.apply(color: AppColor.BASE_COLOR),
            ),
            BlocProvider(
              create: (context) => ChatAppBarCubit(
                conversationId,
                friend.id,
                textTheme
              ),
              child: BlocBuilder<ChatAppBarCubit, ChatAppBarState>(
                builder: (buildContext, state) {
                  if(state is ChatAppBarIdle) {
                    return state.widget;
                  } else {
                    return Container();
                  }
                },
              ),
            )
          ],
        ),
      ],
    );
  }
}
