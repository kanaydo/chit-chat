import 'package:flutter/material.dart';
import 'package:flutter_base_app/views/conversations/bloc/user_profile_cubit.dart';
import 'package:flutter_base_app/widget/loa_image_bubble.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return BlocProvider(
      create: (context) => UserProfileCubit(),
      child: BlocBuilder<UserProfileCubit, UserProfileState>(
        builder: (userContext, state) {
          if (state is UserProfileLoading) {
            return CircularProgressIndicator();
          } else if (state is UserProfileIdle) {
            return Row(
              children: [
                Text(
                  state.user.name,
                  style: textTheme.bodyText1,
                ),
                SizedBox(
                  width: 8,
                ),
                LoaImageBubble(url: state.user.image),
              ],
            );
          } else if (state is UserProfileError) {
            return Text(state.message);
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
