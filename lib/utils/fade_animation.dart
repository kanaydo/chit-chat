/*
 * Created by Batara Kanaydo on 24/11/2020
 * email: batara.girsang@outlook.com
 * Copyright © 2020 Batara Kanaydo. All rights reserved.
 * Last modified 11/13/20, 8:49 PM
 */

import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:supercharged/supercharged.dart';

enum _AniProps { opacity, translateY }

class FadeAnimation extends StatelessWidget {
  final double delay;
  final Widget widget;

  FadeAnimation({@required this.delay, @required this.widget});

  @override
  Widget build(BuildContext context) {
    final tween = MultiTween<_AniProps>()
      ..add(_AniProps.opacity, 0.0.tweenTo(1.0))
      ..add(_AniProps.translateY, (-30.0).tweenTo(0.0));

    return PlayAnimation<MultiTweenValues<_AniProps>>(
      delay: (300 * delay).round().milliseconds,
      duration: 200.milliseconds,
      tween: tween,
      child: widget,
      builder: (context, child, value) => Opacity(
        opacity: value.get(_AniProps.opacity),
        child: Transform.translate(
          offset: Offset(0, value.get(_AniProps.translateY)),
          child: widget,
        ),
      ),
    );
  }
}